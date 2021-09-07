.onAttach <- function(...) {
  packageStartupMessage("For execution on a local, multicore CPU with excess RAM we recommend calling\n",
                        "options(mc.cores = parallel::detectCores()).\n")
}
