# Having only tested on macOS, because Stan results will only be exactly reproducible
#  if all of the following components are identical:
# Stan version
# Stan interface (RStan, PyStan, CmdStan) and version, plus version of interface language (R, Python, shell)
# versions of included libraries (Boost and Eigen)
# operating system version
# computer hardware including CPU, motherboard and memory
# C++ compiler, including version, compiler flags, and linked libraries
# same configuration of call to Stan, including random seed, chain ID, initialization and data

skip_on_cran()
skip_on_os(c("windows", "linux", "solaris"))

test_that("Within-subjects HDI width computed by (default) Method 1", {
  HDI <- rmHDI(data.wide = recall.wide, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.55911)
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
  expect_equal(width, 0.53212)
})

test_that("Within-subjects HDI width computed by Method 3", {
  HDI <- rmHDI(data.wide = recall.wide, method = 3, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.53395)
})

test_that("Within-subjects HDI width computed by Method 4", {
  HDI <- rmHDI(data.wide = recall.wide, method = 4, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.54586)
})

test_that("Within-subjects HDI width computed by Method 5", {
  HDI <- rmHDI(data.wide = recall.wide, method = 5, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.5296)
})

test_that("Within-subjects HDI width computed by Method 6", {
  HDI <- rmHDI(data.wide = recall.wide, method = 6, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.53185)
})

test_that("Standard HDI widths", {
  HDI <- rmHDI(data.wide = recall.wide, design = "between", seed = 277)
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(3.47993, 3.51281, 3.58275))
})
