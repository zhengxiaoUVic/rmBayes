#' The 'rmBayes' package.
#'
#' @description Performing Bayesian Inference for Repeated-Measures Designs
#'
#' A Bayesian credible interval is interpreted with respect to posterior probability,
#' and this interpretation is far more intuitive than that of a frequentist confidence interval.
#' However, standard highest-density intervals can be wide due to between-subjects variability and tends
#' to hide within-subject effects, rendering its relationship with the Bayes factor less clear
#' in within-subject (repeated-measures) designs.
#' This urgent issue can be addressed by using within-subject intervals in within-subject designs,
#' which integrate four methods including the Wei-Nathoo-Masson (2023) <doi:10.3758/s13423-023-02295-1>,
#' the Loftus-Masson (1994) <doi:10.3758/BF03210951>,
#' the Nathoo-Kilshaw-Masson (2018) <doi:10.1016/j.jmp.2018.07.005>,
#' and the Heck (2019) <doi:10.31234/osf.io/whp8t> interval estimates.
#'
#' @docType package
#' @name rmBayes-package
#' @aliases rmBayes
#' @useDynLib rmBayes, .registration = TRUE
#' @import methods
#' @import Rcpp
#' @importFrom stats qt
#' @importFrom rstan sampling
#' @importFrom rstan summary
#' @importFrom RcppParallel RcppParallelLibs CxxFlags
#' @import rstantools
#'
#' @references Heck, D. W. (2019). Accounting for estimation uncertainty and shrinkage in Bayesian within-subject intervals: A comment on Nathoo, Kilshaw, and Masson (2018). Journal of Mathematical Psychology, 88, 27–31.
#'
#' Loftus, G. R., & Masson, M. E. J. (1994). Using confidence intervals in within-subject designs. Psychonomic Bulletin & Review, 1, 476–490.
#'
#' Nathoo, F. S., Kilshaw, R. E., & Masson, M. E. J. (2018). A better (Bayesian) interval estimate for within-subject designs. Journal of Mathematical Psychology, 86, 1–9.
#'
#' Rouder, J. N., Morey, R. D., Speckman, P. L., & Province, J. M. (2012). Default Bayes factors for ANOVA designs. Journal of Mathematical Psychology, 56, 356–374.
#'
#' Stan Development Team (2024). RStan: the R interface to Stan. R package version 2.32.5 https://mc-stan.org
#'
#' Wei, Z., Nathoo, F. S., & Masson, M. E. J. (2023). Investigating the relationship between the bayes factor and the separation of credible intervals. Psychonomic Bulletin & Review, 30, 1759–1781.
#'
NULL
