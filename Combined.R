library(readr)

scorecard <- readRDS("../cleaned_scorecard.rds")

names(scorecard)[names(scorecard) == "UNITID"] <- "UnitID"


  
scorecard %>% summarize_all(funs(1 - sum(is.na(.))/length(.))) %>% 
transpose() -> percent
max(percent[percent!=1])
min(percent$V1)
median(percent$V1)
mean(percent$V1)

length(percent[percent$V1>0.3,])
      
scorecard2 <- scorecard[,which(colMeans(!is.na(scorecard))>0.3)]

combined <- merge(ipeds2, scorecard2, by = c("UnitID", "year"))

combined[is.na(combined)] <- 999