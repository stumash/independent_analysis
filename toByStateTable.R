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
states.data.pc <- states.data
for(i in nrow(states.data.pc)) {
  states.data.pc[i,-1] <- states.data.pc[i,-1]/states.data.pc[i,1]
}
states.data.pc
save(states.data, states.data.pc, file = "state_tables.RData")
rm(currstate, currstate.row, i, currstate.data, j)