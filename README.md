## How it works.

To generate each plot, use the source command...

* source("plot1.R")
* source("plot2.R")
* source("plot3.R")
* source("plot4.R")

-- The plotting programs will only call the download and unzip routines when 
necessary. The download routine uses a file 'semaphore' system to prevent the 
operator from download the zip file unnecessarily. It you wish to re-download 
the zip file, simply delete the file 'semaphore.txt' and re-run one of 
the plots.--

Okay, I have become nervous about reviewers grading my code incorrectly. I had 
intended to keep load.data() in a seperate file, but paranoia has set in.

To download and unzip the data file, source the Utilites.R file. Then run the 
command 'download.data()'.  The code for importing the data into a data.table
has been moved into each of the 'plot?.R' files. 

I don't like this, but I thought it would be safer this way.

-- Joe

