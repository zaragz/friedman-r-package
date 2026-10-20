# Friedman: Exploratory Data Analysis Tools in R

A small, reusable R package for dataset summaries, missing-data reports, numerical summaries, IQR-based outlier checks, and categorical visualizations.

**Built with:** R, R package development, roxygen2, ggplot2, testthat.

## Background

I originally created the **Friedman** package for the University of South Florida's Advanced R Programming coursework (Spring 2026). This repository is a **portfolio extension** of that original exercise: it retains the `summary_stats()` function and adds data-quality utilities, plotting, validation, and automated tests.

The original coursework is available in my [Advanced R Programming repository](https://github.com/zaragz/advanced-r-programmin-/tree/main/assignments/module-10-r-package/Friedman). My separate [S3/S4 coursework](https://github.com/zaragz/advanced-r-programmin-/tree/main/assignments/module-07-s3-s4-oop) demonstrates object-oriented programming concepts; those classes are **not** part of this package.

## Functions

| Function | Purpose |
| --- | --- |
| `summary_stats(x)` | Basic statistics for a numeric vector, including missing counts |
| `quick_summary(data)` | Column types, non-missing counts, and missing percentages |
| `missing_report(data)` | Missing-value counts and percentages per variable |
| `detect_outliers(x)` | Potential outliers based on the 1.5×IQR rule |
| `plot_category_counts(data, column)` | Bar chart of the most frequent categories |

## Installation

Install the development version directly from GitHub:

```r
install.packages("remotes")  # only needed once
remotes::install_github("zaragz/friedman-r-package")
library(Friedman)
```

## Example usage

```r
library(Friedman)

# Numeric summaries and missingness
summary_stats(c(1, 2, 3, 4, 5, NA))
quick_summary(airquality)
missing_report(airquality)

# Identify unusual values (exploratory check, not automatic data removal)
detect_outliers(c(1, 2, 2, 2, 3, 100))

# Create a categorical frequency plot
plot_category_counts(iris, "Species")
```

## Package structure

```text
friedman-r-package/
├── DESCRIPTION
├── NAMESPACE
├── R/
│   ├── summary_stats.R
│   ├── data_quality.R
│   ├── outliers.R
│   └── visualization.R
├── man/
├── tests/
│   └── testthat/
├── .Rbuildignore
├── .gitignore
└── README.md
```

## Development and tests

From the package's root directory in RStudio:

```r
install.packages(c("devtools", "roxygen2", "testthat"))  # first time only
devtools::document()   # refresh documentation and NAMESPACE
devtools::test()       # run automated tests
devtools::check()      # check package structure and dependencies
```

**Verification:** Automated tests are provided, but this package should be tested in a local R environment before being described as verified or production-ready.

## Author

**Zara Gonzalez** — University of South Florida, Information Science (Data Science & Analytics)

[GitHub profile](https://github.com/zaragz)
