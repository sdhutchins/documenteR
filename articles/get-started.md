# Get Started

`documenteR` helps you draft roxygen2 documentation for functions and
data frames. You can use it from the RStudio addin or call
[`documenter()`](https://sdhutchins.github.io/documenteR/reference/documenter.md)
directly.

## Install

``` r

install.packages(
  "documenteR",
  repos = c("https://sdhutchins.r-universe.dev", "https://cloud.r-project.org")
)
```

## Using the Addin Manually

Open a script that defines a function or data frame, highlight the
object name, and run the “Document an object” addin.

The addin sources the current file, finds the selected object, and
inserts a roxygen2 skeleton above it.

## Using the Addin Programmatically

You can also generate the documentation template directly from the
console.

``` r

documenteR::documenter("lm")
#> [1] "\n#' @title FUNCTION_TITLE\n#'\n#' @description FUNCTION_DESCRIPTION\n#'\n#' @param formula DESCRIPTION.\n#' @param data DESCRIPTION.\n#' @param subset DESCRIPTION.\n#' @param weights DESCRIPTION.\n#' @param na.action DESCRIPTION.\n#' @param method DESCRIPTION.\n#' @param model DESCRIPTION.\n#' @param x DESCRIPTION.\n#' @param y DESCRIPTION.\n#' @param qr DESCRIPTION.\n#' @param singular.ok DESCRIPTION.\n#' @param contrasts DESCRIPTION.\n#' @param offset DESCRIPTION.\n#' @param ... DESCRIPTION.\n#'\n#' @return RETURN_DESCRIPTION\n#' @export\nlm"
```

That returns a roxygen2 skeleton with one `@param` line for each
function argument.

## Example: document a data frame

For data frames, `documenteR` creates a `@format` block with one entry
per column.

``` r

documenteR::documenter("iris")
#> [1] "\n#' DATASET_TITLE\n#'\n#' DATASET_DESCRIPTION\n#'\n#' @format A data frame with 150 rows and 5 variables:\n#' \\describe{\n#'   \\item{\\code{Sepal.Length}}{double. DESCRIPTION.}\n#'   \\item{\\code{Sepal.Width}}{double. DESCRIPTION.}\n#'   \\item{\\code{Petal.Length}}{double. DESCRIPTION.}\n#'   \\item{\\code{Petal.Width}}{double. DESCRIPTION.}\n#'   \\item{\\code{Species}}{factor. DESCRIPTION.}\n#' }\n\"iris\""
```

Column types are labeled with data-aware names where possible. For
example, factors stay `factor` instead of falling back to their
underlying integer storage mode.
