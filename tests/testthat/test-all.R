# roughly 21 minutes to run on 672 scenarios

skip_on_cran()
skip_on_travis()
options(warn=-1)

test_that("executable", {
  for (method in 0:6) {
    for (var.equal in c(TRUE, FALSE)) {
      for (design in c("within", "between")) {
        for (treat in c("random", "fixed")) {
          for (ht in c(1, 0.5, 1.1)) {
            for (hb in c(1, 1.1)) {
              for (diagnostics in c(FALSE, TRUE)) {
                test <- rmHDI(data.wide = recall.wide, seed = 277, method = method,
                              var.equal = var.equal, design = design, treat = treat,
                              ht = ht, hb = hb, diagnostics = diagnostics)
                expect_gte(length(test), 3)
              }
            }
          }
        }
      }
    }
  }

})

options(warn=1)
