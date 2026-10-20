test_that("data reports have the expected values", {
  d <- data.frame(x = c(1, NA, 3), y = c("a", "b", NA))
  report <- missing_report(d)
  expect_equal(nrow(report), 2L)
  expect_equal(report$missing, c(1L, 1L))
  expect_equal(report$missing_pct, c(33.33, 33.33))
  summary <- quick_summary(d)
  expect_equal(summary$non_missing, c(2L, 2L))
})

test_that("empty data frame and invalid inputs behave correctly", {
  expect_equal(nrow(quick_summary(data.frame())), 0L)
  expect_equal(nrow(missing_report(data.frame())), 0L)
  expect_error(quick_summary(1:4), "data frame")
})
