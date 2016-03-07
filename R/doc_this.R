#' Document this object
#'
#' This RStudio addin takes the name of an object (either an R function or an R
#' data.frame), and replaces it with some skeleton roxygen2 documentation.
#'
#' For functions, empty \code{@param}s are generated from the function's arguments, while for dataframes a full \code{\\description} block is generated from column names
#'
#' @note The object must be available within the evaulation environment.
#'
#' @param obj Either an R function or data.frame (the addin gets this object
#'   from the selected text, which is itself passed to \code{text}.)
#' @name doc_this
NULL

#' @rdname doc_this
#' @export
doc_this_addin <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text
  rstudioapi::insertText(text = doc_this(obj = get(text)))
}
#' @rdname doc_this
#' @examples
#' doc_this(lm)
#' #' FUNCTION TITLE
#' #'
#' #' FUNCTION DESCRIPTION
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
#' #' @examples
#' #' ADD EXAMPLES HERE
#'
#' doc_this(iris)
#' #' DATASET TITLE
#' #'
#' #' DATASET DESCRIPTION
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
doc_this <- function(obj) {
  label <- deparse(substitute(obj))
  if(is.function(obj)) {
    doc_function(obj, label)
  } else if(is.data.frame(obj)) {
    doc_data(obj = obj, label = label)
  } else {
    stop(label, " is a ", class(obj), ". doc_this_addin currently supports only functions and data.frames")
  }
}

#' @rdname doc_this
#' @export
doc_data <- function(obj, label) {
  # Get column names and types
  vartype <- vapply(obj, typeof, FUN.VALUE = character(1))

  # Write individual item description templates
  items <- paste0("#\'   \\item{\\code{", names(vartype), "}}{", vartype, ". DESCRIPTION.}", collapse = "\n")

  # Return the full documentation template
  paste0("
#\' DATASET TITLE
#\'
#\' DATASET DESCRIPTION
#\'
#\' @format A data frame with ", nrow(obj), " rows and ", length(vartype), " variables:
#\' \\describe{
", items, "
#\' }
\"", label, "\"")
}

doc_function <- function(obj, label) {
  # Get the function arguments
  arglist <- formals(obj)
  argnames <- names(arglist)

  # Write individual parameter description templates
  params <- paste0("#\' @param ", argnames, " DESCRIPTION.", collapse = "\n")


  # Return the full documentation template
  paste0("
#\' FUNCTION TITLE
#\'
#\' FUNCTION DESCRIPTION
#\'
", params, "
#\'
#\' @return RETURN DESCRIPTION
#\' @examples
#\' ADD EXAMPLES HERE
", label)
}
