# rmBayes 0.1.16

* Updated Stan deprecated syntax. Required rstan version 2.26 or later. See reference at https://mc-stan.org/docs/reference-manual/postfix-brackets-array-syntax.html

    For instance, the syntax `vector[C] Y[N];` is deprecated and will be removed in Stan 2.33. The postfix bracket notation for arrays is replaced by `array[N] vector[C] Y;`.

    `int s[C];` is replaced by `array[C] int s;`.

    The syntax for declaring vector types, such as `vector[N] b;`, remains unchanged.

* Updated package doc. `@docType "package"` is deprecated. Please document "_PACKAGE" instead.


# rmBayes 0.1.15

* Corrected the Stan syntax of the Jeffreys prior for the standard deviation. See discussion at https://discourse.mc-stan.org/t/jeffreys-prior-for-a-vector-variable/28338


# rmBayes 0.1.14

* Fixed HTML validation problems (nested emphasis) on the rmHDI documentation for R-devel.

* Fixed Namespaces in Imports field not imported from: 'RcppParallel' 'rstantools'.

* Added DOI in the DESCRIPTION file.


# rmBayes 0.1.13

* First stable version of rmBayes released to CRAN.
