# Description: Example file for RSQLite

# main idea: Use SQLite to store/buffer data. it's persistent and uses SQL

# Set up SQLIte -----------------------------------------------------------

# import necessary libraries
install.packages(c("DBI","RSQLite"))

# SQLite support
library(DBI)
library(RSQLite)

mySQLiteDB <- dbConnect(RSQLite::SQLite(), "myRsqlite.sqlite")

# Load data into SQLite Database -----------------------------------------------------------
data("ChickWeight") # need some data to play with
dbWriteTable(conn=mySQLiteDB,
             name="SQLChickWeight",
             value=data.frame(ChickWeight))
# Conn = connection to database
# name = name of table to create
# value is a data.frame

# Use SQL with the database ---------------------------------------------
doThisSQL <- "select Chick, weight 
from SQLChickWeight 
where weight > 100
limit 10"
dbGetQuery(mySQLiteDB,doThisSQL)
