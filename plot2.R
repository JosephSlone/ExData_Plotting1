# Create Plot1.png
#
# A histogram of Global Active Power
#

png("plot2.png")
plot(dt$timestamp, dt$Global_active_power, type="l", ylab="Global Active Power(kilowatts)", xlab="")
dev.off()