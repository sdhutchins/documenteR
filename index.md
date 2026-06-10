# documenteR

An RStudio addin that builds the skeleton of documentation for an R
function or dataframe using roxygen2 syntax.

## Table of Contents

- [Project Background](#project-background)
- [Install & Setup](#install--setup)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)
- [Authors](#authors)

## Project Background

This addin has been modified from
[@mdlincoln](https://github.com/mdlincoln)’s
[docthis](https://github.com/mdlincoln/docthis) to fit more with
Hadley’s [notes on documenting R
packages](http://r-pkgs.had.co.nz/man.md).

## Install & Setup

- R (\>= 4.0)
- RStudio (for the addin)

### Instructions

Install from [r-universe](https://sdhutchins.r-universe.dev/documenteR):

``` r

install.packages(
  "documenteR",
  repos = c("https://sdhutchins.r-universe.dev", "https://cloud.r-project.org")
)
```

Development version from GitHub:

``` r

devtools::install_github("sdhutchins/documenteR")
```

## Usage

If you’ve written a function but haven’t created documentation for it,
select the function text and call the “Document an object” addin, which
will paste in skeleton roxygen2 documentation above your function
definition:

### Document a function

``` r

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

This will also work for a `data.frame`, which you *should* be thoroughly
documenting in `R/data.R`. Highlight the name of your `data.frame` and
call the addin.

``` r

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
"iris"
```

## Contributing

We welcome contributions! [See the docs for
guidelines](https://sdhutchins.github.io/documenteR/CONTRIBUTING.md).

Report bugs and request features on [GitHub
Issues](https://github.com/sdhutchins/documenteR/issues).

## License

View the [LICENSE](https://sdhutchins.github.io/documenteR/LICENSE) for
this project.

## Authors

- Shaurita D. Hutchins \| [email](mailto:sdhutchins@outlook.com) \|
  [sdhutchins](https://github.com/sdhutchins)
