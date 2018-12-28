# Goal: Use R to utilize SQL. For an easier process, I will use SQLdf package.
install.packages("sqldf")
library(sqldf)

# Installing BoxOffice package
# Instead of directly importing data files, I will use Box Office package to
# import from the website.
install.packages("boxoffice")
require(boxoffice)

# Using th-numbers.com, I imported movie performance from Christmas to New Years Eve:
EndMovie <- as.data.frame(boxoffice(dates = as.Date(seq.Date(as.Date("2017-12-25"),as.Date("2017-12-31"), by = "day")), site = "numbers"))

# Time to Use SQL to analyze the Data!

# Find all movies that were on the theater during that period:
sqldf("SELECT DISTINCT movie
       FROM EndMovie;")

# How many movies were featuring during that week:
sqldf("SELECT COUNT(*)
       FROM (SELECT DISTINCT movie
              FROM EndMovie);")

# Not surprisingly, there are 44 movies featuring on the movie during the season,
# showing that a number of movie lineups are very high near the end of the year.

# Find the sum of the gross profit each company made in that week:
sqldf("SELECT distributor, SUM(gross) AS total_gross
       FROM EndMovie
       GROUP BY distributor
       ORDER BY total_gross DESC;")

# Walt Disney was the ultimate winner of this end of the year competition.
# The question is: Why did it make so much profit?
# We decided to extract movies that Walt Disney showed.
sqldf("SELECT movie, SUM(gross) AS total_gross
       FROM EndMovie
       WHERE distributor LIKE 'Walt%'
       GROUP BY movie;")

# Walt Disney showed Coco, Star Wars Episode VIII: The Last Jedi, and Thor: Ragnarok.
# In reality, all three of the movies were successful, making profits for the company.

# How about Sony Pictures? We can try to compare:
sqldf("SELECT movie, SUM(gross) AS total_gross
       FROM EndMovie
       WHERE distributor LIKE 'Sony%'
       GROUP BY movie;")

# There were five movies that Sony featured.
# Considering its aggressive release, they were not able to defeat Walt Disney.


