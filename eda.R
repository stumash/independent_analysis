##### Exploratory Data Analysis
# where are the correlations. histograms, cor, var, mean, median, ggplot, pairs
pairs(fbi) # we see that all types of crime are strongly correlated with each other.
           # expected since population is correlated with them all
hist(fbi$Violent_crime, xlim = range(fbi$Violent_crime))
fbi$City[fbi$Violent_crim == max(fbi$Violent_crime)]
# it seems that large cities are skewing the data so much that plots become meaningless,
# leaving two options: plot subsets or calculate the per capita value for all the numeric data per city
### make a table fbi.pc for per capita
fbi.pc <- fbi
fbi.pc[,4:13] <- fbi.pc[,4:13]/fbi.pc[,3]
save(fbi.pc, file = "table_per_capita.RData")
