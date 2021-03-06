# Generate the Energy sub metering line plot

# Load a utility library that manages the downloads.
# source('Utilites.R')
# load.data()  only imports records for February 1st and 2nd 2007.
# Finaly, it creates a timestamp field from the Date and Time fields and returns
# a data.table object.

# Okay, I have become nervous about reviewers grading my code incorrectly.
# I had intended to keep load.data() in a seperate file, but paranoia has
# set in.
#

load.data <- function() {

    message("Loading data into datatable")

    # Uses R pipe function and the grep command line program to filter the
    # data to the correct dates.
    
    # To get the grep command for Windows:  
    # Get and install the appropriate version of Rtools from CRAN, 
    # and add the Rtools directory to your path.  The tools include 
    # a version of grep (along with a number of other 'NIX utilities).  
    #
    # The tools can be obtained from here:  
    #      https://cran.r-project.org/bin/windows/Rtools/

    df <- read.csv(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),
                   sep=";", na.strings="?",
                   colClasses=c('character','character', 'numeric', 'numeric',
                                'numeric', 'numeric', 'numeric',
                                'numeric','numeric'),
                   col.names = c('Date', 'Time', 'Global_active_power',
                                 'Global_reactive_power', 'Voltage',
                                 'Global_intensity', 'Sub_metering_1',
                                 'Sub_metering_2','Sub_metering_3'),
                   header = FALSE
    )

    df <- within(df, { timestamp = as.POSIXct(paste(Date, Time) , format="%d/%m/%Y %H:%M:%S")})

    dt <- data.table(df)
    message("Done!")

    return(dt)
}

dt <- load.data()

message("Generating Plot - plot3.png")

png("plot3.png")
plot(dt$timestamp, dt$Sub_metering_1, col = 'black', type='l', xlab="", ylab="Energy sub metering")
points(dt$timestamp, dt$Sub_metering_2, col="red", type="l")
points(dt$timestamp, dt$Sub_metering_3, col="blue", type="l")
legend("topright", legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c("black","red","blue"), lty=c(1,1))
dev.off()

message("Done!")
