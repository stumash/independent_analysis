###### get the tables from the FBI crime pages for each state
# load all necessary libraries
library(readr)
library(stringr)
library(rvest)
# get all the state names from the state_names text file
table.list <- list()
for (i in (1:length(state.names))[-38]) { #exclude 38th entry (pennsylvania has different url)
  curr.state.url <- str_replace(url.template, "STATENAME", state.names[i])
  curr.page <- read_html(curr.state.url)
  curr.nodes <- html_nodes(curr.page, "table")
  curr.table <- html_table(curr.nodes[[3]])
  curr.table$State <- state.names[i]
  table.list[[i]] <- curr.table
}
# get pennsyivania data separately (WHY DOES THE FBI WEBSITE NOT HAVE CONSISTENT PAGE-NAMING?)
curr.state.url <- "https://www.fbi.gov/about-us/cjis/ucr/crime-in-the-u.s/2013/crime-in-the-u.s.-2013/tables/table-8/table-8-state-cuts/table-8-pennsylvania"
curr.page <- read_html(curr.state.url)
curr.nodes <- html_nodes(curr.page, "table")
curr.table <- html_table(curr.nodes[[3]])
curr.table$State <- state.names[38] # "pennsylvania"
table.list[[38]] <- curr.table
# make the long table
cn <- c("City", "Population", "Violent_crime", "Murder_and_non-neg_manslaughter", "Rape_reviseddef", "Rape_legacydef", "Robbery", "Aggravated_assualt", "Property_crime", "Burglary", "Larceny_theft", "Vehicle_theft", "Arson", "State")
for (i in 1:50) {
  colnames(table.list[[i]]) <- cn
}
fbi <- do.call(rbind, table.list)
# remove clutter variables from global environment
rm(curr.nodes, curr.page, curr.table, curr.state.url, url.template, i, cn, state.names, table.list)

# save the resulting table to a unclean_table.RData
save(fbi, file = "unclean_table.RData")