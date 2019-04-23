install.packages('data.table')
library("data.table")

setwd("G:\\datascience\\EDA")

#load the data
powerdata <- read.table("household_power_consumption.txt",skip=1,sep=";")
#rename headers
names(powerdata) <- c("Date","Time","active_power","reactive_power","Voltage","intensity","SubMetering_1","SubMetering_2","SubMetering_3")
#Filter Dates for 01 Feb 2007 and 02 Feb 2007
subSetData <- powerdata[powerdata$Date %in% c("1/2/2007","2/2/2007") ,]

png("plot1.png", width=480, height=480) #save the figure
#create histograme
hist(as.numeric(as.character(subSetData$active_power)),col="red",main="Global Active Power",xlab="Global Active Power(kilowatts)")
