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

## Reading mySQL

## Step 1 - Install MySQL
## Step 2 - Install RMySQL
## On a Mac: install.packages("RMySQL")
## On Windows:
## Official instructions - http://biostat.mc.vanderbilt.edu/wiki/Main/RMySQL (may be useful for Mac/UNIX users as well)
## Potentially useful guide - http://www.ahschulz.de/2013/07/23/installing-rmysql-under-windows/

## Connecting and listing databases
ucscDb <- dbConnect(MySQL(),user="genome", host="genome-mysql.cse.ucsc.edu")
result <- dbGetQuery(ucscDb,"show databases;"); 
dbDisconnect(ucscDb);
result

## Connecting to hg19 and listing tables
hg19 <- dbConnect(MySQL(),user="genome", db="hg19", host="genome-mysql.cse.ucsc.edu")
allTables <- dbListTables(hg19)
length(allTables)
allTables[1:5]

## Get dimensions of a specific table
dbListFields(hg19,"affyU133Plus2")
dbGetQuery(hg19, "select count(*) from affyU133Plus2")

## Read from the table
affyData <- dbReadTable(hg19, "affyU133Plus2")
head(affyData)

## Select a specific subset
query <- dbSendQuery(hg19, "select * from affyU133Plus2 where misMatches between 1 and 3")
affyMis <- fetch(query); 
quantile(affyMis$misMatches)
affyMisSmall <- fetch(query,n=10); dbClearResult(query);
dim(affyMisSmall)

## Don't forget to close the connection!
dbDisconnect(hg19)

## Further resources
## RMySQL vignette http://cran.r-project.org/web/packages/RMySQL/RMySQL.pdf
## List of commands http://www.pantz.org/software/mysql/mysqlcommands.html
## Do not, do not, delete, add or join things from ensembl. Only select.
## In general be careful with mysql commands
## A nice blog post summarizing some other commands http://www.r-bloggers.com/mysql-and-r/

## Reading HDF5

## HDF5
## Used for storing large data sets
## Supports storing a range of data types
## Heirarchical data format
## groups containing zero or more data sets and metadata
## Have a group header with group name and list of attributes
## Have a group symbol table with a list of objects in group
## datasets multidmensional array of data elements with metadata
## Have a header with name, datatype, dataspace, and storage layout
## Have a data array with the data
## http://www.hdfgroup.org/

## R HDF5 package
source("http://bioconductor.org/biocLite.R")
biocLite("rhdf5")
library(rhdf5)
created = h5createFile("example.h5")
created

## This will install packages from Bioconductor http://bioconductor.org/, primarily used for genomics but also has good "big data" packages
## Can be used to interface with hdf5 data sets.
## This lecture is modeled very closely on the rhdf5 tutorial that can be found here http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf

## Create groups
created = h5createGroup("example.h5","foo")
created = h5createGroup("example.h5","baa")
created = h5createGroup("example.h5","foo/foobaa")
h5ls("example.h5")

## Write to groups
A = matrix(1:10,nr=5,nc=2)
h5write(A, "example.h5","foo/A")
B = array(seq(0.1,2.0,by=0.1),dim=c(5,2,2))
attr(B, "scale") <- "liter"
h5write(B, "example.h5","foo/foobaa/B")
h5ls("example.h5")

## Write a data set
df = data.frame(1L:5L,seq(0,1,length.out=5), c("ab","cde","fghi","a","s"), stringsAsFactors=FALSE)
h5write(df, "example.h5","df")
h5ls("example.h5")

## Reading data
readA = h5read("example.h5","foo/A")
readB = h5read("example.h5","foo/foobaa/B")
readdf= h5read("example.h5","df")
readA

## Writing and reading chunks
h5write(c(12,13,14),"example.h5","foo/A",index=list(1:3,1))
h5read("example.h5","foo/A")

## Notes and further resources
## hdf5 can be used to optimize reading/writing from disc in R
## The rhdf5 tutorial:
## http://www.bioconductor.org/packages/release/bioc/vignettes/rhdf5/inst/doc/rhdf5.pdf
## The HDF group has informaton on HDF5 in general http://www.hdfgroup.org/HDF5/


