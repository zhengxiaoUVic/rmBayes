.onAttach <- function(...) {
  packageStartupMessage("For execution on a local, multicore CPU with excess RAM we recommend calling\n",
                        "options(mc.cores = parallel::detectCores()).\n")
  if (.Platform$OS.type == "windows") {
    packageStartupMessage("Do not specify '-march=native' in 'LOCAL_CPPFLAGS' or a Makevars file")
  }
}
