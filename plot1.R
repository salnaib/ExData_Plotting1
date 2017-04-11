# Load libraries
library(dplyr)
library(lubridate)
library(Hmisc)

# Read in data
household_power_consumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";") 

# Clean the data
# Filter the data
household_power_consumption_cleaned <- household_power_consumption %>%
  mutate(Date = dmy(Date), Time = hms(Time)) %>%
  mutate(Global_active_power = as.numeric(as.character(Global_active_power))) %>%
  filter(!is.null(Global_active_power)) %>%
  filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

# Create the png file
png(filename="plot1.png", height=480, width=480)

# Plot the histogram
hist(household_power_consumption_cleaned$Global_active_power, main="Global Active Power"
     ,xlab="Global Active Power (kilowatts)", ylab="Frequency", col="red", ylim = c(0,1200), xlim = c(0,6))

# Close the connection to the png device
dev.off()
