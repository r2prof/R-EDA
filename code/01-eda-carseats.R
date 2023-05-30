#------------------------------------------------------
# Exploratory Data Analysis
# https://cran.r-project.org/web/packages/dlookr/vignettes/EDA.html
#------------------------------------------------------
# dlookr package
# To illustrate the basic use of EDA in the dlookr package, I use a Carseats dataset. Carseats in the ISLR package 
# is a simulated data set containing sales of child car seats at 400 different stores. This data is a data.frame 
# created for the purpose of predicting sales volume.
#

library(ISLR)
str(Carseats)
#install.packages("dlookr")
library(dlookr)
#
# The contents of individual variables are as follows. (Refer to ISLR::Carseats Man page)
#--------------
# Sales
#--------------
# Unit sales (in thousands) at each location
#--------------
# CompPrice
#--------------
# Price charged by competitor at each location
#--------------
# Income
#--------------
# Community income level (in thousands of dollars)
#--------------
# Advertising
#--------------
# Local advertising budget for company at each location (in thousands of dollars)
#--------------
# Population
#--------------
# Population size in region (in thousands)
#--------------
# Price
#--------------
# Price company charges for car seats at each site
#--------------
# ShelveLoc
#--------------
# A factor with levels Bad, Good and Medium indicating the quality of the shelving location for the car seats at each site
#--------------
# Age
#--------------
# Average age of the local population
#--------------
# Education
#--------------
# Education level at each location
#--------------
# Urban
#--------------
# A factor with levels No and Yes to indicate whether the store is in an urban or rural location
#--------------
# US
#--------------
# A factor with levels No and Yes to indicate whether the store is in the US or not
#
#-------------------------------------------------------
# When data analysis is performed, data containing missing values is frequently encountered. However, ‘Carseats’ is 
# complete data without missing values. So the following script created the missing values and saved them as carseats.
#-------------------------------------------------------
carseats <- ISLR::Carseats

set.seed(123)
carseats[sample(seq(NROW(carseats)), 20), "Income"] <- NA

set.seed(456)
carseats[sample(seq(NROW(carseats)), 10), "Urban"] <- NA
View(carseats)
#-------------------------------------------------------
describe(carseats)

# The following explains the descriptive statistics only for a few selected variables.:
# Select columns by name
describe(carseats, Sales, CompPrice, Income)
