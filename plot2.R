# Create Plot1.png
#
# A histogram of Global Active Power
#

# Load a utility library that manages the downloads.
source('Utilites.R')

# load.data() (found in Utilities.R) Checks to see if the zip file has been downloaded from
# the provided URL.  If it hasn't then it downloads the file and unzips it.
#
# Then it only imports records for February 1st and 2nd 2007.
# Finaly, it creates a timestamp field from the Date and Time fields and returns
# a data.table object.
dt <- load.data()

message("Generating Plot - plot2.png")
png("plot2.png")
plot(dt$timestamp, dt$Global_active_power, type="l", ylab="Global Active Power(kilowatts)", xlab="")
dev.off()
message("Done!")