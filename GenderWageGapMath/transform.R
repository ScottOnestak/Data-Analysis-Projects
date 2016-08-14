# Install the released version from CRAN:
install.packages("haven")

# Install the cutting edge development version from GitHub:
# install.packages("devtools")
devtools::install_github("hadley/haven")

library(haven)

#read in file
theData <- read_dta('C:/Users/scott/Desktop/ICPSR6379.dta')

#write to a CSV file
write.csv(theData, 'C:/Users/scott/Desktop/stataFile.csv')

#bring the newly updated dataset back in
theData2 <- read.csv('C:/Users/scott/Desktop/data.csv', header=TRUE, sep=",")
theData2 <- read.csv('C:/Users/scott/Desktop/Results.dta', header=TRUE, sep=",")

write_dta(theData2, 'C:/Users/scott/Desktop/theData.dta')
