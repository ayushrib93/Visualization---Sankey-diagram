
library(data.table)
setwd('C:/Users/Ayushri Bhargava/Desktop/GRA/legal_sprint/Visualization')


pathDta <- data.table(read.csv('Final data for paths.csv', colClasses = 'character'))


numStages <- ncol(pathDta)
maxSteps <- 10
records <- data.table()

for(i in 1:nrow(pathDta)){
  auxVector <- pathDta[i,]
  for(j in 1:(maxSteps - 1)){
    if((j+1) %in% (as.vector(t(auxVector)))){
    fromAux <- grep(pattern = j, x = as.vector(t(auxVector)))
    toAux   <- grep(pattern = j+1,
                    x = as.vector(t(auxVector)))
    auxRecord <- data.frame(caseN = i,
                           stageFrom = names(pathDta)[fromAux],
                           stageTo = names(pathDta)[toAux],
                           stepFrom = j,
                           stepTo = j+1,
                           ones = 1)
    records <- rbind(records, auxRecord)
    }
  }
  
}

caseFlow <- records[, sum(ones),
                    by = list(stageFrom, stageTo, stepFrom, stepTo)]

write.csv(caseFlow, 'caseFlow.csv')
