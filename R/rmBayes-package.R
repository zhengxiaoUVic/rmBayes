#' The 'rmBayes' package.
#'
#' @description Performing Bayesian Inference for Repeated-Measures Designs
#'
#' A Bayesian credible interval is interpreted with respect to posterior probability,
#' and this interpretation is far more intuitive than that of a frequentist confidence interval.
#' However, standard highest-density intervals can be wide due to between-subjects variability
#' and tends to hide within-subjects effects, rendering its relationship with the Bayes factor
#' less clear in within-subjects (repeated-measures) designs.
#' This urgent issue can be addressed by using within-subjects intervals in within-subjects designs,
#' which integretate the methods proposed in Loftus-Masson (1994) <doi:10.3758/BF03210951>,
#' Rouder-Morey-Speckman-Province (2012) <doi:10.1016/j.jmp.2012.08.001>,
#' Nathoo-Kilshaw-Masson (2018) <doi:10.1016/j.jmp.2018.07.005>,
#' and Heck (2019) <doi:10.31234/osf.io/whp8t>.
#'
#' @docType package
#' @name rmBayes-package
#' @aliases rmBayes
#' @useDynLib rmBayes, .registration = TRUE
#' @import methods
#' @import Rcpp
#' @importFrom rstan sampling
#'
#' @references Heck, D. W. (2019). Accounting for estimation uncertainty and shrinkage in Bayesian within-subject intervals: A comment on Nathoo, Kilshaw, and Masson (2018). Journal of Mathematical Psychology, 88, 27–31.
#'
#' Loftus, G. R., & Masson, M. E. J. (1994). Using confidence intervals in within-subject designs. Psychonomic Bulletin & Review, 1, 476–490.
#'
#' Nathoo, F. S., Kilshaw, R. E., & Masson, M. E. J. (2018). A better (Bayesian) interval estimate for within-subject designs. Journal of Mathematical Psychology, 86, 1–9.
#'
#' Rouder, J. N., Morey, R. D., Speckman, P. L., & Province, J. M. (2012). Default Bayes factors for ANOVA designs. Journal of Mathematical Psychology, 56, 356–374.
#'
#' Stan Development Team (2020). RStan: the R interface to Stan. R package version 2.21.2. https://mc-stan.org
#'
NULL
