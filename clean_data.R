library(doBy)
library(lubridate)
library(reshape2)

# clean data
df <- read.csv("canada.csv")
names(df) <- c("date", "US", "Britain")
df$year <- year(dmy(df$date))
df <- summaryBy(US + Britain ~ year, data=df, FUN=sum, keep.names=TRUE)
df <- melt(df, id=c("year"))
names(df) <- c("year", "country", "immg")
write.csv(df, file="canada_clean.csv")