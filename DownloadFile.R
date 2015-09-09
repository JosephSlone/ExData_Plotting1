# This function downloads a binary source file from a URL to the
# current directory and leaves it in the target file.
#
# Cheating... Change method='wininet' to either wget or curl if
# you are on a linux box.

source = 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
target = 'data.zip'

library(RCurl)
library(data.table)
library(dplyr)

download.data <- function(source, target){
    message("Downloading File")
    download.file(url=source, method='wininet', destfile=target)
    message("Finished")
}

# This function unzips the file and loads the data into a data.table


load.data <- function() {

	# Commented out for speed.
	# download.data(source, target)
	# unzip(target)

    message("Loading data into datatable")
	df <- read.csv("household_power_consumption.txt",
	                sep=";", na.strings="?",
                    colClasses=c('character','character', 'numeric', 'numeric', 'numeric', 'numeric', 'numeric','numeric','numeric')
	               )
	df <- within(df, { timestamp = as.POSIXct(paste(Date, Time) , format="%d/%m/%Y %H:%M:%S")})


	dt <- data.table(df)
    message("Done!")
    return(filter(dt, month(dt$timestamp) == 2, year(dt$timestamp) == 2007, mday(dt$timestamp) <= 2))
}

message("Run the command dt <- load.data() to download the data from")
message("the server and load it into the data.table 'dt'")