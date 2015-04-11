                                    ## Plot3.R ##
## This script reads the data from the file "household_power_consumption.txt" from 
## The UCI Machine learning repository's Electric Power Consumption data, and plots
## the a line graph of the sub-metering data (minute averaged) measured in Kilowatt
## at three different segments of the house, marekd as sub_metering_1, sub_metering_2
## and sub_metering_3, for two days (01/Feb/2007 and 02/Feb/2007) and saves it in the
## file plot3.png with 480 x 480 resolution
#####################################################################################
## The CODE
###############
## Clear the global environment
rm(list=ls())

## Reading Data
file <- "household_power_consumption.txt";

## For convenience, since data from only 2 days is required for this exploratory plot
## assignment, we read only a portion of this rather large data set, and then filter out
## the desired data, we first read a header of the dataset to determing the header for the
## data.frame and set the Date class to the first column to be used for the filter.

raw1<- read.table(file,header=TRUE,sep=";",nrows=10); 
colname <- names(raw1);

raw <- read.table(file,header=FALSE,sep=";",skip=66000,nrows=4000);
names(raw)<- colname;
raw$Date <- as.Date(raw$Date, format="%d/%m/%Y") # set Date class to the date column

raw <- raw[which(raw$Date >="2007-02-01" 
                 & raw$Date<="2007-02-02"), ] # filter out the desired data
rm(raw1); # clear the temporary dataframe
DateTime <- as.POSIXlt(paste(raw$Date, raw$Time), format="%Y-%m-%d %H:%M:%S")

### To read the entire dataset, comment the above lines and uncomment the following
###raw <- read.table(file,header=TRUE,sep=";");
###raw$Date <- as.Date(raw$Date, format="%d/%m/%Y")
###raw <- raw[which(raw$Date >="2007-02-01" & raw$Date<="2007-02-02"), ]

## Plotting
png("plot3.png", width=480, height=480, res=80)
lincolrs <- c("black","red","blue")
data<- raw[ ,7:9];
plot(DateTime,data$Sub_metering_1,type='l',
     col="Black",main="",xlab="",ylab="Energy sub_metering");
lines(DateTime,data$Sub_metering_2,type='l',col="Red")
lines(DateTime,data$Sub_metering_3,type='l',col="blue")
legend('topright', names(data) , 
       lty=1, col=c('black', 'red', 'blue'), bty='n', cex=.75)
dev.off()
