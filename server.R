library(shiny)
library(plotly)

df <- read.csv("canada_clean.csv")

function(input, output) {
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