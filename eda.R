##### Exploratory Data Analysis
library(caret)
library(ggplot2)
library(choroplethr)
library(stringr)
library(gridExtra)
load("clean_table.RData")
load("table_per_capita.RData")
load("state_tables.RData")
View(fbi)
View(fbi.pc)
View(states.data)
View(states.data.pc)

### eda
## correlations: matrices and vectors
# correlation matrix, displays 0 if correlation is below 0.85
correlations <- matrix(nrow = ncol(fbi) - 2, ncol = ncol(fbi) - 2)
colnames(correlations) <- strtrim(colnames(fbi)[-(1:2)], width = 5)
rownames(correlations) <- colnames(correlations)
for(i in 1:nrow(correlations)) {
  for(j in 1:ncol(correlations)) {
    correlations[i,j] <- cor(fbi[,i+2], fbi[,j+2])
    correlations[i,j] <- ifelse(correlations[i,j]  > 0.85, correlations[i,j], 0)
  }
}
correlations
# population correlated with everything else
sapply(4:13, function(n) {
  cr <- cor(fbi$Population, fbi[,n])
  paste(colnames(fbi)[n], ": ", cr)
})
# correlation matrix for per capita table, displays 0 if correlation is below 0.6
correlations.pc <- matrix(nrow = ncol(fbi.pc) - 2, ncol = ncol(fbi.pc) - 2)
colnames(correlations.pc) <- strtrim(colnames(fbi.pc)[-(1:2)], width = 5)
rownames(correlations.pc) <- colnames(correlations.pc)
for(i in 1:nrow(correlations.pc)) {
  for(j in 1:ncol(correlations.pc)) {
    correlations.pc[i,j] <- cor(fbi.pc[,i+2], fbi.pc[,j+2])
    correlations.pc[i,j] <- ifelse(correlations.pc[i,j]  > 0.6, correlations.pc[i,j], 0)
  }
}
correlations.pc
# population correlated with everything else per capita
sapply(4:13, function(n) {
  cr <- cor(fbi.pc$Population, fbi.pc[,n])
  paste(colnames(fbi.pc)[n], ": ", cr)
})

## choropleths: state total and state per capita
# prepare a data.frame that is formatted correctly for choropleth
states.data.ch <- states.data
rownames(states.data.ch) <- str_replace_all(rownames(states.data.ch), "[_\\-]", " ")
# a data frame for population by state choropleth
popstate <- data.frame(region = rownames(states.data.ch), value = states.data.ch$Population)
# make choropleth
popchor <- StateChoropleth$new(popstate)
popchor$title = "2013 State Population Estimates"
popchor$legend = "Population"
popchor$set_num_colors(7)
popchor$set_zoom(NULL)
popchor$show_labels = FALSE
popchor.final = popchor$render()
# a data frame for all crime by state
values <- c()
for(i in 1:50) {
  values <- c(values, sum(states.data.ch[i,-1]))
}
crimstate <- data.frame(region = rownames(states.data.ch), value = values)
crimchor <- StateChoropleth$new(crimstate)
crimchor$title = "2013 State Total Crime Estimates"
crimchor$legend = "Total Crime"
crimchor$set_num_colors(7)
crimchor$set_zoom(NULL)
crimchor$show_labels = FALSE
crimchor.final = crimchor$render()
# plot both crim and population to show high correlation
grid.arrange(popchor.final, crimchor.final)
