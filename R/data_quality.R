#' Summarize the structure of a data frame
#'
#' Returns one row per variable, including type and missingness. The result has
#' zero rows if the input data frame has no columns.
#'
#' @param data A data frame.
#' @return A data frame with column, type, non_missing, missing, and missing_pct.
#' @examples
#' quick_summary(airquality)
#' @export
quick_summary <- function(data) {
  if (!is.data.frame(data)) {
    stop("data must be a data frame.", call. = FALSE)
  }
  if (ncol(data) == 0L) {
    return(data.frame(column = character(), type = character(),
                      non_missing = integer(), missing = integer(),
                      missing_pct = numeric()))
  }
  n_missing <- vapply(data, function(column) sum(is.na(column)), integer(1))
  n_rows <- nrow(data)
  data.frame(
    column = names(data),
    type = vapply(data, function(column) class(column)[1L], character(1)),
    non_missing = n_rows - unname(n_missing),
    missing = unname(n_missing),
    missing_pct = if (n_rows) round(100 * unname(n_missing) / n_rows, 2) else 0,
    row.names = NULL
  )
}

#' Report missing values by variable
#'
#' Lists missing-value counts and percentages, sorted by missing count.
#'
#' @param data A data frame.
#' @return A data frame with column, missing, and missing_pct.
#' @examples
#' missing_report(airquality)
#' @export
missing_report <- function(data) {
  summary <- quick_summary(data)
  report <- summary[c("column", "missing", "missing_pct")]
  report[order(-report$missing, report$column), , drop = FALSE]
}
