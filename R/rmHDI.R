#' Bayesian Interval Estimation for Repeated-Measures Designs
#'
#'For both the homoscedastic and heteroscedastic cases in one-way within-subjects (repeated-measures) designs,
#'this function provides multiple methods to construct the credible intervals for condition means, with each method based on different sets of priors.
#'The emphasis is on the calculation of intervals that remove the between-subjects variability that is a nuisance in within-subjects designs
#'proposed in Loftus and Masson (1994), the Bayesian analog proposed in Nathoo, Kilshaw, and Masson (2018), and the adaptation presented in Heck (2019).
#'
#'We consider three credible intervals:
#'(1) the within-subjects Bayesian interval developed by Nathoo, Kilshaw, and Masson (2018),
#'whose derivation conditions on estimated random effects,
#'(2) a modification of (1) based on a proposal by Heck (2019) to allow for shrinkage and account for estimation uncertainty,
#'and (3) an alternative to option (2) based on the default priors used in Rouder, Morey, Speckman, and Province (2012).
#'Markov chain Monte Carlo sampling is also used to obtain the standard highest-density interval (HDI)
#'for each condition mean in a one-way between-subjects design.
#'
#'When the homogeneity of variance holds,
#'a linear mixed-effects model \eqn{M_1} for the mean response in a one-way within-subjects design is
#'\deqn{M_1: Y_{ij} = \mu + \sigma_\epsilon (t_i + b_j) + \epsilon_{ij}  versus  M_0: Y_{ij} = \mu + \sigma_\epsilon b_j + \epsilon_{ij},  \epsilon_{ij} ~ N(0, \sigma_\epsilon^2),  i=1,\ldots,a; j=1,\ldots,n,}
#'where \eqn{Y_ij} represents the mean response for the \eqn{j}-th
#'subject under the \eqn{i}-th level of the experimental manipulation;
#'\eqn{\mu} is the overall mean, \eqn{\tau_i = \sigma_\epsilon t_i} is the \eqn{i}-th level of the experimental manipulation;
#'\eqn{\mu_i = \mu + \tau_i}, for the means model, is the \eqn{i}-th condition mean;
#'\eqn{b_j} is the standardized subject-specific random effects;
#'\eqn{a} is the number of levels; \eqn{n} is the number of subjects;
#'\eqn{\epsilon_{ij}} are independent and identically distributed.
#'The effects \eqn{t_i} and \eqn{b_j} are both standardized relative to the standard deviation of the error \eqn{\sigma_\epsilon} and become dimensionless (Rouder et al., 2012).
#'
#'An assumption articulated in \code{method=0} is the Jeffreys prior for the condition means \eqn{\mu_i} and residual variance \eqn{\sigma_\epsilon^2} (Nathoo et al., 2018).
#'
#'Priors used in \code{method=1} are the Jeffreys prior for the overall mean \eqn{\mu} and residual variance,
#'a \eqn{g}-prior structure for standardized effects (\eqn{t_i ~ N(0, g_t)}, \eqn{b_j ~ N(0, g_b)}),
#'and independent scaled inverse-chi-square priors with one degree of freedom for
#'the scale hyperparameters of the \eqn{g}-priors (\eqn{g_t ~ Scale-inv-\chi^2(1, h_t^2)}, \eqn{g_b ~ Scale-inv-\chi^2(1, h_b^2)}).
#'
#'Priors used in \code{method=2} are the Jeffreys prior for the overall mean and residual variance,
#'a normal distribution for (not standardized) effects (\eqn{\sigma_\epsilon t_i ~ N(0, g_t)}, \eqn{\sigma_\epsilon b_j ~ N(0, g_b)}),
#'and the standard uniform distribution for
#'the square root of \eqn{g} parameter (\eqn{sqrt(g_t) ~ Unif(0, 1)}, \eqn{sqrt(g_b) ~ Unif(0, 1)}).
#'
#'Priors used in \code{method=3} are the Jeffreys prior for the overall mean and residual variance,
#'a normal distribution for (not standardized) effects,
#'and the standard half-Cauchy distribution for the square root of \eqn{g} parameter
#'(\eqn{sqrt(g_t) ~ Half-Cauchy(0, 1)}, \eqn{sqrt(g_b) ~ Half-Cauchy(0, 1)}).
#'
#'Priors used in \code{method=4} are the Jeffreys prior for the condition means and residual variance,
#'a \eqn{g}-prior structure for standardized subject-specific random effects, and independent scaled inverse-chi-square priors with one degree of freedom for the scale hyperparameters of the \eqn{g}-priors (Heck, 2019).
#'
#'Priors used in \code{method=5} are the Jeffreys prior for the condition means and residual variance,
#'a normal distribution for (not standardized) subject-specific random effects, and the standard uniform distribution for the square root of \eqn{g} parameter.
#'
#'Priors used in \code{method=6} are the Jeffreys prior for the condition means and residual variance,
#'a normal distribution for (not standardized) subject-specific random effects, and the standard half-Cauchy distribution for the square root of \eqn{g} parameter.
#'
#' @param data A long format matrix or data frame of the within-subjects data whose three columns are labeled in \code{whichSubject}, \code{whichLevel}, and \code{whichResponse} (see Examples).
#' @param whichSubject A character string specifying the column name of subject variable in the long format data.
#' @param whichLevel A character string specifying the column name of level variable in the long format data.
#' @param whichResponse A character string specifying the column name of response variable in the long format data.
#' @param data.wide Alternatively, a wide format matrix or data frame of the within-subjects data whose column indices are condition levels (see Examples).
#' If both \code{data} and \code{data.wide} are specified, the credible intervals are only computed for \code{data}.
#' @param cred A scalar \code{[0,1]} specifying the credibility level of the credible interval. The default is .95.
#' @param warmup A positive integer specifying the number of warmup (burnin) iterations per chain. The default is 200.
#' @param iter A positive integer specifying the number of iterations for each chain (excluding warmup). The default is 2000.
#' @param chains A positive integer specifying the number of Markov chains. The default is 4.
#' @param method A positive integer in \code{0:6} specifying which method is used to construct within-subjects HDIs (see Details).
#' \code{method=0} implements the approach developed by Nathoo, Kilshaw, and Masson (2018).
#' \code{method=4} implements the approach by Heck (2019).
#' \code{method=5} implements the approach by Heck (2019), but using the standard uniform prior distribution for the standard deviation of subject-specific random effects.
#' \code{method=6} implements the approach by Heck (2019), but using the standard half-Cauchy prior distribution for the standard deviation of subject-specific random effects.
#' \code{method=1} (default) implements the approach by Heck (2019), but using the Jeffreys prior for the overall mean rather than the condition means;
#' the hierarchical specification regarding the \eqn{g}-prior for the standardized subject-specific random effects is discussed in Rouder et al. (2012, p. 361-362).
#' With the Jeffreys prior for the overall mean and residual variance,
#' \code{method=2} uses the standard uniform prior, and \code{method=3} uses the standard half-Cauchy prior for the standard deviation of random effects.
#' For the computation of the standard HDI, see the \code{design} argument below.
#' @param var.equal A logical variable indicating whether to treat the variance of the response within each condition (level of the experimental manipulation) as being equal.
#' If \code{TRUE} (default), the homogeneity of variance holds, and a common variance across conditions is assumed.
#' Otherwise, \code{FALSE} will generate unequal interval widths for conditions.
#' Two approaches are currently provided for the heteroscedastic within-subjects data: \code{method=0} implements the approach developed by Nathoo et al. (2018);
#' \code{method=1} (default method if \code{var.equal=FALSE}) implements the heteroscedastic standard HDI method on the subject-centering transformed data.
#' If a \code{method} option other than \code{0} or \code{1} is used with \code{var.equal=FALSE},
#' a pooled estimate of variability will be used just as in the homoscedastic case, and a warning message will be returned.
#' @param design A character string specifying the experimental design.
#' If \code{"within"} (default), construct the within-subjects HDIs based on the given \code{method} in \code{0:6}.
#' If \code{"between"}, construct the standard HDIs using the priors in \code{method=1} (but not removing the between-subjects variability).
#' @param treat A character string specifying the type of condition effects when \code{method} in \code{1:3}.
#' If \code{"fixed"}, treat the condition effects as fixed effects through the reduced parametrization proposed by Rouder et al. (2012, p. 363).
#' If \code{"random"} (default), treat the condition effects as random effects.
#' @param ht A positive real number specifying the prior scale for standardized condition effects when \code{method=1} (see Details). The default is 0.5 when \code{treat="fixed"} and 1 when \code{treat="random"}.
#' @param hb A positive real number specifying the prior scale for standardized subject-specific random effects when \code{method=1} or \code{method=4} (see Details). The default is 1.
#' @param seed The seed for random number generation.
#' @param diagnostics A logical variable indicating whether to return the MCMC summary statistics
#' when \code{method} in \code{1:6}.
#' If \code{FALSE} (default), the function returns the HDI result (see Value).
#' If \code{TRUE}, the function returns an additional object of S4 class representing the fitted results for assessing the MCMC convergence.
#' @param permuted A logical variable indicating whether to pre-process the input data.
#' No matter whether the input is long data or wide data, the function eventually converts it to wide data for calculation.
#' If \code{TRUE} (default), the converted wide-format data are first ordered by their column names in alphabetic order.
#' Then, the data are placed in ascending order by the first and second columns.
#' If \code{FALSE}, the data are not ordered, and the returned HDI results are sensitive to data permutation.
#' In other words, the row permutation (e.g., switching the first and second rows)
#' and the column permutation (e.g., switching the first and second columns) will result in slightly different HDI estimates even if \code{seed} is set to be the same.
#' @param ... Additional arguments that pass to \code{\link[rstan]{sampling}},
#' such as \code{thin}, \code{algorithm}, \code{cores}, etc.
#'
#' @return A \code{list} with three components, if \code{diagnostics=FALSE}:
#' \item{HDI}{A matrix of HDI lower and upper bounds, whose row names are the condition levels.}
#' \item{`posterior means`}{The posterior condition means when using \code{method} in \code{1:6}.}
#' \item{`arithmetic means`}{Or, the arithmetic condition means when using \code{method=0}.}
#' \item{width}{The HDI width, which is the half-length from the lower bound to the upper bound.}
#' A \code{list} with four components including an additional object of S4 class representing the fitted results, if \code{diagnostics=TRUE}.
#' @export
#'
#' @author Zhengxiao Wei (\email{zhengxiao@@uvic.ca}),
#' Farouk S. Nathoo (\email{nathoo@@uvic.ca}),
#' Michael E.J. Masson (\email{mmasson@@uvic.ca}).
#' @references Heck, D. W. (2019). Accounting for estimation uncertainty and shrinkage in Bayesian within-subject intervals: A comment on Nathoo, Kilshaw, and Masson (2018). Journal of Mathematical Psychology, 88, 27–31.
#'
#' Loftus, G. R., & Masson, M. E. J. (1994). Using confidence intervals in within-subject designs. Psychonomic Bulletin & Review, 1, 476–490.
#'
#' Nathoo, F. S., Kilshaw, R. E., & Masson, M. E. J. (2018). A better (Bayesian) interval estimate for within-subject designs. Journal of Mathematical Psychology, 86, 1–9.
#'
#' Rouder, J. N., Morey, R. D., Speckman, P. L., & Province, J. M. (2012). Default Bayes factors for ANOVA designs. Journal of Mathematical Psychology, 56, 356–374.
#'
#' Stan Development Team (2020). RStan: the R interface to Stan. R package version 2.21.2.  https://mc-stan.org
#'
#' @examples
#' \dontrun{
#' data(recall.wide) # Example data, wide format
#' rmHDI(data.wide = recall.wide, seed = 277)
#'
#' data(recall.long) # Example data, long format
#' rmHDI(recall.long, seed = 277)
#'
#' colnames(recall.long) <- c("Participant", "Condition", "DV")
#' rmHDI(recall.long, whichSubject = "Participant",
#' whichLevel = "Condition", whichResponse = "DV", seed = 277)
#'
#'
#' ## Nathoo et al. (2018) approach
#' data(recall.long)
#' rmHDI(recall.long, method = 0)
#' rmHDI(recall.long, method = 0, var.equal = FALSE)
#'
#'
#' ## Standard HDI
#' rmHDI(recall.long, design = "between", seed = 277)
#' }
rmHDI <- function(data = NULL, whichSubject = "Subject", whichLevel = "Level", whichResponse = "Response", data.wide = NULL,
                  cred = .95, warmup = 200, iter = 2000, chains = 4, method = 1,
                  var.equal = TRUE, design = c("within", "between"), treat = c("random", "fixed"),
                  ht = ifelse(match.arg(treat) == "fixed", 0.5, 1), hb = 1,
                  seed = sample.int(.Machine$integer.max, 1),
                  diagnostics = FALSE, permuted = TRUE, ...) {

  design <- match.arg(design)
  treat <- match.arg(treat)
  method <- match.arg(as.character(method), choices = 0:6)
  var.equal <- match.arg(as.character(var.equal), choices = c(TRUE, FALSE))
  diagnostics <- match.arg(as.character(diagnostics), choices = c(FALSE, TRUE))
  permuted <- match.arg(as.character(permuted), choices = c(TRUE, FALSE))

  if(!missing(cred) && (length(cred) != 1 || !is.finite(cred) ||
                        cred < 0 || cred > 1)) {
    stop("'cred' must be a single number between 0 and 1")
  }

  if(!missing(ht) && (length(ht) != 1 || !is.finite(ht) || ht <= 0)) {
    stop("'ht' must be a single positive number")
  }

  if(!missing(hb) && (length(hb) != 1 || !is.finite(hb) || hb <= 0)) {
    stop("'hb' must be a single positive number")
  }

  if(!missing(whichSubject) && (length(whichSubject) != 1 || !is.character(whichSubject))) {
    stop("'whichSubject' must be a single character string")
  }

  if(!missing(whichLevel) && (length(whichLevel) != 1 || !is.character(whichLevel))) {
    stop("'whichLevel' must be a single character string")
  }

  if(!missing(whichResponse) && (length(whichResponse) != 1 || !is.character(whichResponse))) {
    stop("'whichResponse' must be a single character string")
  }

  if(!is.null(data)) { #check the long format data input
    colNames <- colnames(data)
    if (!is.element(whichSubject,colNames)) {
      stop(paste("Long format data do not contain the column name", whichSubject))
    }
    if (!is.element(whichLevel,colNames)) {
      stop(paste("Long format data do not contain the column name", whichLevel))
    }
    if (!is.element(whichResponse,colNames)) {
      stop(paste("Long format data do not contain the column name", whichResponse))
    }

    data <- data[,c(whichSubject,whichLevel,whichResponse)]
    data <- as.matrix(stats::reshape(as.data.frame(data),
                                     idvar = whichSubject,
                                     timevar = whichLevel,
                                     direction = "wide"))[, -1, drop = FALSE]

    data <- apply(data, 2, as.numeric)
    colnames(data) <- gsub(paste(whichResponse, ".", sep=""), "", colnames(data))

  } else { #check the wide format data input
    if (!is.null(data.wide)) {
      data <- as.matrix(data.wide)
      if (is.null(colnames(data))) { #in case of missing column names
        colnames(data) <- paste("Level", 1:ncol(data), sep="")
      }
    } else {
      stop("Invalid input: Data may contain NA or Inf.")
    }
  }
  #check the within-subjects design is balanced;
  #the between-subjects design can be unbalanced
  if((any(is.na(data)) && design == "within") || any(is.infinite(data))) {
    stop("Invalid input: Data may contain NA or Inf.")
  }

  C <- ncol(data) #number of conditions
  if (C == 1) {stop("Number of conditions should be greater than two.")}
  N <- nrow(data) #number of subjects (in a balanced group)
  tcrit <- stats::qt((1 + cred) / 2, df = C * (N - 1)) #t-critical value

  if (design == "between" && (method %in% 2:6 || hb != 1) && method != 0) {
    warning("Standard highest-density intervals method does not require specifying the 'method' and 'hb' arguments. See ?rmHDI for details.")
  }
  if (method == 0 && (design != "within" || treat != "random" || diagnostics || hb != 1 || ht != 1)) {
    warning("Within-subjects highest-density intervals are constructed by method 0, which does not require specifying the 'design', 'treat', 'ht', 'hb', and 'diagnostics' arguments. See ?rmHDI for details.")
  }
  if(!var.equal && design == "within" && method %in% 2:6) {
    var.equal = TRUE
    #Within-subjects highest-density intervals (for a heteroscedastic case) are currently constructed by implementing the standard highest-density intervals method on the subject-centering transformed data.
    warning(paste("A method option other than 0 or 1 is used with var.equal = FALSE and design = 'within'.
Thus, a pooled estimate of variability will be used just as method =", method, "in the homoscedastic case."))
  }

  if (treat == "fixed" && var.equal && (method %in% 1:3 ||
                                        design == "between") && method != 0) {
    #reduced parametrization for the fixed treatment effects
    S <- diag(C) - matrix(1, nrow = C, ncol = C) / C
    e <- qr(S)
    Q <- qr.Q(e) %*% diag(sign(diag(qr.R(e))))
    Q <- Q[, which(abs(e$qraux) > 1e-3), drop = FALSE]
  }

  if (permuted) {
    data <- data[,order(colnames(data))] #in case of column permutation
    data <- data[order(data[,1], data[,2]),] #in case of row permutation (SORT OF)
  }


  if (var.equal) {

    if (method == 0) { #Nathoo, Kilshaw, & Masson (2018)
      SS <- sum((data - outer(rowMeans(data), colMeans(data), "+") + mean(data))^2) #interaction sum of squares
      within_error <- sqrt(SS / (N * (N - 1) * C))
      width <- within_error * tcrit
      means <- colMeans(data)
      mat <- cbind("lower" = means - width,
                   "upper" = means + width)
      return(list("HDI" = mat, "arithmetic means" = means, "width" = width))
    }

    else if (design == "between") { #standard HDI
      s <- colSums(!is.na(data))
      if (any(s == 0)) {stop("Invalid input: Data may contain a missing column.")}
      Num <- sum(s)
      dataV <- as.vector(data[!is.na(data)])
      if (treat == "fixed") {
        standata <- list("N" = Num, "C" = C, "Y" = dataV, "s" = s, "Q" = Q, "ht" = ht)
        mcmc <- rstan::sampling(stanmodels$HDIstandardFixed, data = standata,
                                pars = c("mu_t", "sigma"), refresh = 0,
                                warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      } else { #treat == "random"
        standata <- list("N" = Num, "C" = C, "Y" = dataV, "s" = s, "ht" = ht)
        mcmc <- rstan::sampling(stanmodels$HDIstandard, data = standata,
                                pars = c("mu_t", "sigma"), refresh = 0,
                                warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      }
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "mu_t", probs=c((1 - cred) / 2, (1 + cred) / 2))$summary[,4:5],
                      ncol = 2) #IT IS byrow = FALSE !!
    }

    else if (method == 1 && treat == "fixed" && design == "within") { #using the default priors in Rouder et al. (2012)
      standata <- list("N" = N, "C" = C, "Y" = data, "tcrit" = tcrit, "Q" = Q, "ht" = ht, "hb" = hb)
      mcmc <- rstan::sampling(stanmodels$HDIdFixed, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)
    }

    else if (method == 1 && treat == "random" && design == "within") { #using the default priors in Rouder et al. (2012)
      standata <- list("N" = N, "C" = C, "Y" = data, "tcrit" = tcrit, "ht" = ht, "hb" = hb)
      mcmc <- rstan::sampling(stanmodels$HDId, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)
    }

    else if (method == 2 && treat == "fixed" && design == "within") {
      standata <- list("N" = N, "C" = C, "Y" = data, "tcrit" = tcrit, "Q" = Q)
      mcmc <- rstan::sampling(stanmodels$HDIdUnifFixed, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)
    }

    else if (method == 2 && treat == "random" && design == "within") {
      standata <- list("N" = N, "C" = C, "Y" = data, "tcrit" = tcrit)
      mcmc <- rstan::sampling(stanmodels$HDIdUnif, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)
    }

    else if (method == 3 && treat == "fixed" && design == "within") {
      standata <- list("N" = N, "C" = C, "Y" = data, "tcrit" = tcrit, "Q" = Q)
      mcmc <- rstan::sampling(stanmodels$HDIdCauchyFixed, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)
    }

    else if (method == 3 && treat == "random" && design == "within") {
      standata <- list("N" = N, "C" = C, "Y" = data, "tcrit" = tcrit)
      mcmc <- rstan::sampling(stanmodels$HDIdCauchy, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)
    }

    else if (method == 4 && design == "within") { #Heck (2019)
      if (treat == "fixed" || ht != 1) {
        warning("Method 4 does not require specifying the 'treat' and 'ht' arguments. See ?rmHDI for details.")
      }
      standata <- list("N" = N, "C" = C, "Y" = data, "tcrit" = tcrit, "hb" = hb)
      mcmc <- rstan::sampling(stanmodels$HDIc, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)
    }

    else if (method == 5 && design == "within") {
      if (treat == "fixed" || ht != 1 || hb != 1) {
        warning("Method 5 does not require specifying the 'treat', 'ht', and 'hb' arguments. See ?rmHDI for details.")
      }
      standata <- list("N" = N, "C" = C, "Y" = data, "tcrit" = tcrit)
      mcmc <- rstan::sampling(stanmodels$HDIcUnif, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)
    }

    else if (method == 6 && design == "within") {
      if (treat == "fixed" || ht != 1 || hb != 1) {
        warning("Method 6 does not require specifying the 'treat', 'ht', and 'hb' arguments. See ?rmHDI for details.")
      }
      standata <- list("N" = N, "C" = C, "Y" = data, "tcrit" = tcrit)
      mcmc <- rstan::sampling(stanmodels$HDIcCauchy, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)
    } else {stop("No such method.")}


  } else { #heteroscedastic cases, !var.equal
    if (design == "within" || method == 0) {
      #subject-centering transformation
      data <- data - rowMeans(data) + mean(data)
    }
    s <- colSums(!is.na(data))
    if (any(s == 0)) {stop("Invalid input: Data may contain a missing column.")}
    Num <- sum(s)
    dataV <- as.vector(data[!is.na(data)])
    tcrit <- stats::qt((1 + cred) / 2, df = N - 1) #t-critical value
    standata <- list("N" = Num, "C" = C, "Y" = dataV, "s" = s, "tcrit" = tcrit, "ht" = ht)

    if (method == 0) {
      vars <- apply(data, 2, stats::var)
      within_error <- sqrt(vars / N)
      width <- within_error * tcrit
      means <- colMeans(data)
      mat <- cbind("lower" = means - width,
                   "upper" = means + width)
      return(list("HDI" = mat, "arithmetic means" = means, "width" = width))
    }

    if (design == "within") {
      if (hb != 1) {
        warning("Current method for the within-subjects highest-density intervals (for a heteroscedastic case) does not require specifying the 'hb' argument.")
      }

      mcmc <- rstan::sampling(stanmodels$HDIstandardHetero, data = standata,
                              pars = c("hdi", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "hdi")$summary[,"mean"],
                      ncol = 2, byrow = TRUE)

    } else if (design == "between") { #standard HDI
      mcmc <- rstan::sampling(stanmodels$HDIstandardHetero, data = standata,
                              pars = c("mu_t", "sigma"), refresh = 0,
                              warmup = warmup, iter = warmup + iter, chains = chains, seed = seed, ...)
      mcmc2 <- matrix(rstan::summary(mcmc, pars = "mu_t", probs=c((1 - cred) / 2, (1 + cred) / 2))$summary[,4:5],
                      ncol = 2) #IT IS byrow = FALSE !!

    } else {stop("No such method.")}
  }

  rownames(mcmc2) <- colnames(data)
  colnames(mcmc2) <- c("lower", "upper")

  if (!diagnostics && (design == "between" || !var.equal)) {
    list("HDI" = mcmc2, "posterior means" = rowMeans(mcmc2), "width" = (mcmc2[,2] - mcmc2[,1]) / 2)
  } else if (!diagnostics && var.equal) {
    list("HDI" = mcmc2, "posterior means" = rowMeans(mcmc2), "width" = unname((mcmc2[1,2] - mcmc2[1,1]) / 2, force = TRUE))
  } else if (diagnostics && (design == "between" || !var.equal)) {
    list("HDI" = mcmc2, "posterior means" = rowMeans(mcmc2), "width" = (mcmc2[,2] - mcmc2[,1]) / 2,
         "diagnostics" = mcmc)
  } else {
    list("HDI" = mcmc2, "posterior means" = rowMeans(mcmc2), "width" = unname((mcmc2[1,2] - mcmc2[1,1]) / 2, force = TRUE),
         "diagnostics" = mcmc)
  }
}
