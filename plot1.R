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

# And finaly, plot the graph
message("Generating Plot - plot1.png")
png("plot1.png")
hist(dt$Global_active_power, col = 'red', main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
message("Done!")