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
### Subsetting rows
DT[c(2,3)]
### Subsetting columns!?
DT[,c(2,3)] ## will not work!
### Column subsetting in data.table
#### The subsetting function is modified for data.table
#### The argument you pass after the comma is called an "expression"
#### In R an expression is a collection of statements enclosed in curley brackets
{
  x = 1
  y = 2
}
k = {print(10); 5}
## [1] 10
print(k)
## [1] 5
## Calculating values for variables with expressions
DT[,list(mean(x),sum(z))]
DT[,table(y)]
### Adding new columns
DT[,w:=z^2]
DT2 <- DT
DT[, y:= 2]
### Careful
head(DT,n=3)
head(DT2,n=3)
### Multiple operations
DT[,m:= {tmp <- (x+z); log2(tmp+5)}]
### plyr like operations
DT[,a:=x>0]
DT[,b:= mean(x+w),by=a]
### Special variables
#### .N An integer, length 1, containing the numbe r
set.seed(123);
DT <- data.table(x=sample(letters[1:3], 1E5, TRUE))
DT[, .N, by=x]
### Keys
DT <- data.table(x=rep(c("a","b","c"),each=100), y=rnorm(300))
setkey(DT, x)
DT['a']
### Joins
DT1 <- data.table(x=c('a', 'a', 'b', 'dt1'), y=1:4)
DT2 <- data.table(x=c('a', 'b', 'dt2'), z=5:7)
setkey(DT1, x); setkey(DT2, x)
merge(DT1, DT2)
### Fast reading
big_df <- data.frame(x=rnorm(1E6), y=rnorm(1E6))
file <- tempfile()
write.table(big_df, file=file, row.names=FALSE, col.names=TRUE, sep="\t", quote=FALSE)
system.time(fread(file))
system.time(read.table(file, header=TRUE, sep="\t"))



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
colIndex <- 7:15
rowIndex <- 18:23
dat <- read.xlsx(destfile,sheetIndex=1,colIndex=colIndex,rowIndex=rowIndex)
sum(dat$Zip*dat$Ext,na.rm=T) 
## 04
destfile <- "./data/restaurants.xml" 
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file( fileUrl, destfile = destfile, method = "curl" )
doc <- xmlTreeParse(fileUrl,useInternal=TRUE)
doc <- xmlTreeParse(destfile,useInternal=TRUE)
## 05
require(data.table)
dt <- fread(".data/micro.csv")

system.time({mean(DT[DT$SEX==1,]$pwgtp15); mean(DT[DT$SEX==2,]$pwgtp15)})
system.time(tapply(DT$pwgtp15,DT$SEX,mean))
system.time(mean(DT$pwgtp15,by=DT$SEX))
system.time(DT[,mean(pwgtp15),by=SEX])
system.time({rowMeans(DT)[DT$SEX==1]; rowMeans(DT)[DT$SEX==2]})
system.time(sapply(split(DT$pwgtp15,DT$SEX),mean))

