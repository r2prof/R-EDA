# Olympics EDA
#------------------
#
# Load the dataset
#------------------
atheletes <- read.csv("athlete_events.csv", stringsAsFactors = F)
regions <- read.csv("noc_regions.csv", stringsAsFactors = F)
#
# stringsAsFactors = F: It is an argument in the read.csv function. By setting stringsAsFactors to F, you
# are instructing R to treat character strings in the CSV file as regular strings instead of converting them 
# into factors.

# Contents of the dataset
#---------------------------
# The file athlete_events.csv contains 271116 rows and 15 columns. Each row corresponds to an individual athlete 
# competing in an individual Olympic event (athlete-events). The columns are:
#  
# ID - Unique number for each athlete
# Name - Athlete’s name
# Sex - M or F
# Age - Integer
# Height - In centimeters
# Weight - In kilograms
# Team - Team name
# NOC - National Olympic Committee 3-letter code
# Games - Year and season
# Year - Integer
# Season - Summer or Winter
# City - Host city
# Sport - Sport
# Event - Event
# Medal - Gold, Silver, Bronze, or NA
#
# View the dataset
#------------------
head(atheletes)
View(atheletes)
#
# Load required libraries
#--------------------------








