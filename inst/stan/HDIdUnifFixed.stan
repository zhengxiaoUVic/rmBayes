data {
  int<lower=1> N;        // number of subjects
  int<lower=2> C;        // number of conditions
  vector[C] Y[N];        // responses
  real tcrit;            // critical value
  matrix[C,C-1] Q;       // projecting C fixed effects into C-1
}

parameters {
  real mu;              // grand mean
  real<lower=0> sigma;  // standard deviation of the error
  real<lower=0> eta;    // sd of the projected fixed treatment effects
  real<lower=0> tau;    // sd of the subject-specific random effects
  vector[C-1] tf;       // projected fixed treatment effects
  vector[N] b;          // subject-specific random effects
}

transformed parameters {
  vector[C] t;          // fixed treatment effects
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
  // mu, eta, tau ~ implicit uniform prior  // Jeffreys prior
  target += -log(sigma);                    // Jeffreys prior
}

// compute HDI boundaries based on Nathoo, Kilshaw, & Masson (2018) and Heck (2019)
generated quantities {
  real<lower=0> se;
  matrix[C,2] hdi;

  se = sigma / sqrt(N);
  hdi[,1] = mu + t - tcrit * se;  // lower bound
  hdi[,2] = mu + t + tcrit * se;  // upper bound
}
