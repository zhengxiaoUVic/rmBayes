data {
  int<lower=1> N;        // total number of subjects
  int<lower=2> C;        // number of conditions
  vector[N] Y;           // responses (ready for the ragged data structure)
  int s[C];              // condition sizes
  real tcrit;            // critical value
  real<lower=0> ht;      // (square root) scale parameter of the standardized treatment effects
}

parameters {
  real mu;                   // grand mean
  vector<lower=0>[C] sigma;  // standard deviation of the error
  real<lower=0> gt;          // variance of the standardized treatment effects
  vector[C] t;               // treatment effects
}

transformed parameters {
  vector<lower=0>[C] eta;    // sd of the treatment effects
  eta = sigma * sqrt(gt);
}

model {
  int pos;
  pos = 1;

  // linear model
  for (i in 1:C) {
    segment(Y, pos, s[i]) ~ normal(mu + t[i], sigma[i]);
    pos = pos + s[i];
  }
  t ~ normal(0, eta);

  // priors
  // mu ~ implicit uniform prior     // Jeffreys prior
  target += -sum(log(sigma));        // Jeffreys prior
  gt ~ scaled_inv_chi_square(1, ht); // Rouder et al. (2012)
}

generated quantities {
  vector<lower=0>[C] se;
  matrix[C,2] hdi;
  vector[C] mu_t;  // condition means

  se = sigma / sqrt(s[1]);
  mu_t = mu + t;
  hdi[,1] = mu_t - tcrit * se;  // lower bound
  hdi[,2] = mu_t + tcrit * se;  // upper bound
}
