# Load libraries
library(dplyr)
library(lubridate)
library(Hmisc)

# Read in data
household_power_consumption <- read.table("household_power_consumption.txt", header = TRUE, sep = ";") 

# Clean the data
# Filter the data
household_power_consumption_cleaned <- household_power_consumption %>%
  mutate(Date = dmy(Date), Time = hms(Time), DateTime = dmy_hms(paste(Date, Time))) %>%
  mutate(Global_active_power = as.numeric(as.character(Global_active_power))
         ,Sub_metering_1 = as.numeric(as.character(Sub_metering_1))
         ,Sub_metering_2 = as.numeric(as.character(Sub_metering_2))
         ,Sub_metering_3 = as.numeric(as.character(Sub_metering_3))) %>%
  filter(!is.null(Global_active_power)) %>%
  filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

# Create the png file
png(filename="plot3.png", height=480, width=480)

# Plot the graph
plot(household_power_consumption_cleaned$Sub_metering_1, type = "l"
     ,ylab="Energy Sub Metering", xlab = "", xaxt = "n")
lines(household_power_consumption_cleaned$Sub_metering_2,col="red")
lines(household_power_consumption_cleaned$Sub_metering_3,col="blue")
# Make x axis labels and position
axis(1, labels=c("Thu", "Fri", "Sat"), at=c(1,length(household_power_consumption_cleaned$Global_active_power)/2,length(household_power_consumption_cleaned$Global_active_power)))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","blue","red"))

# Close the connection to the png device
dev.off()
