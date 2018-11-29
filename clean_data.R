library(lubridate)
library(reshape2)
library(plotly)

# clean data
df <- read.csv("canada.csv")
names(df) <- c("date", "US", "Britain")
df$date <- dmy(df$date)
df <- melt(df, id=c("date"))
names(df) <- c("date", "country", "searches")
df$year <- year(df$date)
write.csv(df, file="canada_clean.csv")
