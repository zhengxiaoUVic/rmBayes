#' The Repeated-Measures Data: Wide Data Format
#'
#' A data frame that is in the wide format. A hypothetical experiment is designed to
#' measure effects of study time in a free-recall paradigm. In this hypothetical experiment,
#' to-be-recalled 20-word lists are presented at a rate of 1, 2, or 5 sec per word.
#' Of interest is the relation between study time and number of recalled list words.
#' Suppose that the experiment is run as a within-subjects (repeated-measures) design,
#' including a total of 10 subjects, each of whom participated in all three study-time conditions.
#'
#' @format A data frame with 10 rows (each row corresponds to a subject) and 3 variables:
#' \describe{
#'   \item{Level1}{The number of words recalled under the first level of the experimental manipulation - 1 second exposure duration per word.}
#'   \item{Level2}{The number of words recalled under the second level of the experimental manipulation - 2 seconds exposure duration per word.}
#'   \item{Level3}{The number of words recalled under the third level of the experimental manipulation - 5 seconds exposure duration per word.}
#' }
#' @references Loftus, G. R., & Masson, M. E. J. (1994). Using confidence intervals in within-subject designs. Psychonomic Bulletin & Review, 1, 476–490.
#' @source \doi{10.3758/BF03210951}
"recall.wide"
