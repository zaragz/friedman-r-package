#' Detect potential outliers using the IQR rule
#'
#' Flags values below Q1 - multiplier * IQR or above Q3 + multiplier * IQR.
#' Missing values are ignored; indices refer to positions in the original vector.
#'
#' @param x An atomic numeric vector.
#' @param multiplier Positive numeric multiplier for the IQR (default 1.5).
#' @return A data frame with original indices and flagged values.
#' @examples
#' detect_outliers(c(1, 2, 2, 3, 100))
#' @export
detect_outliers <- function(x, multiplier = 1.5) {
  if (!is.numeric(x) || !is.atomic(x) || !is.null(dim(x))) {
    stop("x must be a numeric vector.", call. = FALSE)
  }
  if (any(is.infinite(x))) {
    stop("x must not contain infinite values.", call. = FALSE)
  }
  if (!is.numeric(multiplier) || length(multiplier) != 1L ||
      is.na(multiplier) || !is.finite(multiplier) || multiplier <= 0) {
    stop("multiplier must be one positive finite number.", call. = FALSE)
  }
  indexes <- which(!is.na(x))
  if (length(indexes) == 0L) {
    return(data.frame(index = integer(), value = numeric()))
  }
  clean <- x[indexes]
  q <- stats::quantile(clean, probs = c(0.25, 0.75), names = FALSE)
  spread <- q[2L] - q[1L]
  flagged <- clean < q[1L] - multiplier * spread |
    clean > q[2L] + multiplier * spread
  data.frame(index = indexes[flagged], value = clean[flagged], row.names = NULL)
}
