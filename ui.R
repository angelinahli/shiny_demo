required.pkgs <- c("shiny", "plotly")
new.pkgs <- required.pkgs[!(required.pkgs %in% installed.packages()[,"Package"])]
if (length(new.pkgs) != 0) install.packages(new.pkgs)

library(shiny)
library(plotly)

df <- read.csv("canada_clean.csv")

# helper static vars
countries <- sort(unique(df$country))
minyr <- min(df$year)
maxyr <- max(df$year)

# define ui
fluidPage(
  titlePanel("Immigration to Canada"),
  
  sidebarLayout(
    
    sidebarPanel(
      selectInput(
        "country", 
        "Country", 
        countries
      ),
      sliderInput(
        "year", 
        "Year", 
        min=minyr, 
        max=maxyr, 
        value=c(minyr, maxyr)
      ),
      hr(),
      helpText("Data from plotly 'Move to Canada' dataset")
    ),
    
    mainPanel(
      plotlyOutput("plot")
    )
    
  )
  
)