test_that("detect_outliers identifies unusual values", {
  result <- detect_outliers(c(1, 2, 2, 2, 3, 100, NA))
  expect_equal(result$index, 6L)
  expect_equal(result$value, 100)
})

test_that("detect_outliers handles edge cases", {
  expect_equal(nrow(detect_outliers(c(NA_real_, NA_real_))), 0L)
  expect_error(detect_outliers(letters), "numeric vector")
  expect_error(detect_outliers(1:3, multiplier = 0), "positive finite")
})
