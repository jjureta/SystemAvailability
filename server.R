


# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
require(googleVis)

dat <- data.frame(
  Interruption = c("Interruption"),
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

shinyServer(function(input, output) {
  # a large table, reative to input$show_vars
  output$plot <- renderGvis({
    gvisTimeline(
      data = dat,
      barlabel = "ID",
      start = "start", end = "end"
    )
  })
  
  # sorted columns are colored now because CSS are attached to them
  output$summary <- renderDataTable({
    mtcars
  }, options = list(orderClasses = TRUE))
  
  output$table <- renderDataTable({
    dat
  }, options = list(
    lengthMenu = c(5, 30, 50), pageLength = 15, orderClasses = TRUE
  ))
  
})
