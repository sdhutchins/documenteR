iris_docs <- paste(
  "",
  "#' DATASET_TITLE",
  "#'",
  "#' DATASET_DESCRIPTION",
  "#'",
  "#' @format A data frame with 150 rows and 5 variables:",
  "#' \\describe{",
  "#'   \\item{\\code{Sepal.Length}}{double. DESCRIPTION.}",
  "#'   \\item{\\code{Sepal.Width}}{double. DESCRIPTION.}",
  "#'   \\item{\\code{Petal.Length}}{double. DESCRIPTION.}",
  "#'   \\item{\\code{Petal.Width}}{double. DESCRIPTION.}",
  "#'   \\item{\\code{Species}}{factor. DESCRIPTION.}",
  "#' }",
  "\"iris\"",
  sep = "\n"
)

lm_docs <- paste(
  "",
  "#' @title FUNCTION_TITLE",
  "#'",
  "#' @description FUNCTION_DESCRIPTION",
  "#'",
  "#' @param formula DESCRIPTION.",
  "#' @param data DESCRIPTION.",
  "#' @param subset DESCRIPTION.",
  "#' @param weights DESCRIPTION.",
  "#' @param na.action DESCRIPTION.",
  "#' @param method DESCRIPTION.",
  "#' @param model DESCRIPTION.",
  "#' @param x DESCRIPTION.",
  "#' @param y DESCRIPTION.",
  "#' @param qr DESCRIPTION.",
  "#' @param singular.ok DESCRIPTION.",
  "#' @param contrasts DESCRIPTION.",
  "#' @param offset DESCRIPTION.",
  "#' @param ... DESCRIPTION.",
  "#'",
  "#' @return RETURN_DESCRIPTION",
  "#' @export",
  "lm",
  sep = "\n"
)

local_lm_docs <- paste(
  "",
  "#' @title FUNCTION_TITLE",
  "#'",
  "#' @description FUNCTION_DESCRIPTION",
  "#'",
  "#' @param x DESCRIPTION.",
  "#'",
  "#' @return RETURN_DESCRIPTION",
  "#' @export",
  "lm",
  sep = "\n"
)

no_arg_docs <- paste(
  "",
  "#' @title FUNCTION_TITLE",
  "#'",
  "#' @description FUNCTION_DESCRIPTION",
  "#'",
  "#'",
  "#' @return RETURN_DESCRIPTION",
  "#' @export",
  "no_arg_fun",
  sep = "\n"
)

dots_only_docs <- paste(
  "",
  "#' @title FUNCTION_TITLE",
  "#'",
  "#' @description FUNCTION_DESCRIPTION",
  "#'",
  "#' @param ... DESCRIPTION.",
  "#'",
  "#' @return RETURN_DESCRIPTION",
  "#' @export",
  "dots_only_fun",
  sep = "\n"
)

empty_df_docs <- paste(
  "",
  "#' DATASET_TITLE",
  "#'",
  "#' DATASET_DESCRIPTION",
  "#'",
  "#' @format A data frame with 0 rows and 0 variables:",
  "#' \\describe{",
  "#' }",
  "\"empty_df\"",
  sep = "\n"
)

typed_df_docs <- paste(
  "",
  "#' DATASET_TITLE",
  "#'",
  "#' DATASET_DESCRIPTION",
  "#'",
  "#' @format A data frame with 2 rows and 4 variables:",
  "#' \\describe{",
  "#'   \\item{\\code{when}}{Date. DESCRIPTION.}",
  "#'   \\item{\\code{status}}{ordered factor. DESCRIPTION.}",
  "#'   \\item{\\code{updated_at}}{date-time. DESCRIPTION.}",
  "#'   \\item{\\code{notes}}{character. DESCRIPTION.}",
  "#' }",
  "\"typed_df\"",
  sep = "\n"
)

test_that("object documentation is properly formatted", {
  expect_equal(documenter("iris"), iris_docs)
  expect_equal(documenter("lm"), lm_docs)
})

test_that("documenter resolves objects from a supplied environment", {
  local_env <- list2env(
    list(
      lm = function(x) x
    ),
    parent = emptyenv()
  )

  expect_equal(documenter("lm", envir = local_env), local_lm_docs)
  expect_equal(documenter("\"lm\"", envir = local_env), local_lm_docs)
})

test_that("function templates handle empty and dots-only signatures", {
  local_env <- list2env(
    list(
      no_arg_fun = function() NULL,
      dots_only_fun = function(...) NULL
    ),
    parent = emptyenv()
  )

  expect_equal(documenter("no_arg_fun", envir = local_env), no_arg_docs)
  expect_equal(documenter("dots_only_fun", envir = local_env), dots_only_docs)
})

test_that("data frame templates use richer column type labels", {
  typed_df <- data.frame(
    when = as.Date(c("2024-01-01", "2024-01-02")),
    status = ordered(c("low", "high"), levels = c("low", "high")),
    updated_at = as.POSIXct(c("2024-01-01 09:00:00", "2024-01-01 10:00:00"), tz = "UTC"),
    notes = c("first", "second"),
    stringsAsFactors = FALSE
  )

  local_env <- list2env(
    list(
      empty_df = data.frame(),
      typed_df = typed_df
    ),
    parent = emptyenv()
  )

  expect_equal(documenter("empty_df", envir = local_env), empty_df_docs)
  expect_equal(documenter("typed_df", envir = local_env), typed_df_docs)
})

test_that("missing or invalid objects return an error", {
  expect_error(
    documenter("x"),
    class = "documenteR_missing_object",
    regexp = "Object 'x' was not found"
  )
  expect_error(
    documenter("month.name"),
    class = "documenteR_unsupported_object",
    regexp = "type 'character'"
  )
})
