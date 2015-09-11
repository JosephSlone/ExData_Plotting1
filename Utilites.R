# download.data() Downloads the zip file and unzips it, leaving the
# payload in the root directory of the project.

source_file = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
target_file = 'data.zip'

library(RCurl)
library(data.table)
library(dplyr)

# This is a simple semaphore system.  It can be used to signal a section
# of code that an event has occured. (Such as downloading a file)

# Creates a semaphore, only if it doesn't exist

create.semaphore <- function() {

    if (!file.exists('semaphore.txt')) {
        file_connection <- file('semaphore.txt')
        writeLines(c(""), file_connection)
        close(file_connection) }
}

# Checks to see if the semaphore has been set

is.semaphore <- function() {
    return_val = FALSE
    if (file.exists('semaphore.txt')){
        return_val = TRUE
    }

    return(return_val)
}

# Download and unzip the data file, leaving the payload
# in the root directory of the project.

download.data <- function() {

    # Only download the file if we haven't done it yet.
    #
    # Yes, I know that I could have checked for the existence of
    # the zip file.  This is more flexible.
    #

    if (! is.semaphore()) {
        message("Downloading the zip file")
        bin <- getBinaryURL(source_file, ssl.verifypeer=FALSE)
        con <- file(target_file, open="wb")
        writeBin(bin, con)
        close(con)
        unzip(target_file)
        message("Done!")
        create.semaphore()
    }

}

#
# Load the data into a data table, including only the dates 1/2/2007 and 2/2/2007
# Add a timestamp column to the table.
#

load.data <- function() {

    # Only download the file if we haven't done it yet.
    #
    # Yes, I know that I could have checked for the existence of
    # the zip file.  This is more flexible.
    #

    message("Loading data into datatable")

    # Uses R pipe function and the grep command line program to filter the
    # data to the correct dates.
    #
    # If the grep system command isn't available, then this won't work
    #
    # The standard git installation, or possibly R Tools can provide
    # grep if one using Windows.
    #

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

