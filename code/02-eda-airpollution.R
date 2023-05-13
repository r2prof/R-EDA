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

# 1. Formulate your question:
# Are air pollution levels higher on the east coast than on the west coast?
# But a more specific question might be
# Are hourly ozone levels on average higher in New York City than they are in Los Angeles?
#
# 2. Read in your data
#
# The character string provided to the col_types argument specifies the class of each
# column in the dataset. Each letter represents the class of a column: “c” for character, “n”
# for numeric”, and “i” for integer. No, I didn’t magically know the classes of each column—
# I just looked quickly at the file to see what the column classes were. If there are too many
# columns, you can not specify col_types and read_csv() will try to figure it out for you.
library(readr)
ozone <- read_csv("data/hourly_44201_2014.csv",col_types = "ccccinnccccccncnncccccc")
ozone <- read_csv("data/hourly_44201_2014.csv")
head(ozone)
#
# Just as a convenience for later, we can rewrite the names of the columns to remove any spaces.
names(ozone) <- make.names(names(ozone))
#
# 3. Check the packaging
# Assuming you don’t get any warnings or errors when reading in the dataset, you should
# now have an object in your workspace named ozone. It’s usually a good idea to poke at
# that object a little bit before we break open the wrapping paper.
nrow(ozone)
ncol(ozone)
head(ozone)
#
# 4. Run str()
# Another thing you can do is run str() on the dataset. This is usually a safe operation in
# the sense that even with a very large dataset, running str() shouldn’t take too long.
str(ozone)
#
# 5. Look at the top and bottom of your data
# You can peek at the top and bottom of the data with the head() and tail() functions.
# First six rows with 6th, 7th and 10th column
head(ozone[, c(6:7, 10)]) # First six rows with 6th, 7th and 10th column
#
# Last six rows with 6th, 7th and 10th column
tail(ozone[, c(6:7, 10)])
#
# 6. Check your "n"s
# In this example, we will use the fact that the dataset purportedly contains hourly data for
# the entire country. These will be our two landmarks for comparison.
#
# Here, we have hourly ozone data that comes from monitors across the country. The
# monitors should be monitoring continuously during the day, so all hours should be 
# represented. We can take a look at the Time. Local variable to see what time measurements
# are recorded as being taken.
table(ozone$Time.Local)
#
# All the values are good. I think the data is further refined and now it does not show that
# kind of information displayed in the book.
# I have just written the code here to test. However the code does not return anything. 
#
library(dplyr)
filter(ozone, Time.Local == "00:01") %>%
  select(State.Name, County.Name, Date.Local, Time.Local, Sample.Measurement)
# 
# We further verify this and there is no issue in contrast to what is mentioned in the textbook.
filter(ozone, State.Code == "36"
       & County.Code == "033"
       & Date.Local == "2014-09-30") %>%
  select(Date.Local, Time.Local,
           Sample.Measurement) %>% as.data.frame
#
# Since EPA monitors pollution across the country, there should be a good representation
# of states. Perhaps we should see exactly how many states are represented in this dataset.
select(ozone, State.Name) %>% unique %>% nrow
#
# So it seems the representation is a bit too good—there are 52 states in the dataset, but
# only 50 states in the U.S.!
# We can take a look at the unique elements of the State.Name variable to see what’s going on.
unique(ozone$State.Name)
#
# Now we can see that Washington, D.C.(District of Columbia), Country of Mexico and Puerto Rico 
# are the “extra” states included in the dataset. Since they are clearly part of the U.S. 
# (but not official states of the union) that all seems okay.
#
# This last bit of analysis made use of something we will discuss in the next section: external
# data. We knew that there are only 50 states in the U.S., so seeing 53 state names was an
# immediate trigger that something might be off. In this case, all was well, but validating
# your data with an external data source can be very useful.
#
# 5.7 Validate with at least one external data source
# Making sure your data matches something outside of the dataset is very important. It
# allows you to ensure that the measurements are roughly in line with what they should
# be and it serves as a check on what other things might be wrong in your dataset. External
# validation can often be as simple as checking your data against a single number, as we
# will do here.
#
# In the U.S. we have national ambient air quality standards, and for ozone, the current
# standard set in 2008 is that the “annual fourth-highest daily maximum 8-hr concentration,
# averaged over 3 years” should not exceed 0.075 parts per million (ppm). The exact
# details of how to calculate this are not important for this analysis, but roughly speaking,
# the 8-hour average concentration should not be too much higher than 0.075 ppm (it can
# be higher because of the way the standard is worded).
# Let’s take a look at the hourly measurements of ozone.
summary(ozone$Sample.Measurement)
#
# From the summary we can see that the maximum hourly concentration is quite high
# (0.2130 ppm) but that in general, the bulk of the distribution is far below 0.075.
#
# We can get a bit more detail on the distribution by looking at deciles of the data.
quantile(ozone$Sample.Measurement, seq(0, 1, 0.1))
#
# Knowing that the national standard for ozone is something like 0.075, we can see from
# the data that
# • The data are at least of the right order of magnitude (i.e. the units are correct)
# • The range of the distribution is roughly what we’d expect, given the regulation
# around ambient pollution levels
# • Some hourly levels (less than 10%) are above 0.075 but this may be reasonable given
# the wording of the standard and the averaging involved.
#
# 5.8 Try the easy solution first
# Recall that our original question was Which counties in the United States have the highest 
# levels of ambient ozone pollution?
#
# What’s the simplest answer we could provide to this question? For the moment, don’t worry about 
# whether the answer is correct, but the point is how could you provide prima facie evidence for 
# your hypothesis or question. You may refute that evidence later withdeeper analysis, but this 
# is the first pass.
#
# Because we want to know which counties have the highest levels, it seems we need a list of counties 
# that are ordered from highest to lowest with respect to their levels of ozone.
#
# What do we mean by “levels of ozone”? For now, let’s just blindly take the average across the entire 
# year for each county and then rank counties according to this metric.
# 
# To identify each county we will use a combination of the State.Name and the County.Name variables.
ranking <- group_by(ozone, State.Name, County.Name) %>%
  summarize(ozone = mean(Sample.Measurement)) %>%
  as.data.frame %>%
  arrange(desc(ozone))
