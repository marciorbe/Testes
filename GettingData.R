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
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx",sheetIndex=1,
                              colIndex=colIndex,rowIndex=rowIndex)
cameraDataSubset

## Reading XML files
##Read the file into R
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
## Directly access parts of the XML document
rootNode[[1]]
rootNode[[1]][[1]]
## Programatically extract parts of the file
xmlSApply(rootNode,xmlValue)
## Programatically extract parts of the file
xmlSApply(rootNode,xmlValue)
## Get the items on the menu and prices
xpathSApply(rootNode,"//name",xmlValue)
xpathSApply(rootNode,"//price",xmlValue)
## Extract content by attributes
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl,useInternal=TRUE)
scores <- xpathSApply(doc,"//li[@class='score']",xmlValue)
teams <- xpathSApply(doc,"//li[@class='team-name']",xmlValue)
scores
teams

## Reading JSON
### Reading data from JSON {jsonlite package}
library(jsonlite)
jsonData <- fromJSON("https://api.github.com/users/jtleek/repos")
names(jsonData)
### Nested objects in JSON
names(jsonData$owner)
jsonData$owner$login
### Writing data frames to JSON
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)
### Convert back to JSON
iris2 <- fromJSON(myjson)
head(iris2)

## Using data.table
### Create data tables just like data frames
library(data.table)
DF = data.frame(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DF,3)
DT = data.table(x=rnorm(9),y=rep(c("a","b","c"),each=3),z=rnorm(9))
head(DT,3)
### See all the data tables in memory
tables()
### Subsetting rows
DT[2,]
DT[DT$y=="a",]



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
sum(data[["VAL"]]==24,na.rm=TRUE)
## 03
destfile <- "./data/ngap.xlsx" 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file( fileUrl, destfile = destfile, method = "curl" )
data <- read.xlsx(destfile,sheetIndex=1,header=TRUE)
## 04
destfile <- "./data/restaurants.xml" 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file( fileUrl, destfile = destfile, method = "curl" )

