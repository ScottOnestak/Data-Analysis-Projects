#Set the working directory and import the appropriate data files
setwd('C:/Users/scott/Desktop')
theData <- read.csv("C:/users/scott/desktop/IowaNHDataCSV.csv", header=TRUE, sep=",")
theData2 <- read.csv("C:/users/scott/desktop/RepubIANH.csv", header=TRUE, sep=",")
theData3 <- read.csv("C:/users/scott/desktop/DemIANH.csv", header=TRUE, sep=",")

#Republican and Democrat datapoints
regLine1 <- lm(theData$NHAct ~ theData$IowaPredicted + theData$IowaActual + theData$NHPred + theData$NationalNH + theData$NatDiff)
summary(regLine1)
regLine2 <- lm(theData$NHAct ~ theData$IowaDiff + theData$NHPred)
summary(regLine2)
regLine3 <- lm(theData$NHAct ~ theData$NHPred + theData$NationalNH)
summary(regLine3)

#Just Republican datapoints
regLine4 <- lm(theData2$NHAct ~ theData2$IowaPredicted + theData2$IowaActual + theData2$NHPred + theData2$NationalNH + theData2$NatDiff)
summary(regLine4)
regLine5 <- lm(theData2$NHAct ~ theData2$IowaDiff + theData2$NHPred)
summary(regLine5)
regLine6 <- lm(theData2$NHAct ~ theData2$NHPred + theData2$NationalNH)
summary(regLine6)

#Just Democrat datapoints
regLine7 <- lm(theData3$NHAct ~ theData3$IowaPredicted + theData3$IowaActual + theData3$NHPred + theData3$NationalNH + theData3$NatDiff)
summary(regLine7)
regLine8 <- lm(theData3$NHAct ~ theData3$IowaDiff + theData3$NHPred)
summary(regLine8)
regLine9 <- lm(theData3$NHAct ~ theData3$NHPred + theData3$NationalNH)
summary(regLine9)
regLine10 <- lm(theData3$NHAct ~ theData3$NHPred + theData3$NatDiff)
summary(regLine10)
