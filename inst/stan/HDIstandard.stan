data {
  int<lower=1> N;        // total number of subjects
  int<lower=2> C;        // number of conditions
  vector[N] Y;           // responses (ready for the ragged data structure)
  // int s[C];              // condition sizes [removed features]
  array[C] int s;        // condition sizes [Stan 2.26+ syntax for array declarations]
  real<lower=0> ht;      // (square root) prior scale on the variability of the standardized treatment effects
}

parameters {
  real mu;              // grand mean
  real<lower=0> sigma;  // standard deviation of the error
  real<lower=0> gt;     // variance of the standardized treatment effects
  vector[C] t;          // treatment effects
}

transformed parameters {
  real<lower=0> eta;    // sd of the treatment effects
  eta = sigma * sqrt(gt);
}

model {
  int pos;
  pos = 1;

  // linear model
  for (i in 1:C) {
    segment(Y, pos, s[i]) ~ normal(mu + t[i], sigma);
    pos = pos + s[i];
  }
  t ~ normal(0, eta);

  // priors
  // mu ~ implicit uniform prior     // Jeffreys prior
  target += -log(sigma);             // Jeffreys prior
  gt ~ scaled_inv_chi_square(1, ht); // Rouder et al. (2012)
}

generated quantities {
  vector[C] mu_t;  // condition means
  mu_t = mu + t;
}
