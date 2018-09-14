[![Travis build status](https://travis-ci.org/sdhutchins/documenteR.svg?branch=master)](https://travis-ci.org/sdhutchins/documenteR)

# documenteR

An RStudio addin that builds the skeleton of documentation for an R function or dataframe using roxygen2 syntax.

This addin has been modified from @mdlincoln's [docthis](https://github.com/mdlincoln/docthis) to fit more with Hadley's [notes on documenting R packages](http://r-pkgs.had.co.nz/man.html).


## Installation

```r
devtools::install_github("sdhutchins/documenteR")
```

## Examples

IF you've witten a function but haven't created documentation for it, select the function tile, and call the "Document an object" addin, which will paste in skeleton roxygen2 documentation above your function definition:

### Document a function

```r
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
```

### Document a dataframe

This will also work for a `data.frame`, which you _should_ be thoroughly documenting in `R/data.R`.
Highlight the name of your `data.frame` and call the addin.

```r
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
#'   \item{\code{Species}}{integer. DESCRIPTION.}
#' }
"iris"
```