head(ranking, 10)
tail(ranking, 10)
#
# Let’s take a look first two of the higest level counties, Clear Creek, Colorado, and Mariposa County, California. 
#First let’s see how many observations there are for these county in the dataset.
#
filter(ozone, State.Name == "Colorado" & County.Name == "Clear Creek") %>% nrow
filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>% nrow
#
# Always be checking. Does that number of observations sound right? Well, there’s 24
# hours in a day and 365 days per, which gives us 8760, which is close to that number
# of observations. 
#
# Sometimes the counties use alternate methods of measurement during the year so there 
# may be “extra” measurements. We can take a look at how ozone varies through the year 
# in this county by looking at monthly averages. 
# 
# First we’ll need to convert the date variable into a Date class.
ozone <- mutate(ozone, Date.Local = as.Date(Date.Local))
#
# Then we will split the data by month to look at the average hourly levels.
filter(ozone, State.Name == "California" & County.Name == "Mariposa") %>%
  mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  group_by(month) %>%
  summarize(ozone = mean(Sample.Measurement))
#
filter(ozone, State.Name == "Colorado" & County.Name == "Clear Creek") %>%
  mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  group_by(month) %>%
  summarize(ozone = mean(Sample.Measurement))
#
# Now let’s take a look at one of the lowest level counties, Caddo County, Oklahoma.
filter(ozone, State.Name == "Oklahoma" & County.Name == "Caddo") %>% nrow
#
filter(ozone, State.Name == "Alaska" & County.Name == "Fairbanks North Star") %>% nrow
#
filter(ozone, State.Name == "Puerto Rico" & County.Name == "Bayamon") %>% nrow
filter(ozone, State.Name == "Puerto Rico" & County.Name == "Catano") %>% nrow
#
# Here we see that there are perhaps fewer observations than we would expect for a
# monitor that was measuring 24 hours a day all year. We can check the data to see if
# anything funny is going.
#
filter(ozone, State.Name == "Oklahoma" & County.Name == "Caddo") %>%
  mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  group_by(month) %>%
  summarize(ozone = mean(Sample.Measurement))
#
filter(ozone, State.Name == "Alaska" & County.Name == "Fairbanks North Star") %>%
  mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  group_by(month) %>%
  summarize(ozone = mean(Sample.Measurement))
#
filter(ozone, State.Name == "Puerto Rico" & County.Name == "Catano") %>%
  mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  group_by(month) %>%
  summarize(ozone = mean(Sample.Measurement))
#
filter(ozone, State.Name == "Puerto Rico" & County.Name == "Bayamon") %>%
  mutate(month = factor(months(Date.Local), levels = month.name)) %>%
  group_by(month) %>%
  summarize(ozone = mean(Sample.Measurement))
#
# Here we can see that the levels of ozone are much lower in this county and that also few
# months are missing. Given the seasonal nature of ozone, it’s possible that the levels of 
# ozone are so low in those months that it’s not even worth measuring. In fact some of the 
# monthly averages are below the typical method # detection limit of the measurement technology, 
# meaning that those values are highly uncertain and likely not distinguishable from zero.
#
# 5.9 Challenge your solution
# The easy solution is nice because it is, well, easy, but you should never allow those results
# to hold the day. You should always be thinking of ways to challenge the results, especially
# if those results comport with your prior expectation.
# Now, the easy answer seemed to work okay in that it gave us a listing of counties that had
# the highest average levels of ozone for 2014. However, the analysis raised some issues.