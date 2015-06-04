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
plot(rawdata$date_time,rawdata$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")

# Copy it to file
dev.copy(png, file = "plot2.png")
dev.off()

# Set the locale back to it's original
Sys.setlocale('LC_TIME', currentLocale)