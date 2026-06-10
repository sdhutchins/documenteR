#' @title Document an R object
#'
#' @description This function takes the name of an object (either an R function or an R
#' data.frame) and replaces it with skeleton roxygen2 documentation. It is used in the \code{documenter_addin()} function which is the installed R addin.
#'
#' For \strong{functions}, an empty \code{@param} is generated for each of the funciton's arguments.
#' For \strong{dataframes}, a full \code{\\description} block is generated from column names
#'
#' @note The addin will automatically source the file that the function or data is in.
#'
#' @param objname A character string naming an R function or data.frame.
#' @param envir An optional environment used to resolve \code{objname}. When
#'   supplied, documenteR looks only in that environment.
#'
#' @examples
#' documenter("lm")
#' #' @title FUNCTION_TITLE
#' #'
#' #' @description FUNCTION_DESCRIPTION
#' #'
#' #' @param formula DESCRIPTION.
#' #' @param data DESCRIPTION.
#' #' @param subset DESCRIPTION.
#' #' @param weights DESCRIPTION.
#' #' @param na.action DESCRIPTION.
#' #' @param method DESCRIPTION.
#' #' @param model DESCRIPTION.
#' #' @param x DESCRIPTION.
#' #' @param y DESCRIPTION.
#' #' @param qr DESCRIPTION.
#' #' @param singular.ok DESCRIPTION.
#' #' @param contrasts DESCRIPTION.
#' #' @param offset DESCRIPTION.
#' #' @param ... DESCRIPTION.
#' #'
#' #' @return RETURN DESCRIPTION
#' #' @export
#'
#' documenter("iris")
#' #' DATASET_TITLE
#' #'
#' #' DATASET_DESCRIPTION
#' #'
#' #' @format A data frame with 150 rows and 5 variables:
#' #' \describe{
#' #'   \item{\code{Sepal.Length}}{double. DESCRIPTION.}
#' #'   \item{\code{Sepal.Width}}{double. DESCRIPTION.}
#' #'   \item{\code{Petal.Length}}{double. DESCRIPTION.}
#' #'   \item{\code{Petal.Width}}{double. DESCRIPTION.}
#' #'   \item{\code{Species}}{factor. DESCRIPTION.}
#' #' }
#'
#' @export
documenter <- function(objname, envir = NULL) {
  objname <- strpquotes(objname)
  obj <- resolve_documented_object(objname = objname, envir = envir)

  document_object(obj = obj, label = objname)
}

document_object <- function(obj, label) {
  if (is.function(obj)) {
    document_function(obj, label = label)
  } else if (is.data.frame(obj)) {
    document_data(obj = obj, label = label)
  } else {
    abort_unsupported_object(objname = label, obj = obj)
  }
}

#' @rdname documenter
#'
#' @export
documenter_addin <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  # Evaluate the file in an isolated environment so documentation matches the
  # object definition the user just sourced, not another object on the search path.
  source_environment <- new.env(parent = globalenv())
  source(context$path, local = source_environment)
  objname <- strpquotes(context$selection[[1]]$text)
  rstudioapi::insertText(text = documenter(objname, envir = source_environment))
}

strpquotes <- function(t) {
  gsub("[\"']", "", t)
}

resolve_documented_object <- function(objname, envir = NULL) {
  if (is.null(envir)) {
    if (!exists(objname, inherits = TRUE)) {
      abort_missing_object(objname = objname)
    }

    return(get(objname, inherits = TRUE))
  }

  if (!exists(objname, envir = envir, inherits = FALSE)) {
    abort_missing_object(
      objname = objname,
      hint = "Select an object defined in the sourced file."
    )
  }

  get(objname, envir = envir, inherits = FALSE)
}

document_data <- function(obj, label) {
  # Use column classes when they add semantic meaning, such as factors or dates.
  vartype <- vapply(obj, column_type_label, FUN.VALUE = character(1))

  # Write individual item description templates
  if (length(vartype) == 0) {
    items <- character(0)
  } else {
    items <- paste0("#'   \\item{\\code{", names(vartype), "}}{", vartype, ". DESCRIPTION.}")
  }

  # Return the full documentation template
  roxygen_lines <- c(
    "",
    "#' DATASET_TITLE",
    "#'",
    "#' DATASET_DESCRIPTION",
    "#'",
    paste0("#' @format A data frame with ", nrow(obj), " rows and ", length(vartype), " variables:"),
    "#' \\describe{",
    items,
    "#' }",
    paste0("\"", label, "\"")
  )

  paste(roxygen_lines, collapse = "\n")
}

document_function <- function(obj, label) {
  # Get the function arguments
  arglist <- formals(obj)
  argnames <- names(arglist)

  # Write individual parameter description templates
  if (length(argnames) == 0) {
    params <- character(0)
  } else {
    params <- paste0("#\' @param ", argnames, " DESCRIPTION.")
  }

  # Return the full documentation template
  roxygen_lines <- c(
    "",
    "#' @title FUNCTION_TITLE",
    "#'",
    "#' @description FUNCTION_DESCRIPTION",
    "#'",
    params,
    "#'",
    "#' @return RETURN_DESCRIPTION",
    "#' @export",
    label
  )

  paste(roxygen_lines, collapse = "\n")
}

column_type_label <- function(column) {
  if (inherits(column, "ordered")) {
    return("ordered factor")
  }

  if (is.factor(column)) {
    return("factor")
  }

  if (inherits(column, "POSIXt")) {
    return("date-time")
  }

  if (inherits(column, "Date")) {
    return("Date")
  }

  if (is.logical(column)) {
    return("logical")
  }

  if (is.integer(column)) {
    return("integer")
  }

  if (is.double(column)) {
    return("double")
  }

  if (is.character(column)) {
    return("character")
  }

  if (is.complex(column)) {
    return("complex")
  }

  if (is.raw(column)) {
    return("raw")
  }

  if (is.list(column)) {
    return("list")
  }

  typeof(column)
}

abort_missing_object <- function(objname, hint = "Select or name an object that exists in the current session.") {
  abort_documenter_error(
    message = paste0("Object '", objname, "' was not found. ", hint),
    class = "documenteR_missing_object",
    objname = objname
  )
}

abort_unsupported_object <- function(objname, obj) {
  abort_documenter_error(
    message = paste0(
      "Object '", objname, "' has type '", object_type_label(obj),
      "'. documenteR currently supports only functions and data.frames."
    ),
    class = "documenteR_unsupported_object",
    objname = objname,
    object_type = object_type_label(obj)
  )
}

abort_documenter_error <- function(message, class, ...) {
  stop(
    structure(
      list(message = message, call = NULL, ...),
      class = c(class, "documenteR_error", "error", "condition")
    )
  )
}

object_type_label <- function(obj) {
  class_vector <- class(obj)

  if (length(class_vector) == 0) {
    return(typeof(obj))
  }

  paste(class_vector, collapse = "/")
}
