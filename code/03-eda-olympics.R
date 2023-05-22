# Olympics EDA
#-----------------------------------------------
#
# Load the dataset
#-----------------------------------------------
atheletes <- read.csv("athlete_events.csv", stringsAsFactors = F)
regions <- read.csv("noc_regions.csv", stringsAsFactors = F)
#
# stringsAsFactors = F: It is an argument in the read.csv function. By setting stringsAsFactors to F, you
# are instructing R to treat character strings in the CSV file as regular strings instead of converting them 
# into factors.

# Contents of the dataset
#-----------------------------------------------
# The file athlete_events.csv contains 271116 rows and 15 columns. Each row corresponds to an individual athlete 
# competing in an individual Olympic event (athlete-events). The columns are:
#  
# The Athletes dataset contains 15 variables:
#-----------------------------------------------
# 1.  ID: A number used as a unique identifier for each athlete
# 2.  Name: The athlete’s name(s) in the form of First Middle Last where available (categorical var)
# 3.  Sex: The athlete’s gender; one of M or F 4 Age: The athlete’s age in years (categorical var)
# 4.  Age: The athelet's age in years
# 5.  Height: The athlete’s height in centimeters (cm)
# 6.  Weight: The athlete’s weight in kilograms (kg)
# 7.  Team: The name of the team that the athlete competed for (categorical var)
# 8.  NOC: The National Organizing Committee’s 3-letter code (categorical var)
# 9.  Games: The year and season of the Olympics the athlete competed in in the format YYYY Season (categorical var)
# 10.  Year: The year of the Olympics that the athlete competed in
# 11. Season: The season of the Olympics that the athlete competed in (categorical var)
# 12. City: The city that hosted the Olympics that the athlete competed in
# 13. Sport: The sport that the athlete competed in (categorical var)
# 14. Event: The event that the athlete competed in (categorical var)
# 15. Medal: The medal won by the athlete; one of Gold, Silver, or Bronze. NA if no medal was won. (categorical var)
#-----------------------------------------------
# View the dataset
#-----------------------------------------------
head(atheletes)
View(atheletes)
#
#-----------------------------------------------
# Summary of the dataset
#-----------------------------------------------
summary(atheletes)
#
#-----------------------------------------------
# # Count the number of NA values in the dataset
na_count <- sum(is.na(atheletes))

# Print the result
print(na_count)
#
#-----------------------------------------------
# Convert athletes data into the dataframe
df <- data.frame(atheletes)
#
#-----------------------------------------------
# Change 'NA' in the Medal column to ‘No Medal’
#
# Using replace()
df$Medal <- replace(df$Medal, is.na(df$Medal), "No Medal")
#
View(df)
#-----------------------------------------------
# Count the number of NA values in the dataset
na_count <- sum(is.na(df))

# Print the result
print(na_count)
#---------------------------------------------
# Handle remaining NA values in Height, Weight and Age columns
#
df1 <- subset(df, !is.na(Height+Weight+Age))
View(df1)
#
# df: This refers to the original data frame from which you want to create a subset.

# Height + Weight + Age: This expression calculates the sum of the columns "Height," "Weight," and "Age" 
# for each row in the data frame df. The + operator is used to add the values together.
# 
# is.na(Height + Weight + Age): This expression checks if the sum of "Height," "Weight," and "Age" for each 
# row contains NA values. It returns a logical vector of TRUE or FALSE, indicating whether each row has NA 
# values or not.
# 
# !is.na(Height + Weight + Age): The ! operator negates the logical vector, effectively selecting the rows that 
# do not contain NA values. It returns TRUE for rows without NA values and FALSE for rows with NA values.
# 
# subset(df, !is.na(Height + Weight + Age)): The subset() function takes the original data frame df and selects 
# the rows where the condition !is.na(Height + Weight + Age) is TRUE. In other words, it subsets the data frame to 
# include only the rows that do not have NA values in the sum of "Height," "Weight," and "Age."
# 
# df1 <- subset(df, !is.na(Height + Weight + Age)): Finally, the resulting subset of the data frame is assigned 
# to a new data frame called df1.
# 
# In summary, the code creates a new data frame df1 by selecting only the rows from the original data frame df 
# where there are no NA values in the sum of "Height," "Weight," and "Age" columns.
# 
# 
#--------------------------------------------------------------------------
#Count the number of NA values in the dataset
na_count <- sum(is.na(df1))

