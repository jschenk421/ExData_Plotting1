require("sqldf")        # Required library for subsetting the dataset
require("lubridate")    # Required library for manipulating dates

fileUrl<- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileName<-"household_power_consumption.txt" 

# If the dataset is not yet present in the workspace then
# download and unzip it.
if (!file.exists(fileName)){
        download.file(fileUrl,destfile="temp.zip", method="curl")
        unzip("temp.zip")
        unlink("temp.zip")
}

# Read the data we are interested in
rawdata <- read.csv2.sql(fileName, sql = "select * from file where Date in ('1/2/2007','2/2/2007')")  
closeAllConnections()
# Concatenate date and time
rawdata$date_time <- dmy_hms(paste(rawdata$Date, rawdata$Time))

# Keep the current locale
currentLocale<-Sys.getlocale('LC_TIME')

# Set the locale to English
Sys.setlocale('LC_TIME', 'C')

# Create the plot with the English locale
png("plot4.png", width=480, height=480)
par(mfcol=c(2,2))

# plot the one that is in plot 2
plot(rawdata$date_time,rawdata$Global_active_power,type="l",ylab="Global Active Power",xlab="")

# plot the one that is in plot 3
with(rawdata, plot(date_time,Sub_metering_1,type="n",ylab="Energy sub metering",xlab=""))
legend("topright", box.col=par("bg"), lty=c(1,1,1), col=c("black", "red", "blue"),legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
with(rawdata, lines(date_time,Sub_metering_1))
with(rawdata, lines(date_time,Sub_metering_2,col="red"))
with(rawdata, lines(date_time,Sub_metering_3,col="blue"))

# plot the Voltage plot
with(rawdata, plot(date_time,Voltage,type="l",xlab="datetime"))

# plot the reactive power plot
with(rawdata, plot(date_time,Global_reactive_power,type="l",xlab="datetime"))

dev.off()

# Set the locale back to it's original
Sys.setlocale('LC_TIME', currentLocale)


