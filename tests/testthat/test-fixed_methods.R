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

test_that("Within-subjects HDI width computed by Method 1 (fixed treatment effects)", {
  HDI <- rmHDI(data.wide = recall.wide, seed = 277, treat = "fixed")
  width <- round(HDI$width, 5)
  expect_equal(width, 0.56962)
})

test_that("Within-subjects HDI width computed by Method 2 (fixed treatment effects)", {
  HDI <- rmHDI(data.wide = recall.wide, method = 2, seed = 277, treat = "fixed")
  width <- round(HDI$width, 5)
  expect_equal(width, 0.53224)
})

test_that("Within-subjects HDI width computed by Method 3 (fixed treatment effects)", {
  HDI <- rmHDI(data.wide = recall.wide, method = 3, seed = 277, treat = "fixed")
  width <- round(HDI$width, 5)
  expect_equal(width, 0.53474)
})

test_that("Standard HDI widths (fixed treatment effects)", {
  HDI <- rmHDI(data.wide = recall.wide, design = "between", seed = 277, treat = "fixed")
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(3.21505, 3.23024, 3.22998))
})
