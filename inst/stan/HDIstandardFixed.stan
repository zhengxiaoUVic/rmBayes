data {
  int<lower=1> N;        // total number of subjects
  int<lower=2> C;        // number of conditions
  vector[N] Y;           // responses (ready for the ragged data structure)
  int s[C];              // condition sizes
  matrix[C,C-1] Q;       // projecting C fixed effects into C-1
  real<lower=0> ht;      // (square root) scale parameter of the standardized treatment effects
}

parameters {
  real mu;              // grand mean
  real<lower=0> sigma;  // standard deviation of the error
  real<lower=0> gt;     // variance of the standardized projected fixed treatment effects
  vector[C-1] tf;       // projected fixed treatment effects
}

transformed parameters {
  real<lower=0> eta;    // sd of the projected fixed treatment effects
  vector[C] t;          // fixed treatment effects
  eta = sigma * sqrt(gt);
  t = Q * tf;
}

model {
  int pos;
  pos = 1;

  // linear model
  for (i in 1:C) {
    segment(Y, pos, s[i]) ~ normal(mu + t[i], sigma);
    pos = pos + s[i];
  }
  tf ~ normal(0, eta);

  // priors
  // mu ~ implicit uniform prior     // Jeffreys prior
  target += -2* log(sigma);          // Jeffreys prior
  gt ~ scaled_inv_chi_square(1, ht); // Rouder et al. (2012)
}

generated quantities {
  vector[C] mu_t;  // condition means
  mu_t = mu + t;
}
