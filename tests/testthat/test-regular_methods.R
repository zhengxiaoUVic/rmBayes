test_that("Within-subjects HDI width computed by (default) Method 1", {
  HDI <- rmHDI(data.wide = recall.wide, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.53877)
})

test_that("Within-subjects HDI width computed by Method 0", {
  HDI <- rmHDI(data.wide = recall.wide, method = 0)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.4154)
})

test_that("Within-subjects HDI width computed by Method 2", {
  w <- capture_warnings(HDI <- rmHDI(data.wide = recall.wide, method = 2, seed = 277))
  expect_match(w, ".*treedepth", all = FALSE)
  expect_match(w, ".*pairs()", all = FALSE)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.51502)
})

test_that("Within-subjects HDI width computed by Method 3", {
  HDI <- rmHDI(data.wide = recall.wide, method = 3, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.51947)
})

test_that("Within-subjects HDI width computed by Method 4", {
  HDI <- rmHDI(data.wide = recall.wide, method = 4, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.53066)
})

test_that("Within-subjects HDI width computed by Method 5", {
  HDI <- rmHDI(data.wide = recall.wide, method = 5, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.51702)
})

test_that("Within-subjects HDI width computed by Method 6", {
  HDI <- rmHDI(data.wide = recall.wide, method = 6, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.51361)
})

test_that("Standard HDI widths", {
  HDI <- rmHDI(data.wide = recall.wide, design = "between", seed = 277)
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(3.44283, 3.43365, 3.48450))
})
