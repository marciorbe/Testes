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
