# Document an R object

This function takes the name of an object (either an R function or an R
data.frame) and replaces it with skeleton roxygen2 documentation. It is
used in the `documenter_addin()` function which is the installed R
addin.

For **functions**, an empty `@param` is generated for each of the
funciton's arguments. For **dataframes**, a full `\description` block is
generated from column names

## Usage

``` r
documenter(objname, envir = NULL)

documenter_addin()
```

## Arguments

- objname:

  A character string naming an R function or data.frame.

- envir:

  An optional environment used to resolve `objname`. When supplied,
  documenteR looks only in that environment.

## Note

The addin will automatically source the file that the function or data
is in.

## Examples

``` r
documenter("lm")
#> [1] "\n#' @title FUNCTION_TITLE\n#'\n#' @description FUNCTION_DESCRIPTION\n#'\n#' @param formula DESCRIPTION.\n#' @param data DESCRIPTION.\n#' @param subset DESCRIPTION.\n#' @param weights DESCRIPTION.\n#' @param na.action DESCRIPTION.\n#' @param method DESCRIPTION.\n#' @param model DESCRIPTION.\n#' @param x DESCRIPTION.\n#' @param y DESCRIPTION.\n#' @param qr DESCRIPTION.\n#' @param singular.ok DESCRIPTION.\n#' @param contrasts DESCRIPTION.\n#' @param offset DESCRIPTION.\n#' @param ... DESCRIPTION.\n#'\n#' @return RETURN_DESCRIPTION\n#' @export\nlm"
#' @title FUNCTION_TITLE
#'
#' @description FUNCTION_DESCRIPTION
#'
#' @param formula DESCRIPTION.
#' @param data DESCRIPTION.
#' @param subset DESCRIPTION.
#' @param weights DESCRIPTION.
#' @param na.action DESCRIPTION.
#' @param method DESCRIPTION.
#' @param model DESCRIPTION.
#' @param x DESCRIPTION.
#' @param y DESCRIPTION.
#' @param qr DESCRIPTION.
#' @param singular.ok DESCRIPTION.
#' @param contrasts DESCRIPTION.
#' @param offset DESCRIPTION.
#' @param ... DESCRIPTION.
#'
#' @return RETURN DESCRIPTION
#' @export

documenter("iris")
#> [1] "\n#' DATASET_TITLE\n#'\n#' DATASET_DESCRIPTION\n#'\n#' @format A data frame with 150 rows and 5 variables:\n#' \\describe{\n#'   \\item{\\code{Sepal.Length}}{double. DESCRIPTION.}\n#'   \\item{\\code{Sepal.Width}}{double. DESCRIPTION.}\n#'   \\item{\\code{Petal.Length}}{double. DESCRIPTION.}\n#'   \\item{\\code{Petal.Width}}{double. DESCRIPTION.}\n#'   \\item{\\code{Species}}{factor. DESCRIPTION.}\n#' }\n\"iris\""
#' DATASET_TITLE
#'
#' DATASET_DESCRIPTION
#'
#' @format A data frame with 150 rows and 5 variables:
#' \describe{
#'   \item{\code{Sepal.Length}}{double. DESCRIPTION.}
#'   \item{\code{Sepal.Width}}{double. DESCRIPTION.}
#'   \item{\code{Petal.Length}}{double. DESCRIPTION.}
#'   \item{\code{Petal.Width}}{double. DESCRIPTION.}
#'   \item{\code{Species}}{factor. DESCRIPTION.}
#' }
```
