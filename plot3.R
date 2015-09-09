# Generate the Energy sub metering line plot

source('Utilites.R')

dt <- load.data()

message("Generating Plot - plot3.png")

png("plot3.png")
plot(dt$timestamp, dt$Sub_metering_1, col = 'black', type='l', xlab="", ylab="Energy sub metering")
points(dt$timestamp, dt$Sub_metering_2, col="red", type="l")
points(dt$timestamp, dt$Sub_metering_3, col="blue", type="l")
legend("topright", legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c("black","red","blue"), lty=c(1,1))
dev.off()

message("Done!")