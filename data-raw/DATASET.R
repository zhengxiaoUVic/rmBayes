## code to prepare `DATASET` dataset goes here
recall.long <- data.frame(
  "Subject" = factor(paste("s", rep(1:10,3), sep="")),
  "Level" = factor(rep(c("Level1", "Level2", "Level3"), each = 10)),
  "Response" = c(10,6,11,22,16,15,1,12,9,8,
                 13,8,14,23,18,17,1,15,12,9,
                 13,8,14,25,20,17,4,17,12,12))

usethis::use_data(recall.long, overwrite = TRUE, compress = "xz")


recall.wide <- data.frame(
  "Level1" = c(10,6,11,22,16,15,1,12,9,8),
  "Level2" = c(13,8,14,23,18,17,1,15,12,9),
  "Level3" = c(13,8,14,25,20,17,4,17,12,12))
rownames(recall.wide) <- paste("s", c(1:10), sep="")

usethis::use_data(recall.wide, overwrite = TRUE, compress = "xz")
