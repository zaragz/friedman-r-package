#' Summarize a numeric vector
#'
#' Returns one row with basic numeric statistics, excluding missing observations.
#' Standard deviation is `NA` when fewer than two non-missing values are present.
#'
#' @param x An atomic numeric vector.
#' @return A one-row data frame with observation counts and summary statistics.
#' @examples
#' summary_stats(c(1, 2, 3, 4, 5, NA))
#' @export
summary_stats <- function(x) {
  if (!is.numeric(x) || !is.atomic(x) || !is.null(dim(x))) {
    stop("x must be a numeric vector.", call. = FALSE)
  }
  if (any(is.infinite(x))) {
    stop("x must not contain infinite values.", call. = FALSE)
  }

  values <- x[!is.na(x)]
  n <- length(values)
  data.frame(
    n = n,
    missing = sum(is.na(x)),
    mean = if (n) mean(values) else NA_real_,
    median = if (n) stats::median(values) else NA_real_,
    min = if (n) min(values) else NA_real_,
    max = if (n) max(values) else NA_real_,
    sd = if (n >= 2L) stats::sd(values) else NA_real_
  )
}
