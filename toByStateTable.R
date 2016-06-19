##### make a table of the same data summed up by state
load("clean_table.RData")
load("table_per_capita.RData")
states.data <- data.frame(matrix(ncol = 11, nrow = 50))
colnames(states.data) <- colnames(fbi)[-(1:2)]
rownames(states.data) <- levels(fbi$State)
j <- 1
for (currstate in levels(fbi$State)) {
  currstate.data <- fbi[fbi$State == currstate,3:13]
  currstate.row <- c()
  for (i in 1:11) {
    currstate.row <- c(currstate.row, sum(currstate.data[,i]))
  }
  states.data[j,] <- currstate.row
  j <- j + 1
}
### NEEDS FIXING
states.data.pc <- states.data
for(i in 2:ncol(states.data.pc)) {
  states.data.pc[,i] <- states.data.pc[,i]/states.data.pc[,1]
}
states.data.pc$Violent_crime
# remove clutter variables
rm(currstate, currstate.row, i, currstate.data, j)
# save the created by-state tables
save(states.data, states.data.pc, file = "state_tables.RData")