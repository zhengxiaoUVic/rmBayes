data {
  int<lower=1> N;        // number of subjects
  int<lower=2> C;        // number of conditions
  array[N] vector[C] Y;        // responses
  real tcrit;            // critical value
  matrix[C,C-1] Q;       // projecting C fixed effects into C-1
  real<lower=0> ht;      // (square root) scale parameter of the standardized treatment effects
  real<lower=0> hb;      // (square root) scale parameter of the standardized subject-specific random effects
}

parameters {
  real mu;              // grand mean
  real<lower=0> sigma;  // standard deviation of the error
  real<lower=0> gt;     // variance of the standardized projected fixed treatment effects
  real<lower=0> gb;     // variance of the standardized subject-specific random effects
  vector[C-1] tf;       // projected fixed treatment effects
  vector[N] b;          // subject-specific random effects
}

transformed parameters {
  real<lower=0> eta;    // sd of the projected fixed treatment effects
  real<lower=0> tau;    // sd of the subject-specific random effects
  vector[C] t;          // fixed treatment effects
  eta = sigma * sqrt(gt);
  tau = sigma * sqrt(gb);
  t = Q * tf;
}

model {
  // linear mixed-effects model
  for (i in 1:N) {
    Y[i] ~ normal(mu + t + b[i], sigma);
  }
  tf ~ normal(0, eta);
  b ~ normal(0, tau);

  // priors
  // mu ~ implicit uniform prior     // Jeffreys prior
  target += -log(sigma);             // Jeffreys prior
  gt ~ scaled_inv_chi_square(1, ht);
  gb ~ scaled_inv_chi_square(1, hb); // Rouder et al. (2012)
}

// compute HDI boundaries based on Nathoo, Kilshaw, & Masson (2018) and Heck (2019)
generated quantities {
  real<lower=0> se;
  matrix[C,2] hdi;
  vector[C] mu_t;  // condition means

  se = sigma / sqrt(N);
  mu_t = mu + t;
  hdi[,1] = mu_t - tcrit * se;  // lower bound
  hdi[,2] = mu_t + tcrit * se;  // upper bound
}
