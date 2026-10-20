test_that("plot_category_counts returns a ggplot", {
  plot <- plot_category_counts(iris, "Species")
  expect_s3_class(plot, "ggplot")
  expect_error(plot_category_counts(iris, "missing_col"), "one column")
})
