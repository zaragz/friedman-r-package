#' Plot counts of categories
#'
#' Makes a horizontal bar chart of the most frequent values of one column.
#' Missing values are shown as '(Missing)'.
#'
#' @param data A data frame.
#' @param column Name of the column as a character string.
#' @param top_n Maximum number of categories to plot (default 10).
#' @return A ggplot2 chart.
#' @examples
#' plot_category_counts(iris, "Species")
#' @export
#' @importFrom rlang .data
plot_category_counts <- function(data, column, top_n = 10L) {
  if (!is.data.frame(data)) {
    stop("data must be a data frame.", call. = FALSE)
  }
  if (!is.character(column) || length(column) != 1L ||
      is.na(column) || !(column %in% names(data))) {
    stop("column must name one column in data.", call. = FALSE)
  }
  if (!is.numeric(top_n) || length(top_n) != 1L || is.na(top_n) ||
      !is.finite(top_n) || top_n < 1 || top_n != floor(top_n)) {
    stop("top_n must be a positive whole number.", call. = FALSE)
  }
  if (nrow(data) == 0L) {
    stop("data must contain at least one row to plot.", call. = FALSE)
  }
  values <- as.character(data[[column]])
  values[is.na(values)] <- "(Missing)"
  tally <- utils::head(sort(table(values), decreasing = TRUE), top_n)
  counts <- data.frame(category = names(tally), n = as.integer(tally))
  counts$category <- factor(counts$category, levels = rev(counts$category))

  ggplot2::ggplot(counts, ggplot2::aes(x = .data$category, y = .data$n)) +
    ggplot2::geom_col(fill = "#21618C") +
    ggplot2::coord_flip() +
    ggplot2::labs(title = paste("Top categories:", column),
                  x = column, y = "Count") +
    ggplot2::theme_minimal()
}
