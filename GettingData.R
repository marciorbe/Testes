## Create directorie
if (!file.exists("data")){
  dir.create("data")
}

destfile <- "./data/cameras.csv"

## Downloading file
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file( fileUrl, destfile = destfile, method = "curl" )
list.files("./data")

## Reading local flat files
dateDownloaded <- date()
cameraData <- read.table(destfile)  ## Error
head(cameraData)                    ## Error
##
cameraData <- read.table(destfile,sep=",",header=TRUE)
head(cameraData)
##
cameraData <- read.csv(destfile)
head(cameraData)

## Reading Excel files
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl,destfile="./data/cameras.xlsx",method="curl")
dateDownloaded <- date()
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,header=TRUE)
head(cameraData)

## Quiz 1
if (!file.exists("data")){
  dir.create("data")
}
destfile <- "./data/data.csv"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file( fileUrl, destfile = destfile, method = "curl" )
data <- read.table(destfile,sep=",",header=TRUE)
head(data)
## 01 - How many properties are worth $1,000,000 or more?



