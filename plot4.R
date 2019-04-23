library("data.table")

setwd("G:\\datascience\\EDA")

#load the data
powerdata <- read.table("household_power_consumption.txt",skip=1,sep=";")
#rename headers
names(powerdata) <- c("Date","Time","active_power","reactive_power","Voltage","intensity","SubMetering_1","SubMetering_2","SubMetering_3")
#Filter Dates for 01 Feb 2007 and 02 Feb 2007
subSetData <- powerdata[powerdata$Date %in% c("1/2/2007","2/2/2007") ,]

# convert date and time to objects of type Date and POSIXlt 
subSetData$Date <- as.Date(subSetData$Date, format="%d/%m/%Y")
subSetData$Time <- strptime(subSetData$Time, format="%H:%M:%S")

subSetData[1:1440,"Time"] <- format(subSetData[1:1440,"Time"],"2007-02-01 %H:%M:%S")
subSetData[1441:2880,"Time"] <- format(subSetData[1441:2880,"Time"],"2007-02-02 %H:%M:%S")


png("plot4.png", width=480, height=480)
# initiating a composite plot with many graphs
par(mfrow=c(2,2))

# call the perivious graphs from plot 2,3 and make a new plot with 4 graphs
with(subSetData,{
        plot(subSetData$Time,as.numeric(as.character(subSetData$active_power)),type="l",  xlab="",ylab="Global Active Power")  
        plot(subSetData$Time,as.numeric(as.character(subSetData$Voltage)), type="l",xlab="datetime",ylab="Voltage")
        plot(subSetData$Time,subSetData$SubMetering_1,type="n",xlab="",ylab="Energy sub metering")
        with(subSetData,lines(Time,as.numeric(as.character(SubMetering_1))))
        with(subSetData,lines(Time,as.numeric(as.character(SubMetering_2)),col="red"))
        with(subSetData,lines(Time,as.numeric(as.character(SubMetering_3)),col="blue"))
        legend("topright", lty=1, col=c("black","red","blue"),legend=c("SubMetering_1","SubMetering_2","SubMetering_3"), cex = 0.6)
        plot(subSetData$Time,as.numeric(as.character(subSetData$reactive_power)),type="l",xlab="datetime",ylab="Global reactivepower")
})
