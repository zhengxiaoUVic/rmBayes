# Having only tested on macOS, because Stan results will only be exactly reproducible
#  if all of the following components are identical:
# Stan version
# Stan interface (RStan, PyStan, CmdStan) and version, plus version of interface language (R, Python, shell)
# versions of included libraries (Boost and Eigen)
# operating system version
# computer hardware including CPU, motherboard and memory
# C++ compiler, including version, compiler flags, and linked libraries
# same configuration of call to Stan, including random seed, chain ID, initialization and data

test_that("Error handling - empty", {
  expect_error(rmHDI(),
               "Invalid input: Data may contain NA or Inf.")
})

test_that("Error handling - method arg", {
  expect_error(rmHDI(data.wide = recall.wide, method = -1),
               "should be one of")
})

test_that("Error handling - design arg", {
  expect_error(rmHDI(data.wide = recall.wide, design = "mixed"),
               "should be one of")
})

test_that("Error handling - treat arg", {
  expect_error(rmHDI(data.wide = recall.wide, treat = "mixed"),
               "should be one of")
})

test_that("Error handling - cred arg", {
  expect_error(rmHDI(data.wide = mat, cred = 1.00001),
               "'cred' must be a single number between 0 and 1")
})

test_that("Error handling - ht arg", {
  expect_error(rmHDI(data.wide = mat, ht = -1),
               "'ht' must be a single positive number")
})

test_that("Error handling - hb arg", {
  expect_error(rmHDI(data.wide = mat, hb = -1),
               "'hb' must be a single positive number")
})

test_that("Error handling - whichSubject arg", {
  expect_error(rmHDI(df, whichSubject = 2),
               "'whichSubject' must be a single character string")
})

test_that("Error handling - whichLevel arg", {
  expect_error(rmHDI(df, whichLevel = 2),
               "'whichLevel' must be a single character string")
})

test_that("Error handling - whichResponse arg", {
  expect_error(rmHDI(df, whichResponse = 2),
               "'whichResponse' must be a single character string")
})

test_that("Error handling - missing value, wide", {
  mat_missing.value <- recall.wide #unbalanced wide format data (missing value, NA)
  mat_missing.value[3,1] <- NA
  expect_error(rmHDI(data.wide = mat_missing.value),
               "Invalid input: Data may contain NA or Inf.")
  skip_on_cran()
  skip_on_os(c("windows", "linux", "solaris"))
  HDI <- rmHDI(data.wide = mat_missing.value, seed = 277, design = "between")
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(3.73764, 3.48642, 3.59351))
})

test_that("Error handling - missing value, long", {
  df_missing.value <- recall.long #unbalanced long format data (missing value, NA)
  df_missing.value[3,3] <- NA
  expect_error(rmHDI(df_missing.value),
               "Invalid input: Data may contain NA or Inf.")
  skip_on_cran()
  skip_on_os(c("windows", "linux", "solaris"))
  HDI <- rmHDI(df_missing.value, seed = 277, design = "between")
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(3.73764, 3.48642, 3.59351))
})

test_that("unbalanced, long", {
  skip_on_cran()
  skip_on_os(c("windows", "linux", "solaris"))
  df_unbalanced <- recall.long #unbalanced long format data (no NA)
  df_unbalanced <- df_unbalanced[-3,]
  HDI <- rmHDI(df_unbalanced, seed = 277, design = "between")
  width <- unname(round(HDI$width, 5))
  expect_equal(width, c(3.73764, 3.48642, 3.59351))
})

test_that("Error handling - rename, long", {
  df_col.rename <- recall.long
  colnames(df_col.rename)[2] <- "Condition"
  expect_error(rmHDI(df_col.rename, seed = 277, whichLevel = "Level"),
               "Long format data do not contain the column name Level")
  expect_error(rmHDI(df_col.rename, seed = 277, whichSubject = "Participant"),
               "Long format data do not contain the column name Participant")
  expect_error(rmHDI(df_col.rename, seed = 277, whichLevel = "Condition", whichResponse = "DV"),
               "Long format data do not contain the column name DV")
  skip_on_cran()
  skip_on_os(c("windows", "linux", "solaris"))
  HDI <- rmHDI(df_col.rename, seed = 277, whichLevel = "Condition")
  width <- unname(round(HDI$width, 5))
  expect_equal(width, 0.55911)
})

test_that("no column names, wide", {
  skip_on_cran()
  skip_on_os(c("windows", "linux", "solaris"))
  mat_nocolname <- recall.wide
  colnames(mat_nocolname) <- NULL
  HDI <- rmHDI(data.wide = mat_nocolname, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.55911)
})

test_that("bad column names, wide", {
  skip_on_cran()
  skip_on_os(c("windows", "linux", "solaris"))
  mat_badcolname <- recall.wide
  colnames(mat_badcolname) <- c("Level1","","Level3")
  HDI <- rmHDI(data.wide = mat_badcolname, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.55881)
})

test_that("missing any column names, wide", {
  skip_on_cran()
  skip_on_os(c("windows", "linux", "solaris"))
  mat_misscolname <- recall.wide
  colnames(mat_misscolname) <- c("Level1",NA,"Level3")
  HDI <- rmHDI(data.wide = mat_misscolname, seed = 277)
  width <- round(HDI$width, 5)
  expect_equal(width, 0.56046)
})

test_that("Error handling - missing one column, wide", {
  mat_missONEcol <- recall.wide
  mat_missONEcol[,1] <- NA
  expect_error(rmHDI(data.wide = mat_missONEcol, seed = 277, design = "between"),
               "Invalid input: Data may contain a missing column.")
  expect_error(rmHDI(data.wide = mat_missONEcol, seed = 277, design = "between", var.equal = FALSE),
               "Invalid input: Data may contain a missing column.")
})

test_that("Error handling - single level", {
  expect_error(rmHDI(data.wide = recall.wide[,1], seed = 277),
               "Number of conditions should be greater than one.")
})

test_that("Warning 1", {
  expect_warning(rmHDI(recall.long, design = "between", seed = 277, method = 2),
                 "Standard highest-density intervals method does not require specifying")
})

test_that("Warning 2", {
  expect_warning(rmHDI(recall.long, design = "between", seed = 277, method = 0),
                 "Within-subjects highest-density intervals are constructed by method 0, which does not require specifying")
})

test_that("Warning 3", {
  expect_warning(rmHDI(recall.long, var.equal =  FALSE, seed = "277", hb = 2),
                 "Current method for the within-subjects highest-density intervals")
})

test_that("Warning 5", {
  expect_warning(rmHDI(recall.long, method = 4, seed = "277", ht = 2),
                 "Method 4 does not require specifying")
})

test_that("Warning 6", {
  expect_warning(rmHDI(recall.long, method = 5, seed = "277", hb = 2),
                 "Method 5 does not require specifying")
})

test_that("Warning 7", {
  expect_warning(rmHDI(recall.long, method = 6, seed = "277", hb = 2),
                 "Method 6 does not require specifying")
})

test_that("Diagnostics of within-subjects HDI", {
  expect_equal(length(rmHDI(data.wide = recall.wide, seed = 277, diagnostics = TRUE)), 4)
})

test_that("Diagnostics of standard HDI", {
  expect_equal(length(rmHDI(data.wide = recall.wide, seed = 277, design = "between", diagnostics = TRUE)), 4)
})
