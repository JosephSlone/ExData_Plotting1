## How it works.

To generate each plot, use the source command...

* source("plot1.R")
* source("plot2.R")
* source("plot3.R")
* source("plot4.R")

The plotting programs will only call the download and unzip routines when 
necessary. The download routine uses a file 'semaphore' system to prevent the operator from download the zip file unnecessarily. It you wish to re-download the zip file, simply delete the file 'semaphore.txt' and re-run one of the plots.

-- Joe

