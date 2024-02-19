
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Bayesian Interval Estimation for Repeated-Measures Designs

<!-- badges: start -->

[![codecov](https://codecov.io/gh/zhengxiaoUVic/rmBayes/graph/badge.svg?token=EKOU0WSJIP)](https://app.codecov.io/gh/zhengxiaoUVic/rmBayes)
[![R-CMD-check](https://github.com/zhengxiaoUVic/rmBayes/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/zhengxiaoUVic/rmBayes/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

For both the homoscedastic and heteroscedastic cases in one-way
within-subject (repeated-measures) designs, this Stan-based R package
provides multiple methods to construct the credible intervals for
condition means, with each method based on different sets of priors. The
emphasis is on the calculation of intervals that remove the
between-subjects variability that is a nuisance in within-subject
designs, as proposed in Loftus and Masson (1994), the Bayesian analog
proposed in Nathoo, Kilshaw, and Masson (2018), and the adaptation
presented in Heck (2019).

## Installation

| Type        | Source                                             | Command                                            |
|-------------|----------------------------------------------------|----------------------------------------------------|
| Release     | [CRAN](https://cran.r-project.org/package=rmBayes) | `install.packages("rmBayes")`                      |
| Development | GitHub                                             | `remotes::install_github("zhengxiaoUVic/rmBayes")` |

R 4.0.1 or later is recommended. Prior to installing the package, you
need to configure your R installation to be able to compile C++ code.
Follow the link below for your respective operating system for more
instructions (version 2.26 or later; Stan Development Team, 2024):

- [Mac - Configuring C++
  Toolchain](https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Mac)
- [Windows - Configuring C++
  Toolchain](https://github.com/stan-dev/rstan/wiki/Configuring-C---Toolchain-for-Windows)
- [Linux - Configuring C++
  Toolchain](https://github.com/stan-dev/rstan/wiki/Configuring-C-Toolchain-for-Linux)

Installation time of the source package is about 11 minutes (Stan models
need to be compiled). If you have R version 4.0.1 or later on Mac,
Windows, or Ubuntu, you can find the binary packages
[HERE](https://github.com/zhengxiaoUVic/rmBayes/actions/workflows/R-CMD-check-cran.yaml).
Or, directly install the binary package by **preferably** calling

``` r
install.packages("rmBayes", type = "binary")
```

## Statistical Model

When the homogeneity of variance holds, a linear mixed-effects model
![\mathcal{M}\_1](https://latex.codecogs.com/png.image?%5Cmathcal%7BM%7D_1 "\mathcal{M}_1")
for the mean response in a one-way within-subject design is
![\mathcal{M}\_1:\\Y\_{ij}=\mu+\sigma\_\epsilon (t_i+b_j)+\epsilon\_{ij}\quad\text{versus}\quad\mathcal{M}\_0:\\Y\_{ij}=\mu+\sigma\_\epsilon b_j+\epsilon\_{ij},](https://latex.codecogs.com/png.image?%5Cmathcal%7BM%7D_1%3A%5C%20Y_%7Bij%7D%3D%5Cmu%2B%5Csigma_%5Cepsilon%20%28t_i%2Bb_j%29%2B%5Cepsilon_%7Bij%7D%5Cquad%5Ctext%7Bversus%7D%5Cquad%5Cmathcal%7BM%7D_0%3A%5C%20Y_%7Bij%7D%3D%5Cmu%2B%5Csigma_%5Cepsilon%20b_j%2B%5Cepsilon_%7Bij%7D%2C "\mathcal{M}_1:\ Y_{ij}=\mu+\sigma_\epsilon (t_i+b_j)+\epsilon_{ij}\quad\text{versus}\quad\mathcal{M}_0:\ Y_{ij}=\mu+\sigma_\epsilon b_j+\epsilon_{ij},")
![\epsilon\_{ij}\overset{\text{i.i.d.}}{\sim}\mathcal{N}(0,\sigma\_\epsilon^2), \\i=1,\dotsb,a;\\j=1,\dotsb,n,](https://latex.codecogs.com/png.image?%5Cepsilon_%7Bij%7D%5Coverset%7B%5Ctext%7Bi.i.d.%7D%7D%7B%5Csim%7D%5Cmathcal%7BN%7D%280%2C%5Csigma_%5Cepsilon%5E2%29%2C%20%5C%20i%3D1%2C%5Cdotsb%2Ca%3B%5C%20j%3D1%2C%5Cdotsb%2Cn%2C "\epsilon_{ij}\overset{\text{i.i.d.}}{\sim}\mathcal{N}(0,\sigma_\epsilon^2), \ i=1,\dotsb,a;\ j=1,\dotsb,n,")

where
![Y\_{ij}](https://latex.codecogs.com/png.image?Y_%7Bij%7D "Y_{ij}")
represents the mean response for the
![j](https://latex.codecogs.com/png.image?j "j")th subject under the
![i](https://latex.codecogs.com/png.image?i "i")th level of the
experimental manipulation;
![\mu](https://latex.codecogs.com/png.image?%5Cmu "\mu") is the overall
mean,
![\tau_i = \sigma\_\epsilon t_i](https://latex.codecogs.com/png.image?%5Ctau_i%20%3D%20%5Csigma_%5Cepsilon%20t_i "\tau_i = \sigma_\epsilon t_i")
is the ![i](https://latex.codecogs.com/png.image?i "i")th level of the
experimental manipulation;
![\mu_i = \mu + \tau_i](https://latex.codecogs.com/png.image?%5Cmu_i%20%3D%20%5Cmu%20%2B%20%5Ctau_i "\mu_i = \mu + \tau_i"),
for the means model, is the
![i](https://latex.codecogs.com/png.image?i "i")th condition mean;
![b_j](https://latex.codecogs.com/png.image?b_j "b_j") are the
standardized subject-specific random effects;
![a](https://latex.codecogs.com/png.image?a "a") is the number of
levels; ![n](https://latex.codecogs.com/png.image?n "n") is the number
of subjects. The effects
![t_i](https://latex.codecogs.com/png.image?t_i "t_i") and
![b_j](https://latex.codecogs.com/png.image?b_j "b_j") are both
standardized relative to the standard deviation of the error
![\sigma\_\epsilon](https://latex.codecogs.com/png.image?%5Csigma_%5Cepsilon "\sigma_\epsilon")
and become dimensionless (Rouder, Morey, Speckman, & Province, 2012).

## Method 0

Nathoo et al. (2018) derived a Bayesian within-subject interval by
conditioning on maximum likelihood estimates of the subject-specific
random effects. An assumption articulated in Method 0 is the Jeffreys
prior for the condition means
![\mu_i](https://latex.codecogs.com/png.image?%5Cmu_i "\mu_i") and
residual variance
![\sigma\_\epsilon^2](https://latex.codecogs.com/png.image?%5Csigma_%5Cepsilon%5E2 "\sigma_\epsilon^2"),
i.e.,
![\pi(\mu_1,\dotsb,\mu_a,\sigma\_\epsilon^2)\varpropto\frac{1}{\sigma\_\epsilon^2}.](https://latex.codecogs.com/png.image?%5Cpi%28%5Cmu_1%2C%5Cdotsb%2C%5Cmu_a%2C%5Csigma_%5Cepsilon%5E2%29%5Cvarpropto%5Cfrac%7B1%7D%7B%5Csigma_%5Cepsilon%5E2%7D. "\pi(\mu_1,\dotsb,\mu_a,\sigma_\epsilon^2)\varpropto\frac{1}{\sigma_\epsilon^2}.")

Method 0 constructs the highest-density interval (HDI) as
![\text{HDI}=M\_{i\centerdot}\pm\sqrt{\frac{\textit{SS}\_{S\times C}}{n(n-1)a}}\cdot t\_{1-\frac{\alpha}{2},\\a(n-1)}^{\*}.](https://latex.codecogs.com/png.image?%5Ctext%7BHDI%7D%3DM_%7Bi%5Ccenterdot%7D%5Cpm%5Csqrt%7B%5Cfrac%7B%5Ctextit%7BSS%7D_%7BS%5Ctimes%20C%7D%7D%7Bn%28n-1%29a%7D%7D%5Ccdot%20t_%7B1-%5Cfrac%7B%5Calpha%7D%7B2%7D%2C%5C%20a%28n-1%29%7D%5E%7B%2A%7D. "\text{HDI}=M_{i\centerdot}\pm\sqrt{\frac{\textit{SS}_{S\times C}}{n(n-1)a}}\cdot t_{1-\frac{\alpha}{2},\ a(n-1)}^{*}.")

**Note**: The sample mean for the
![i](https://latex.codecogs.com/png.image?i "i")th condition is
![M\_{i\centerdot}=\frac{1}{n}\sum\_{j=1}^{n}Y\_{ij}](https://latex.codecogs.com/png.image?M_%7Bi%5Ccenterdot%7D%3D%5Cfrac%7B1%7D%7Bn%7D%5Csum_%7Bj%3D1%7D%5E%7Bn%7DY_%7Bij%7D "M_{i\centerdot}=\frac{1}{n}\sum_{j=1}^{n}Y_{ij}").

The sample mean for the
![j](https://latex.codecogs.com/png.image?j "j")th subject is
![M\_{\centerdot j}=\frac{1}{a}\sum\_{i=1}^{a}Y\_{ij}](https://latex.codecogs.com/png.image?M_%7B%5Ccenterdot%20j%7D%3D%5Cfrac%7B1%7D%7Ba%7D%5Csum_%7Bi%3D1%7D%5E%7Ba%7DY_%7Bij%7D "M_{\centerdot j}=\frac{1}{a}\sum_{i=1}^{a}Y_{ij}").

The overall mean is
![M=\frac{1}{an}\sum\_{i=1}^{a}\sum\_{j=1}^{n}Y\_{ij}](https://latex.codecogs.com/png.image?M%3D%5Cfrac%7B1%7D%7Ban%7D%5Csum_%7Bi%3D1%7D%5E%7Ba%7D%5Csum_%7Bj%3D1%7D%5E%7Bn%7DY_%7Bij%7D "M=\frac{1}{an}\sum_{i=1}^{a}\sum_{j=1}^{n}Y_{ij}").

The within-group sum-of-squares (SS) is
![\textit{SS}\_W=\sum\_{i=1}^{a}\sum\_{j=1}^{n}\left(Y\_{ij}-M\_{i\centerdot}\right)^2](https://latex.codecogs.com/png.image?%5Ctextit%7BSS%7D_W%3D%5Csum_%7Bi%3D1%7D%5E%7Ba%7D%5Csum_%7Bj%3D1%7D%5E%7Bn%7D%5Cleft%28Y_%7Bij%7D-M_%7Bi%5Ccenterdot%7D%5Cright%29%5E2 "\textit{SS}_W=\sum_{i=1}^{a}\sum_{j=1}^{n}\left(Y_{ij}-M_{i\centerdot}\right)^2").

The interaction SS is
![\textit{SS}\_{S\times C}=\sum\_{i=1}^{a}\sum\_{j=1}^{n}\left(Y\_{ij}-(M\_{\centerdot j}-M)-M\_{i\centerdot}\right)^2](https://latex.codecogs.com/png.image?%5Ctextit%7BSS%7D_%7BS%5Ctimes%20C%7D%3D%5Csum_%7Bi%3D1%7D%5E%7Ba%7D%5Csum_%7Bj%3D1%7D%5E%7Bn%7D%5Cleft%28Y_%7Bij%7D-%28M_%7B%5Ccenterdot%20j%7D-M%29-M_%7Bi%5Ccenterdot%7D%5Cright%29%5E2 "\textit{SS}_{S\times C}=\sum_{i=1}^{a}\sum_{j=1}^{n}\left(Y_{ij}-(M_{\centerdot j}-M)-M_{i\centerdot}\right)^2").

![t^\*](https://latex.codecogs.com/png.image?t%5E%2A "t^*") refers to a
critical value for the
![t](https://latex.codecogs.com/png.image?t "t")-distribution.

``` r
library(rmBayes)

str(recall.long)

rmHDI(recall.long, method = 0)
```

## Methods 4-6

Heck (2019) proposed modifying the conditional within-subject Bayesian
interval to account for uncertainty and shrinkage in the estimated
random effects. He derived a modification by applying the HDI equation
in Method 0 for the within-subject Bayesian interval at each iteration
of a Markov chain Monte Carlo (MCMC) sampling algorithm and then taking
the average interval across posterior samples. Priors used in Method 4
are the Jeffreys prior for the condition means and residual variance, a
![g](https://latex.codecogs.com/png.image?g "g")-prior structure for
standardized subject-specific random effects (i.e.,
![b_j\mid g_b\overset{\text{i.i.d.}}{\sim}\mathcal{N}(0,g_b)](https://latex.codecogs.com/png.image?b_j%5Cmid%20g_b%5Coverset%7B%5Ctext%7Bi.i.d.%7D%7D%7B%5Csim%7D%5Cmathcal%7BN%7D%280%2Cg_b%29 "b_j\mid g_b\overset{\text{i.i.d.}}{\sim}\mathcal{N}(0,g_b)")),
and independent scaled inverse-chi-square priors with one degree of
freedom for the scale hyperparameters of the
![g](https://latex.codecogs.com/png.image?g "g")-priors (i.e.,
![g_b\sim\text{Scale-inv-}\chi^2(1,h_b^2)](https://latex.codecogs.com/png.image?g_b%5Csim%5Ctext%7BScale-inv-%7D%5Cchi%5E2%281%2Ch_b%5E2%29 "g_b\sim\text{Scale-inv-}\chi^2(1,h_b^2)")).

Method 4 constructs the HDI as
![\text{HDI}=\mathbb{E}\left\[\mu\_{i}\pm\frac{\sigma\_{\epsilon}}{\sqrt{n}}\cdot t\_{1-\frac{\alpha}{2},\\a(n-1)}^{\*}\mid\text{Data}\right\].](https://latex.codecogs.com/png.image?%5Ctext%7BHDI%7D%3D%5Cmathbb%7BE%7D%5Cleft%5B%5Cmu_%7Bi%7D%5Cpm%5Cfrac%7B%5Csigma_%7B%5Cepsilon%7D%7D%7B%5Csqrt%7Bn%7D%7D%5Ccdot%20t_%7B1-%5Cfrac%7B%5Calpha%7D%7B2%7D%2C%5C%20a%28n-1%29%7D%5E%7B%2A%7D%5Cmid%5Ctext%7BData%7D%5Cright%5D. "\text{HDI}=\mathbb{E}\left[\mu_{i}\pm\frac{\sigma_{\epsilon}}{\sqrt{n}}\cdot t_{1-\frac{\alpha}{2},\ a(n-1)}^{*}\mid\text{Data}\right].")

``` r
rmHDI(recall.long, method = 4, seed = 277)
```

To assess the robustness of HDI results with respect to the choice of a
prior distribution for the standard deviation of the subject-specific
random effects in the within-subject case, two additional priors are
considered: uniform and half-Cauchy
(![\sigma\_\epsilon\sqrt{g_b}\sim\text{Unif}(0,1)](https://latex.codecogs.com/png.image?%5Csigma_%5Cepsilon%5Csqrt%7Bg_b%7D%5Csim%5Ctext%7BUnif%7D%280%2C1%29 "\sigma_\epsilon\sqrt{g_b}\sim\text{Unif}(0,1)")
or
![\sigma\_\epsilon\sqrt{g_b}\sim\text{Half-Cauchy}(0,1)](https://latex.codecogs.com/png.image?%5Csigma_%5Cepsilon%5Csqrt%7Bg_b%7D%5Csim%5Ctext%7BHalf-Cauchy%7D%280%2C1%29 "\sigma_\epsilon\sqrt{g_b}\sim\text{Half-Cauchy}(0,1)"))
for Methods 5 and 6, respectively.

``` r
rmHDI(recall.long, method = 5, seed = 277)
```

``` r
rmHDI(recall.long, method = 6, seed = 277)
```

## Methods 1 (Default) and 2-3

Methods 0 and 4-6 arbitrarily assume improper uniform priors for the
condition means. In this work, Wei, Nathoo, and Masson (2023) expanded
the space of possible priors by appling the HDI equation in Method 0 to
derive the newly proposed intervals from MCMC sampling, but assuming
default ![g](https://latex.codecogs.com/png.image?g "g")-priors for
standardized treatment effects. In other words, Method 1 uses the
Jeffreys prior for the overall mean (rather than the condition means),
i.e.,
![\pi(\mu,\sigma\_\epsilon^2)\varpropto\frac{1}{\sigma\_\epsilon^2}.](https://latex.codecogs.com/png.image?%5Cpi%28%5Cmu%2C%5Csigma_%5Cepsilon%5E2%29%5Cvarpropto%5Cfrac%7B1%7D%7B%5Csigma_%5Cepsilon%5E2%7D. "\pi(\mu,\sigma_\epsilon^2)\varpropto\frac{1}{\sigma_\epsilon^2}.")

``` r
rmHDI(recall.long, seed = 277)
```

Similar to Methods 5 and 6, two additional priors are considered:
uniform and half-Cauchy
(![\sigma\_\epsilon\sqrt{g_b}\sim\text{Unif}(0,1)](https://latex.codecogs.com/png.image?%5Csigma_%5Cepsilon%5Csqrt%7Bg_b%7D%5Csim%5Ctext%7BUnif%7D%280%2C1%29 "\sigma_\epsilon\sqrt{g_b}\sim\text{Unif}(0,1)")
or
![\sigma\_\epsilon\sqrt{g_b}\sim\text{Half-Cauchy}(0,1)](https://latex.codecogs.com/png.image?%5Csigma_%5Cepsilon%5Csqrt%7Bg_b%7D%5Csim%5Ctext%7BHalf-Cauchy%7D%280%2C1%29 "\sigma_\epsilon\sqrt{g_b}\sim\text{Half-Cauchy}(0,1)"))
for Methods 2 and 3, respectively, for the standard deviation of the
subject-specific random effects in the within-subject case.

``` r
rmHDI(recall.long, method = 2, seed = 277)
```

``` r
rmHDI(recall.long, method = 3, seed = 277)
```

## Standard HDI

MCMC sampling of condition means
![\mu_i](https://latex.codecogs.com/png.image?%5Cmu_i "\mu_i") can also
be used to obtain the standard HDI, which, unlike Methods 0-6, does not
remove the between-subjects variability that is not of interest in
within-subject designs. This method assumes the Jeffreys prior for the
overall mean and residual variance, a
![g](https://latex.codecogs.com/png.image?g "g")-prior structure for
standardized treatment effects, and independent scaled
inverse-chi-square priors with one degree of freedom for the scale
hyperparameters of the
![g](https://latex.codecogs.com/png.image?g "g")-priors.

``` r
rmHDI(recall.long, design = "between", seed = 277)
```

## Random Versus Fixed Effects

When modeling fixed effects, Rouder et al. (2012, p. 363) proposed
default priors by projecting a set of
![a](https://latex.codecogs.com/png.image?a "a") main effects into
![a-1](https://latex.codecogs.com/png.image?a-1 "a-1") parameters such
that
![t_i^{\star}\mid g\overset{\text{i.i.d.}}{\sim}\mathcal{N}(0,g)](https://latex.codecogs.com/png.image?t_i%5E%7B%5Cstar%7D%5Cmid%20g%5Coverset%7B%5Ctext%7Bi.i.d.%7D%7D%7B%5Csim%7D%5Cmathcal%7BN%7D%280%2Cg%29 "t_i^{\star}\mid g\overset{\text{i.i.d.}}{\sim}\mathcal{N}(0,g)"),
![(t_1^{\star},\dotsb,t\_{a-1}^{\star})=(t_1,\dotsb,t\_{a})\cdot\mathbf{Q}](https://latex.codecogs.com/png.image?%28t_1%5E%7B%5Cstar%7D%2C%5Cdotsb%2Ct_%7Ba-1%7D%5E%7B%5Cstar%7D%29%3D%28t_1%2C%5Cdotsb%2Ct_%7Ba%7D%29%5Ccdot%5Cmathbf%7BQ%7D "(t_1^{\star},\dotsb,t_{a-1}^{\star})=(t_1,\dotsb,t_{a})\cdot\mathbf{Q}"),
and
![\mathbf{I}\_a-a^{-1}\mathbf{J}\_a=\mathbf{Q}\cdot\mathbf{Q^{\top}}](https://latex.codecogs.com/png.image?%5Cmathbf%7BI%7D_a-a%5E%7B-1%7D%5Cmathbf%7BJ%7D_a%3D%5Cmathbf%7BQ%7D%5Ccdot%5Cmathbf%7BQ%5E%7B%5Ctop%7D%7D "\mathbf{I}_a-a^{-1}\mathbf{J}_a=\mathbf{Q}\cdot\mathbf{Q^{\top}}"),

where
![\mathbf{I}\_a](https://latex.codecogs.com/png.image?%5Cmathbf%7BI%7D_a "\mathbf{I}_a")
is the identity matrix of size
![a](https://latex.codecogs.com/png.image?a "a"),
![\mathbf{J}\_a](https://latex.codecogs.com/png.image?%5Cmathbf%7BJ%7D_a "\mathbf{J}_a")
is the all-ones matrix of size
![a](https://latex.codecogs.com/png.image?a "a"),
![\mathbf{Q}](https://latex.codecogs.com/png.image?%5Cmathbf%7BQ%7D "\mathbf{Q}")
is an
![a\times (a-1)](https://latex.codecogs.com/png.image?a%5Ctimes%20%28a-1%29 "a\times (a-1)")
matrix of the ![a-1](https://latex.codecogs.com/png.image?a-1 "a-1")
eigenvectors of unit length corresponding to the nonzero eigenvalues of
![\mathbf{I}\_a-a^{-1}\mathbf{J}\_a](https://latex.codecogs.com/png.image?%5Cmathbf%7BI%7D_a-a%5E%7B-1%7D%5Cmathbf%7BJ%7D_a "\mathbf{I}_a-a^{-1}\mathbf{J}_a"),
and
![(t_1,\dotsb,t\_{a})](https://latex.codecogs.com/png.image?%28t_1%2C%5Cdotsb%2Ct_%7Ba%7D%29 "(t_1,\dotsb,t_{a})")
is the row vector.

``` r
rmHDI(recall.long, treat = "fixed", seed = 277)
```

## Heteroscedasticity

When the homogeneity of variance does not hold, the resulting HDI widths
for conditions are unequal. Two approaches are currently provided for
the heteroscedastic within-subject data: Implementing the approach
developed by Nathoo et al. (2018, p. 5);

``` r
rmHDI(recall.long, method = 0, var.equal = FALSE)
```

Or, implementing the heteroscedastic standard HDI method on the
subject-centering transformed data (subtracting from the original
response the corresponding subject mean minus the overall mean). If a
method option other than `0` or `1` is used with `var.equal=FALSE`, a
pooled estimate of variability will be used just as in the homoscedastic
case, and a warning message will be returned.

``` r
rmHDI(recall.long, var.equal = FALSE)
```

## MCMC Diagnostics

Check the Rhat statistic and effective sample size of MCMC draws.

``` r
rmHDI(recall.long, seed = 277, diagnostics = TRUE)$diagnostics
```

## References

Heck, D. W. (2019). Accounting for estimation uncertainty and shrinkage
in Bayesian within-subject intervals: A comment on Nathoo, Kilshaw, and
Masson (2018). *Journal of Mathematical Psychology*, *88*, 27–31.

Loftus, G. R., & Masson, M. E. J. (1994). Using confidence intervals in
within-subject designs. *Psychonomic Bulletin & Review*, *1*, 476–490.

Nathoo, F. S., Kilshaw, R. E., & Masson, M. E. J. (2018). A better
(Bayesian) interval estimate for within-subject designs. *Journal of
Mathematical Psychology*, *86*, 1–9.

Rouder, J. N., Morey, R. D., Speckman, P. L., & Province, J. M. (2012).
Default Bayes factors for ANOVA designs. *Journal of Mathematical
Psychology*, *56*, 356–374.

Stan Development Team (2024). RStan: the R interface to Stan. R package
version 2.32.5 <https://mc-stan.org>

Wei, Z., Nathoo, F. S., & Masson, M. E. J. (2023). Investigating the
relationship between the Bayes factor and the separation of credible
intervals. *Psychonomic Bulletin & Review*, *30*, 1759–1781.
