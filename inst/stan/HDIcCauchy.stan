data {
  int<lower=1> N;        // number of subjects
  int<lower=2> C;        // number of conditions
  vector[C] Y[N];        // responses
  real tcrit;            // critical value
}

parameters {
  vector[C] mu;         // condition means
  real<lower=0> sigma;  // standard deviation of the error
  real<lower=0> tau;    // sd of the subject-specific random effects
  vector[N] b;          // subject-specific random effects
}

model {
  // linear mixed-effects model
  for (i in 1:N) {
    Y[i] ~ normal(mu + b[i], sigma);
  }
  b ~ normal(0, tau);

  // priors
  // mu ~ implicit uniform prior     // Jeffreys prior
  target += -log(sigma);             // Jeffreys prior
  tau ~ cauchy(0, 1);
}

// compute HDI boundaries based on Nathoo, Kilshaw, & Masson (2018) and Heck (2019)
generated quantities {
  real<lower=0> se;
  matrix[C,2] hdi;

  se = sigma / sqrt(N);
  hdi[,1] = mu - tcrit * se;  // lower bound
  hdi[,2] = mu + tcrit * se;  // upper bound
}
