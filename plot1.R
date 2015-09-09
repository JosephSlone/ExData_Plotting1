# Create Plot1.png
#
# A histogram of Global Active Power
#

source('Utilites.R')

dt <- load.data()

message("Generating Plot - plot1.png")
png("plot1.png")
hist(dt$Global_active_power, col = 'red', main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
message("Done!")