##### clean the data.frame 'fbi'
### load the unclean fbi crime table and some useful libraries
load("unclean_table.RData")
library(stringr)
### function that formats character vectors for conversion to numerics and converts
numerify <- function(vec) {
  vec[is.na(vec)] <- 0
  vec <- str_trim(vec)
  vec <- str_replace_all(vec, ",", "")
  vec <- as.numeric(vec)
  vec
}
### numerify the appropriate columns of fbi
for (i in 2:13) {
  fbi[,i] <- numerify(fbi[,i])
}
### combine rape_lecegacydef and rape_reviseddef into one column, 'Rape'
fbi$Rape <- fbi$Rape_legacydef + fbi$Rape_reviseddef
fbi <- fbi[,-which(colnames(fbi) %in% c("Rape_legacydef", "Rape_reviseddef"))]
### make columns into factors as appropriate (City and State)
fbi$City <- factor(fbi$City)
fbi$State <- factor(fbi$State)
### rearrange columns
fbi <- fbi[,c(12, 1:4, 13 ,5:11)]
### save the file
save(fbi, file = "clean_table.RData")