## Reading data from the web

## Webscraping
## Webscraping: Programatically extracting data from the HTML code of websites.

## It can be a great way to get data How Netflix reverse engineered Hollywood
## Many websites have information you may want to programaticaly read
## In some cases this is against the terms of service for the website
## Attempting to read too many pages too quickly can get your IP address blocked
## http://en.wikipedia.org/wiki/Web_scraping

## Getting data off webpages - readLines()
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

## Parsing with XML
library(XML)
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
html <- htmlTreeParse(url, useInternalNodes=T)
xpathSApply(html, "//title", xmlValue)
xpathSApply(html, "//td[@id='col-citedby']", xmlValue)

## GET from the httr package
library(httr); 
html2 = GET(url)
content2 = content(html2,as="text")
parsedHtml = htmlParse(content2,asText=TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

## Accessing websites with passwords
pg1 = GET("http://httpbin.org/basic-auth/user/passwd")
pg1

## http://cran.r-project.org/web/packages/httr/httr.pdf

## Accessing websites with passwords
pg2 = GET("http://httpbin.org/basic-auth/user/passwd", authenticate("user","passwd"))
pg2
names(pg2)

## Using handles
google = handle("http://google.com")
pg1 = GET(handle=google,path="/")
pg2 = GET(handle=google,path="search")
## http://cran.r-project.org/web/packages/httr/httr.pdf

## Notes and further resources
## R Bloggers has a number of examples of web scraping http://www.r-bloggers.com/?s=Web+Scraping
## The httr help file has useful examples http://cran.r-project.org/web/packages/httr/httr.pdf
## See later lectures on APIs

## Reading data from APIs

Accessing Twitter from R

myapp = oauth_app("twitter", key="yourConsumerKeyHere", secret="yourConsumerSecretHere")
sig = sign_oauth1.0( myapp, token = "yourTokenHere", token_secret = "yourTokenSecretHere")
homeTL = GET("https://api.twitter.com/1.1/statuses/home_timeline.json", sig)

Converting the json object
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1,1:4]

Reading from other sources
Question 1
Register an application with the Github API here https://github.com/settings/applications. 
Access the API to get information on your instructors repositories (hint: this is the url you want "https://api.github.com/users/jtleek/repos"). 
Use this data to find the time that the datasharing repo was created. 
What time was it created? 
This tutorial may be useful (https://github.com/hadley/httr/blob/master/demo/oauth2-github.r). 
You may also need to run the code in the base R package and not R studio.

Question 2
The sqldf package allows for execution of SQL commands on R data frames. 
We will use the sqldf package to practice the queries we might send with the dbSendQuery command in RMySQL. 
Download the American Community Survey data and load it into an R object called
 acs
https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv 

Which of the following commands will select only the data for the probability weights pwgtp1 with ages less than 50?
sqldf("select pwgtp1 from acs")
sqldf("select * from acs where AGEP < 50 and pwgtp1")
sqldf("select * from acs")
sqldf("select pwgtp1 from acs where AGEP < 50")

Question 3
Using the same data frame you created in the previous problem, what is the equivalent function to unique(acs$AGEP)
sqldf("select distinct AGEP from acs")
sqldf("select AGEP where unique from acs")
sqldf("select unique * from acs")
sqldf("select distinct pwgtp1 from acs")

Question 4
How many characters are in the 10th, 20th, 30th and 100th lines of HTML from this page: 

http://biostat.jhsph.edu/~jleek/contact.html 

(Hint: the nchar() function in R may be helpful)
45 31 7 25
43 99 8 6
45 31 7 31
45 0 2 2
43 99 7 25
45 31 2 25
45 92 7 2

Question 5
Read this data set into R and report the sum of the numbers in the fourth of the nine columns. 

https://d396qusza40orc.cloudfront.net/getdata%2Fwksst8110.for 

Original source of the data: http://www.cpc.ncep.noaa.gov/data/indices/wksst8110.for 

(Hint this is a fixed width file format)
36.5
35824.9
32426.7
28893.3
222243.1
101.83


