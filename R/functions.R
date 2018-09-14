#' @title Document an R object
#'
#' @description This function takes the name of an object (either an R function or an R
#' data.frame) and replaces it with skeleton roxygen2 documentation. It is used in the \code{documenter_addin()} function which is the installed R addin.
#'
#' For \strong{functions}, an empty \code{@param} is generated for each of the funciton's arguments.
#' For \strong{dataframes}, a full \code{\\description} block is generated from column names
#'
#' @note The object \strong{must} be available within the evaulation environment.
#'
#' @param objname A character string naming an R function or data.frame.
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
#' #'   \item{\code{Species}}{integer. DESCRIPTION.}
#' #' }
#'
#' @export
documenter <- function(objname) {
  obj <- get(objname)
  if (is.function(obj)) {
    document_function(obj, label = objname)
  } else if (is.data.frame(obj)) {
    document_data(obj = obj, label = objname)
  } else {
    stop(objname, " is a ", class(obj), ". documenter_addin currently supports only functions and data.frames.")
  }
}

#' @rdname documenter
#'
#' @export
documenter_addin <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  objname <- strpquotes(context$selection[[1]]$text)
  rstudioapi::insertText(text = documenter(objname))
}

strpquotes <- function(t) {
  gsub("[\"']", "", t)
}

document_data <- function(obj, label) {
  # Get column names and types
  vartype <- vapply(obj, typeof, FUN.VALUE = character(1))

  # Write individual item description templates
  items <- paste0("#\'   \\item{\\code{", names(vartype), "}}{", vartype, ". DESCRIPTION.}", collapse = "\n")

  # Return the full documentation template
  paste0("
#\' DATASET_TITLE
#\'
#\' DATASET_DESCRIPTION
#\'
#\' @format A data frame with ", nrow(obj), " rows and ", length(vartype), " variables:
#\' \\describe{
", items, "
#\' }
\"", label, "\"")
}

document_function <- function(obj, label) {
  # Get the function arguments
  arglist <- formals(obj)
  argnames <- names(arglist)

  # Write individual parameter description templates
  params <- paste0("#\' @param ", argnames, " DESCRIPTION.", collapse = "\n")


  # Return the full documentation template
  paste0("
#\' @title FUNCTION_TITLE
#\'
#\' @description FUNCTION_DESCRIPTION
#\'
", params, "
#\'
#\' @return RETURN_DESCRIPTION
#\' @export
", label)
}
