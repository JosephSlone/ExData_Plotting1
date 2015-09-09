# This function downloads a binary source file from a URL to the
# current directory and leaves it in the target file.
#
# Cheating... Change method='wininet' to either wget or curl if
# you are on a linux box.

source_file = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
target_file = 'data.zip'

library(RCurl)
library(data.table)
library(dplyr)

# Creates a semaphore, only if it doesn't exist

create_semaphore <- function() {

    if (!file.exists('semaphore.txt')) {
        file_connection <- file('semaphore.txt')
        writeLines(c(""), file_connection)
        close(file_connection) }
}

# Checks to see if the semaphore has been set

is_semaphore <- function() {
    return_val = FALSE
    if (file.exists('semaphore.txt')){
        return_val = TRUE
    }

    return(return_val)
}

# This function unzips the file and loads the data into a data.table

load.data <- function() {

    # Only download the file if we haven't done it yet.
    #
    # Yes, I know that I could have checked for the existence of
    # the zip file.  This is more flexible.
    #

    if (! is_semaphore()) {
    	download.file(url=source_file, method='wininet', destfile=target_file)
        unzip(target_file)
        create_semaphore()
    }

    message("Loading data into datatable")

    # Uses R pipe function and the grep command line program to filter the
    # data to the correct dates.

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

