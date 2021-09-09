# roughly 3 minutes to run on 112 scenarios

skip_on_cran()
skip_on_ci()
options(warn=-1)

test_that("executable", {
  for (method in 0:6) {
    for (var.equal in c(TRUE, FALSE)) {
      for (design in c("within", "between")) {
        for (treat in c("random", "fixed")) {
          for (diagnostics in c(FALSE, TRUE)) {
            test <- rmHDI(data.wide = recall.wide, seed = 277, method = method,
                          var.equal = var.equal, design = design, treat = treat,
                          diagnostics = diagnostics)
            expect_gte(length(test), 3)
          }
        }
      }
    }
  }

})

options(warn=1)
