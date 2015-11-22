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

source("./source/defaultdata.R")
source("./source/tools.R")

raw_data <- get_default_data()

Interruption <- "Interruption"
raw_data_inter <- cbind( Interruption, raw_data)

issues <- data.table(raw_data_inter)

shinyServer(function(input, output) {
  
  grouped_issues <- reactive({
    group_issues(input$number_of_issue_grouping, issues)
  })
  
  output$number_of_issue <- renderPlot({
    display_number_of_issues(grouped_issues())
  })

  output$plot <- renderGvis({
    gvisTimeline(
      rowlabel = "Interruption",
      data = raw_data_inter,
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
