context("documenter")

iris_docs <- "\n#' DATASET_TITLE\n#'\n#' DATASET_DESCRIPTION\n#'\n#' @format A data frame with 150 rows and 5 variables:\n#' \\describe{\n#'   \\item{\\code{Sepal.Length}}{double. DESCRIPTION.}\n#'   \\item{\\code{Sepal.Width}}{double. DESCRIPTION.}\n#'   \\item{\\code{Petal.Length}}{double. DESCRIPTION.}\n#'   \\item{\\code{Petal.Width}}{double. DESCRIPTION.}\n#'   \\item{\\code{Species}}{integer. DESCRIPTION.}\n#' }\n\"iris\""

lm_docs <- "\n#' @title FUNCTION_TITLE\n#'\n#' @description FUNCTION_DESCRIPTION\n#'\n#' @param formula DESCRIPTION.\n#' @param data DESCRIPTION.\n#' @param subset DESCRIPTION.\n#' @param weights DESCRIPTION.\n#' @param na.action DESCRIPTION.\n#' @param method DESCRIPTION.\n#' @param model DESCRIPTION.\n#' @param x DESCRIPTION.\n#' @param y DESCRIPTION.\n#' @param qr DESCRIPTION.\n#' @param singular.ok DESCRIPTION.\n#' @param contrasts DESCRIPTION.\n#' @param offset DESCRIPTION.\n#' @param ... DESCRIPTION.\n#'\n#' @return RETURN_DESCRIPTION\n#' @export\nlm"

test_that("object documentation is properly formatted", {
  expect_equivalent(documenter("iris"), iris_docs)
  expect_equivalent(documenter("lm"), lm_docs)
})

test_that("missing or invalid objects return an error", {
  expect_error(documenter("x"), regexp = "x")
  expect_error(documenter("month.name"), regexp = "character")
})
