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
skip_on_appveyor()
skip_on_ci()
skip_on_os(os=c("windows", "linux", "solaris"))
skip_on_os(os="mac", arch="aarch64")

test_that("Within-subjects HDI widths (for a heteroscedastic case)", {
  HDI <- rmHDI(data.wide = recall.wide, seed = 277, var.equal = FALSE)
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(0.40935, 0.55181, 0.54124))
})

test_that("Within-subjects HDI widths (for a heteroscedastic case) computed by Method 0", {
  HDI <- rmHDI(data.wide = recall.wide, method = 0, var.equal = FALSE)
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(0.35189, 0.52484, 0.47955))
})

test_that("Warning 5", {
  expect_warning(HDI <- rmHDI(data.wide = recall.wide, seed = 277, var.equal = FALSE, method = 5),
                           "A method option other than 0 or 1 is used with var.equal = FALSE and design = 'within'.
Thus, a pooled estimate of variability will be used just as method = 5 in the homoscedastic case.")
  width <- round(HDI$width, 5)
  expect_equal(width, 0.5296)
})

test_that("Standard HDI widths (for a heteroscedastic case)", {
  HDI <- rmHDI(data.wide = recall.wide, seed = 277, var.equal = FALSE, design = "between")
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(3.80204, 3.81443, 3.78565))
})
