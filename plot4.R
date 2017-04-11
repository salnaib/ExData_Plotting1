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
         ,Sub_metering_3 = as.numeric(as.character(Sub_metering_3))
         ,Voltage = as.numeric(as.character(Voltage))
         ,Global_reactive_power = as.numeric(as.character(Global_reactive_power))) %>%
  filter(!is.null(Global_active_power)) %>%
  filter(Date == ymd("2007-02-01") | Date == ymd("2007-02-02"))

# Create the png file
png(filename="plot4.png", height=480, width=480)

old.par <- par(mfrow=c(2, 2))

# Plot the first graph
plot(household_power_consumption_cleaned$Global_active_power, type = "l"
     ,ylab="Global Active Power (kilowatts)", xlab = "", xaxt = "n")
# Make x axis labels and position
axis(1, labels=c("Thu", "Fri", "Sat"), at=c(1,length(household_power_consumption_cleaned$Global_active_power)/2,length(household_power_consumption_cleaned$Global_active_power)))

# Plot the second graph
plot(household_power_consumption_cleaned$Voltage, type = "l"
     ,ylab="Voltage", xlab = "", xaxt = "n")
# Make x axis labels and position
axis(1, labels=c("Thu", "Fri", "Sat"), at=c(1,length(household_power_consumption_cleaned$Global_active_power)/2,length(household_power_consumption_cleaned$Global_active_power)))

# Plot the third graph
plot(household_power_consumption_cleaned$Sub_metering_1, type = "l"
     ,ylab="Energy Sub Metering", xlab = "", xaxt = "n")
lines(household_power_consumption_cleaned$Sub_metering_2,col="red")
lines(household_power_consumption_cleaned$Sub_metering_3,col="blue")
# Make x axis labels and position
axis(1, labels=c("Thu", "Fri", "Sat"), at=c(1,length(household_power_consumption_cleaned$Global_active_power)/2,length(household_power_consumption_cleaned$Global_active_power)))
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=c(1,1,1), col=c("black","blue","red"), bty = "n")

# Plot the fourth graph
plot(household_power_consumption_cleaned$Global_reactive_power, type = "l"
     ,ylab="Global_reactive_power", xlab = "", xaxt = "n")
# Make x axis labels and position
axis(1, labels=c("Thu", "Fri", "Sat"), at=c(1,length(household_power_consumption_cleaned$Global_active_power)/2,length(household_power_consumption_cleaned$Global_active_power)))

par(old.par)

# Close the connection to the png device
dev.off()
