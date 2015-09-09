# Generate the Energy sub metering line plot

# Load a utility library that manages the downloads.
source('Utilites.R')

# load.data() (found in Utilities.R) Checks to see if the zip file has been downloaded from
# the provided URL.  If it hasn't then it downloads the file and unzips it.
#
# Then it only imports records for February 1st and 2nd 2007.
# Finaly, it creates a timestamp field from the Date and Time fields and returns
# a data.table object.

dt <- load.data()

message("Generating Plot - plot3.png")

png("plot3.png")
plot(dt$timestamp, dt$Sub_metering_1, col = 'black', type='l', xlab="", ylab="Energy sub metering")
points(dt$timestamp, dt$Sub_metering_2, col="red", type="l")
points(dt$timestamp, dt$Sub_metering_3, col="blue", type="l")
legend("topright", legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c("black","red","blue"), lty=c(1,1))
dev.off()

message("Done!")