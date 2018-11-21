required.pkgs <- c("shiny", "plotly", "lubridate", "doBy", "reshape2")
new.pkgs <- required.pkgs[!(required.pkgs %in% installed.packages()[,"Package"])]
if (length(new.pkgs) != 0) install.packages(new.pkgs)

library(doBy)
library(lubridate)
library(plotly)
library(reshape2)
library(shiny)

# clean data
df <- read.csv("canada.csv")
names(df) <- c("date", "US", "Britain")
df$year <- year(dmy(df$date))
df <- summaryBy(US + Britain ~ year, data=df, FUN=sum, keep.names=TRUE)
df <- melt(df, id=c("year"))
names(df) <- c("year", "country", "immg")

# helper static vars
countries <- sort(unique(df$country))
minyr <- min(df$year)
maxyr <- max(df$year)

# define ui
ui <- fluidPage(
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

server <- function(input, output) {
  output$plot <- renderPlotly({
    plt <- plot_ly(
      data=df[
        (df$country == input$country) 
        & (df$year >= input$year[1])
        & (df$year <= input$year[2]),],
      x=~year,
      y=~immg,
      type="scatter",
      mode="lines"
    )
    plt <- layout(
      plt,
      title="Immigration to Canada",
      yaxis=list(title="Total Immigration"),
      xaxis=list(title="Year")
    )
  })
}

shinyApp(ui=ui, server=server)