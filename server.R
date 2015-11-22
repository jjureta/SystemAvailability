


# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(data.table)
library(ggplot2)
require(googleVis)
library(lubridate)

raw_data <- data.frame(
  ID = c("ID1", "ID2", "ID3", "ID4", "ID5", "ID6", "ID7", "ID8", "ID9",
         "ID10", "ID11", "ID12",
         "ID13", "ID14", "ID15"),
  start = as.POSIXct(
    c(
      "2014-03-14 14:00",
      "2014-03-14 15:00",
      "2014-03-14 14:30",
      "2014-03-15 14:00",
      "2014-03-15 15:00",
      "2014-03-15 14:30",
      "2014-03-16 14:00",
      "2014-03-16 15:00",
      "2014-03-16 14:30",
      "2014-03-17 14:00",
      "2014-03-17 15:00",
      "2014-03-17 14:30",
      "2014-03-18 14:00",
      "2014-03-18 15:00",
      "2014-03-18 14:30"
    )
  ),
  end = as.POSIXct(
    c(
      "2014-03-14 15:00",
      "2014-03-14 16:00",
      "2014-03-14 15:30",
      "2014-03-15 15:00",
      "2014-03-15 16:00",
      "2014-03-15 15:30",
      "2014-03-16 15:00",
      "2014-03-16 16:00",
      "2014-03-16 15:30",
      "2014-03-17 15:00",
      "2014-03-17 16:00",
      "2014-03-17 15:30",
      "2014-03-18 15:00",
      "2014-03-18 16:00",
      "2014-03-18 15:30"
    )
  )
)

Interruption <- "Interruption"
raw_data <- cbind( Interruption, raw_data)

issues <- data.table(raw_data)

shinyServer(function(input, output) {
  
  grouped_issues <- reactive({
    switch(input$number_of_issue_grouping,
           All = issues[, .(DATE = start)],
           Yearly = issues[, .(DATE = floor_date(start, "year"))],
           Monthly = issues[, .(DATE = floor_date(start, "month"))],
           Daily = issues[, .(DATE = floor_date(start, "day"))])
  })
  
  
  output$number_of_issue <- renderPlot({
    ggplot(grouped_issues(), aes(x = factor(DATE))) + 
      geom_bar(colour="black", fill="#DD8888", width=.8, stat = "bin") +
      theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
      ylab("Number of issues") +
      xlab("Date/Time of issue")
  })

  output$plot <- renderGvis({
    gvisTimeline(
      rowlabel = "Interruption",
      data = raw_data,
      barlabel = "ID",
      start = "start", end = "end"
    )
  })
  
  output$table <- renderDataTable({
    raw_data
  }, options = list(
    lengthMenu = c(15, 30, 50), pageLength = 15, orderClasses = TRUE
  ))
  
})
