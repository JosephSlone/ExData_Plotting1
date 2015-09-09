# Create Plot1.png
#
# A histogram of Global Active Power
#

png("plot1.png")
hist(dt$Global_active_power, col = 'red', main="Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()