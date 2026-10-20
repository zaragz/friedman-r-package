test_that("summary_stats calculates statistics and handles missing values", {
  result <- summary_stats(c(1, 2, 3, NA))
  expect_equal(result$n, 3)
  expect_equal(result$missing, 1)
  expect_equal(result$mean, 2)
  expect_equal(result$median, 2)
  expect_equal(result$sd, 1)
})

test_that("summary_stats handles empty and invalid input", {
  expect_true(is.na(summary_stats(numeric())$mean))
  expect_true(is.na(summary_stats(c(1, NA))$sd))
  expect_error(summary_stats(letters), "numeric vector")
  expect_error(summary_stats(c(1, Inf)), "infinite")
})
