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

Interruption <- "Interruption"

shinyServer(function(input, output) {
  
  dataInput <- reactive({
    inFile <- input$uploadData
    if (is.null(inFile))
      raw_data <- get_default_data()
    else
      raw_data <- read.csv(inFile$datapath)
    
    raw_data[, c("start")] <- as.POSIXct(raw_data[,c("start")])
    raw_data[, c("end")] <- as.POSIXct(raw_data[,c("end")])
    
    raw_data
  })
  
  output$table <- renderDataTable({
    dataInput()
  }, options = list(
    lengthMenu = c(15, 30, 50), pageLength = 15, orderClasses = TRUE
  ))
  
  grouped_issues <- reactive({
    group_issues(input$number_of_issue_grouping, data.table(dataInput()))
  })
  
  output$number_of_issue <- renderPlot({
    display_number_of_issues(grouped_issues())
  })

  output$plot <- renderGvis({
    raw_data_inter <- cbind(Interruption, dataInput())
    
    gvisTimeline(
      rowlabel = "Interruption",
      data = raw_data_inter,
      barlabel = "ID",
      start = "start", end = "end"
    )
  })
  
  # downloadHandler() takes two arguments, both functions.
  # The content function is passed a filename as an argument, and
  #   it should write out data to that filename.
  output$downloadData <- downloadHandler(
    
    # This function returns a string which tells the client
    # browser what name to use when saving the file.
    filename = function() {
      paste("issues", "csv", sep = ".")
    },
    
    # This function should write data to a file given to it by
    # the argument 'file'.
    content = function(file) {
      # Write to a file specified by the 'file' argument
      write.csv(dataInput(), file, sep = ",",
                  row.names = TRUE)
    }
  )
  
})
