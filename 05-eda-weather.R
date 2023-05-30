# Exploratory Data Analysis
# Dataset on hourly ozone levels in the United States for the year 2014.
#
# EDA Steps:
# 1. Formulate your question
# 2. Read in your data
# 3. Check the packaging
# 4. Run str()
# 5. Look at the top and the bottom of your data
# 6. Check your “n”s
# 7. Validate with at least one external data source
# 8. Try the easy solution first
# 9. Challenge your solution
# 10. Follow up

#-----------------------------------------------
# Load the dataset
#-----------------------------------------------
setwd("/Users/raza/My Drive-K/GitHub/R-EDA/data")
weather <- read.csv("weather.csv", stringsAsFactors = F)

#-----------------------------------------------
# View the dataset
#-----------------------------------------------
head(weather)
View(atheletes)
#
#-----------------------------------------------
# Summary of the dataset
#-----------------------------------------------
summary(weather)
#
library(dplyr)
glimpse(weather)
#
#-----------------------------------------------
# # Count the number of NA values in the dataset
(na_count <- sum(is.na(weather)))
#
#-----------------------------------------------
# Finding the data type of each column
(column_types <- sapply(weather, class))
#
#-----------------------------------------------
# To find unique values in a column of a given dataset in R, you can use the unique() function. 
# Q. 1) Find all the unique 'Wind Speed' values in the data.
#
# Finding unique values in the 'Wind Speed' column
(unique_Wind.Speed.value <- unique(weather$Wind.Speed_km.h))
#
# Finding the total number of unique values in the 'Wind Speed' column
(unique_count <- length(unique(weather$Wind.Speed_km.h)))
#
# Finding unique values in the 'Weather' column
(unique_Weather.value <- unique(weather$Weather))
# 
# Finding the total number of unique values in the 'name' column
(unique_count <- length(unique(weather$Weather)))
#
# Counting unique values in the 'name' column
(unique_counts <- as.data.frame(table(weather$Weather)))
#
# Sorting unique values by counts in descending order
(unique_counts <- unique_counts[order(-unique_counts$Freq), ])
#
# Sorting unique values by counts in ascending order
(unique_counts <- unique_counts[order(unique_counts$Freq), ])
#
#-----------------------------------------------
# Find the basic info of the data/data frame.
# Print the structure of the data/data frame
(str(weather))

# Print the summary statistics of the data/data frame
(summary(weather))
#
#-----------------------------------------------
# Q. 1) Find all the unique 'Wind Speed' values in the data.
# Q. 2) Find the number of times when the 'Weather is exactly Clear'.
# Q. 3) Find the number of times when the 'Wind Speed was exactly 4 km/h'.
# Q. 4) Find out all the Null Values in the data.
# Q. 5) Rename the column name 'Weather' of the dataframe to 'Weather Condition'.
# Q. 6) What is the mean 'Visibility' ?
# Q. 7) What is the Standard Deviation of 'Pressure'  in this data?
# Q. 8) What is the Variance of 'Relative Humidity' in this data ?
# Q. 9) Find all instances when 'Snow' was recorded.
# Q. 10) Find all instances when 'Wind Speed is above 24' and 'Visibility is 25'.
# Q. 11) What is the Mean value of each column against each 'Weather Condition ?
# Q. 12) What is the Minimum & Maximum value of each column against each 'Weather Condition ?
# Q. 13) Show all the Records where Weather Condition is Fog.
# Q. 14) Find all instances when 'Weather is Clear' or 'Visibility is above 40'.
# Q. 15) Find all instances when : A. 'Weather is Clear' and 'Relative Humidity is greater than 50' or
#                                  B. 'Visibility is above 40'