# Print the result
print(na_count)
#
# Load the required libraries
#--------------------------------------------------------------------------
library(dplyr)
library(ggplot2)
library(tidyverse)
library(rvest)
library(magrittr)
library(ggmap)        # check the code in the example
library(stringr)
#---------------------------------------------------------------------------
# library(rvest)
# Information about "rvest" package
# 
# In R programming, `library(rvest)` is a command used to load the "rvest" package. The "rvest" package is a 
# popular R package used for web scraping, which is the process of extracting data from websites.
# Once the package is loaded with the `library(rvest)` command, you can use its functions and features in your 
# R script. The "rvest" package provides tools to navigate and parse HTML or XML web pages, extract specific data elements, and perform various web scraping tasks.
# Here's an example of how you can use the "rvest" package to scrape the title of a webpage:
#
library(rvest)
# Specify the URL of the webpage you want to scrape
url <- "https://www.example.com"
# Read the HTML content of the webpage
webpage <- read_html(url)
#
# Extract the title of the webpage
title <- html_text(html_nodes(webpage, "title"))
# Print the title
print(title)
#
# In this example, `read_html()` function reads the HTML content of the specified webpage, `html_nodes()` function 
# selects the HTML nodes with the "title" tag, and `html_text()` function extracts the text content from the selected 
# node. Finally, the extracted title is printed using `print()`.
#
# Keep in mind that web scraping should be done responsibly and in accordance with the website's terms of service. 
# It's always a good practice to be mindful of the website's policies and limitations when scraping data.
#---------------------------------------------------------------------------
# library(magrittr)
# In R programming, `library(magrittr)` is a command used to load the "magrittr" package. The "magrittr" package is 
# a powerful R package that provides a set of operators and functions for creating expressive and readable code 
# through a pipe-like syntax.
#
# Once the package is loaded with the `library(magrittr)` command, you can use its pipe operator `%>%` and other 
# functions to enhance the readability and conciseness of your code.
#
#The pipe operator `%>%` allows you to pass the output of one function as the input to another function, making it 
# easier to chain multiple operations together. It helps create a more readable code flow, as the data being 
# processed is passed from left to right, similar to a pipe.
# 
# By using the "magrittr" package, you can write code that reads more like a series of sequential steps, improving 
# code readability and reducing the need for intermediate variables.
#
# It's worth noting that the `magrittr` package provides various other functions and features beyond the pipe operator, 
# such as the `%<>%` compound assignment pipe operator and functions for data manipulation and transformation.
#---------------------------------------------------------------------------
# library(ggmap)
# 
# In R programming, `library(ggmap)` is a command used to load the "ggmap" package. The "ggmap" package is an R 
# interface to the Google Maps API, providing functions to visualize spatial data and create maps using the ggplot2 
# framework.

# Once the package is loaded with the `library(ggmap)` command, you can use its functions and features to work with 
# geographic data, geocoding, and map visualization.
# 
# Here are a few key functionalities offered by the "ggmap" package:
#   1. Geocoding: The package provides functions to convert addresses or place names into latitude and longitude 
#      coordinates using the Google Maps Geocoding API. This can be useful for mapping or analyzing location-based 
#       data.
# 
#   2. Map Visualization: The package extends the capabilities of ggplot2 to create maps. You can overlay data points, 
#      polygons, or paths on maps retrieved from various map sources, including Google Maps, OpenStreetMap, and Stamen 
#      Maps. The maps can be customized with different map styles, zoom levels, and annotations.
# 
#   3. Spatial Data Manipulation: The "ggmap" package integrates with other spatial packages in R, such as sp, sf, and 
#      raster, allowing you to import, manipulate, and analyze spatial data in conjunction with map visualization.
# 
#     Here's an example that demonstrates the use of the "ggmap" package to create a simple map:
# 
library(ggmap)
# 
# Retrieve a map of a specific location using Google Maps
my_map <- get_map(location = "New York City", zoom = 13)
# 
# Create a ggplot object with the map as the background
ggmap(my_map)
#
# 
# In this example, the `get_map()` function retrieves a map of New York City from the Google Maps API, specifying 
# the location and zoom level. Then, the `ggmap()` function is used to create a ggplot object with the retrieved map 
# as the background.
# 
# By utilizing the "ggmap" package, you can combine the data manipulation capabilities of R with the map 
# visualization capabilities of ggplot2, enabling you to explore and present spatial data in an aesthetically 
# pleasing and informative manner.
# 
# Retrieve a map of a specific location using Google Maps
my_map <- get_map(location = "New York City", zoom = 13)
# 
# Create a ggplot object with the map as the background
ggmap(my_map)

#---------------------------------------------------------------------------
library(stringr)

# Define a sample string
my_string <- "Hello, World!"

# Extract the first 5 characters from the string
substring <- str_sub(my_string, start = 1, end = 5)

# Convert the string to uppercase
uppercase_string <- str_to_upper(my_string)

# Print the results
print(substring)
print(uppercase_string)
#---------------------------------------------------------------------------
# Initial analysis
glimpse(atheletes)
glimpse(regions)


library(ggplot2)

ggplot(df1, aes(x = Age)) +
  geom_histogram(binwidth = 1, fill = "pink", col = "blue") +
  labs(x = "Age", y = "Number of People", title = "Distribution of Ages") 

library(ggplot2)

ggplot(df1, aes(x = Sex)) +
  geom_bar(fill = "orange", col = "purple") +
  labs(x = "Gender", y = "Number of People", title = "Distribution of Gender") 
  
library(ggplot2)

ggplot(df1, aes(x = Height)) +
  geom_histogram(binwidth = 1, fill = "black", col = "green") +
  labs(x = "Height", y = "Number of People", title = "Distribution of Height") +
  scale_x_continuous(limits = c(127, 226), breaks = seq(127, 226, 10))
library(ggplot2)

ggplot(df1, aes(x = Weight)) +
  geom_histogram(binwidth = 1, fill = "grey", col = "red") +
  labs(x = "Weight", y = "Number of People", title = "Distribution of Weight") 
  

