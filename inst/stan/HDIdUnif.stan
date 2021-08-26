data {
  int<lower=1> N;        // number of subjects
  int<lower=2> C;        // number of conditions
  vector[C] Y[N];        // responses
  real tcrit;            // critical value
}

parameters {
  real mu;              // grand mean
  real<lower=0> sigma;  // standard deviation of the error
  real<lower=0> eta;    // sd of the treatment effects
  real<lower=0> tau;    // sd of the subject-specific random effects
  vector[C] t;          // treatment effects
  vector[N] b;          // subject-specific random effects
}

model {
  // linear mixed-effects model
  for (i in 1:N) {
    Y[i] ~ normal(mu + t + b[i], sigma);
  }
  t ~ normal(0, eta);
  b ~ normal(0, tau);

  // priors
  // mu, eta, tau ~ implicit uniform prior  // Jeffreys prior
  target += -2* log(sigma);                 // Jeffreys prior
}

// compute HDI boundaries based on Nathoo, Kilshaw, & Masson (2018) and Heck (2019)
generated quantities {
  real<lower=0> se;
  matrix[C,2] hdi;

  se = sigma / sqrt(N);
  hdi[,1] = mu + t - tcrit * se;  // lower bound
  hdi[,2] = mu + t + tcrit * se;  // upper bound
}
