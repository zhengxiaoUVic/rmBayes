test_that("Within-subjects HDI width computed by Method 1 (fixed treatment effects)", {
  HDI <- rmHDI(data.wide = recall.wide, seed = 277, treat = "fixed")
  width <- round(HDI$width, 5)
  expect_equal(width, 0.54856)
})

test_that("Within-subjects HDI width computed by Method 2 (fixed treatment effects)", {
  HDI <- rmHDI(data.wide = recall.wide, method = 2, seed = 277, treat = "fixed")
  width <- round(HDI$width, 5)
  expect_equal(width, 0.51931)
})

test_that("Within-subjects HDI width computed by Method 3 (fixed treatment effects)", {
  HDI <- rmHDI(data.wide = recall.wide, method = 3, seed = 277, treat = "fixed")
  width <- round(HDI$width, 5)
  expect_equal(width, 0.51773)
})

test_that("Standard HDI widths (fixed treatment effects)", {
  HDI <- rmHDI(data.wide = recall.wide, design = "between", seed = 277, treat = "fixed")
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(3.28239, 3.17515, 3.22356))
})
