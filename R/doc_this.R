#' Document this object
#'
#' This RStudio addin  takes \code{obj} (either an R function or an R
#' data.frame), and replaces it with some skeleton roxygen2 documentation.
#'
#' @export
doc_this_addin <- function() {
  context <- rstudioapi::getActiveDocumentContext()
  text <- context$selection[[1]]$text
  rstudioapi::insertText(text = doc_this(obj = get(text), label = text))
}

doc_this <- function(obj, label) {
  if(is.function(obj)) {
    stop("Not yet implemented.")
  } else if(is.data.frame(obj)) {
    doc_data(obj = obj, label = label)
  } else {
    stop(label, " is a ", class(obj), ". doc_this_addin currently supports only functions and data.frames")
  }
}

doc_data <- function(obj, label) {
  # Get column names and types
  vartype <- vapply(obj, typeof, FUN.VALUE = character(1))

  # Write individual item description templates
  items <- paste0("#\'   \\item{\\code{", names(vartype), "}}{", vartype, ". ###}", collapse = "\n")

  # Return the full documentation template
  paste0("
#\' DATASET TITLE
#\'
#\' DATASET DETAILS
#\'
#\' @format A data frame with ", nrow(obj), " rows and ", length(vartype), " variables:
#\' \\describe{
", items, "
#\' }
\"", label, "\"")
}
