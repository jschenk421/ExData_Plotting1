# Required library for subsetting the dataset
require("sqldf")

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

# Create the plot
hist(rawdata$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")

# Copy it to file
dev.copy(png, file = "plot1.png")
dev.off()