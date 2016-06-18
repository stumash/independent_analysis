###### get the tables from the FBI crime pages for each state
# load all necessary libraries
library(readr)
library(stringr)
library(rvest)
library(RCurl)
library(XML)
# get all the state names from the state_names text file
table.list <- list()#; i = 2
for (i in 1:length(state.names)) {
  curr.state.url <- str_replace(url.template, "STATENAME", state.names[i])
  curr.page <- getURL(curr.state.url)
  curr.page <- htmlParse(curr.state.url)
  curr.nodes <- html_nodes(curr.page, "table")
  curr.table <- html_table(curr.nodes[[3]])
  curr.table$State <- state.names[i]
  table.list[[i]] <- curr.table
}
table.list[[2]]
# save(list = ls(all.names = TRUE), file = "fbi_scrape_required_data.RData", envir = .GlobalEnv)
