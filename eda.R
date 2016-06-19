##### Exploratory Data Analysis
library(caret)
library(ggplot2)
library(choroplethr)
load("clean_table.RData")
load("table_per_capita.RData")
load("state_tables.RData")
View(fbi)
View(fbi.pc)
View(states.data)
View(states.data.pc)

### eda
# correlation matrix
correlations <- matrix(nrow = ncol(fbi) - 2, ncol = ncol(fbi) - 2)
colnames(correlations) <- (colnames(fbi)[-(1:2)])
rownames(correlations) <- colnames(correlations)
for(i in 1:nrow(correlations)) {
  for(j in 1:ncol(correlations)) {
    correlations[i,j] <- cor(fbi[,i+2], fbi[,j+2])
  }
}
# population correlated with everything else

