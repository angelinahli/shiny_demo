library(shiny)
library(plotly)
library(lubridate)

df <- read.csv("canada_clean.csv")

function(input, output) {
  output$plot <- renderPlotly({
    plt <- plot_ly(
      data=df[
        (df$country == input$country) 
        & (df$year >= input$year[1])
        & (df$year <= input$year[2]),],
      x=~date,
      y=~searches,
      type="scatter",
      mode="lines",
      line=list(color="rgb(23,190,187)")
    )
    plt <- layout(
      plt,
      font=list(family="Arial, sans-serif"),
      title="Searches for 'Moving to Canada'",
      yaxis=list(title="Google Search Volume"),
      xaxis=list(title="Date", autotick=FALSE, dtick=50, tickangle=90)
    )
  })
}
