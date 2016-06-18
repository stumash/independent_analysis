##### clean the data.frame 'fbi'
### merge the the two rape columns (legacydef and reviseddef) into one column
# convert NA's into 0's so that the columns can be summed
fbi$Rape_legacydef[is.na(fbi$Rape_legacydef)] <- 0
fbi$Rape_reviseddef[is.na(fbi$Rape_reviseddef)] <- 0
# sum the two columns into a new column called Rape and remove the old rape columns
fbi$Rape_legacydef <- as.numeric(fbi$Rape_legacydef)
fbi$Rape_reviseddef <- as.numeric(fbi$Rape_reviseddef)
fbi$Rape <- fbi$Rape_reviseddef + fbi$Rape_legacydef
fbi <- fbi[,-which(colnames(fbi) %in% c("Rape_reviseddef", "Rape_legacydef"))]
