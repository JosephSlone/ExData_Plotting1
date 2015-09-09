# Create Plot1.png
#
# A histogram of Global Active Power
#

source('Utilites.R')

dt <- load.data()

message("Generating Plot - plot2.png")
png("plot2.png")
plot(dt$timestamp, dt$Global_active_power, type="l", ylab="Global Active Power(kilowatts)", xlab="")
dev.off()
message("Done!")