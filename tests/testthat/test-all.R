# Having only tested on macOS, because Stan results will only be exactly reproducible
#  if all of the following components are identical:
# Stan version
# Stan interface (RStan, PyStan, CmdStan) and version, plus version of interface language (R, Python, shell)
# versions of included libraries (Boost and Eigen)
# operating system version
# computer hardware including CPU, motherboard and memory
# C++ compiler, including version, compiler flags, and linked libraries
# same configuration of call to Stan, including random seed, chain ID, initialization and data

test_that("Test-all, for-loop", {
  options(warn=-1)
  for (method in 0:6) {
    for (var.equal in c(T, F)) {
      for (design in c("within", "between")) {
        for (treat in c("random", "fixed")) {
          for (diagnostics in c(F, T)) {
            test <- rmHDI(data.wide = recall.wide, seed = 277, method = method,
                          var.equal = var.equal, design = design, treat = treat,
                          diagnostics = diagnostics,
                          chain = 1, warmup = 5, iter = 10)
            expect_gte(length(test),3)
          }
        }
      }
    }
  }
  options(warn=0)
})
