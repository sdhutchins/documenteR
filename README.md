# docthis: Document this [object]

An RStudio addin that builds the skeleton of documentation for an R function or dataframe using the roxygen2 syntax.

## Installation

You will need to be running [RStudio v0.99.878 or later](https://www.rstudio.com/products/rstudio/download/preview/).

```r
devtools::install_github("mdlincoln/docthis")
```

## Usage

Say you've written a function (let's call it `lm`!) but haven't put together your documentation quite yet. Load the function into the current environment, select the function tile, and call the "Document object" addin, which will paste in some skeleton roxygen2 documentation above your function definition:

```r
#' FUNCTION TITLE
#'
#' FUNCTION DESCRIPTION
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
#' @examples
#' # ADD EXAMPLES HERE
lm <- function(.....
```

This will also work for data.frames, which you _should_ be thoroughly documenting in `R/data.R`.
Again, make sure the data.frame is available in the current environment, highlight its name, and call the addin:

```r
#' DATASET TITLE
#'
#' DATASET DESCRIPTION
#'
#' @format A data frame with 150 rows and 5 variables:
#' \describe{
#'   \item{\code{Sepal.Length}}{double. DESCRIPTION.}
#'   \item{\code{Sepal.Width}}{double. DESCRIPTION.}
#'   \item{\code{Petal.Length}}{double. DESCRIPTION.}
#'   \item{\code{Petal.Width}}{double. DESCRIPTION.}
#'   \item{\code{Species}}{integer. DESCRIPTION.}
#' }
"iris"
```

---
[Matthew Lincoln](http://matthewlincoln.net)
