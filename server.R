
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(ggplot2)
require(googleVis)

dat <- data.frame(Room=c("Room 1","Room 2","Room 3"),
                  Language=c("English", "German", "French"),
                  start=as.POSIXct(c("2014-03-14 14:00", 
                                     "2014-03-14 15:00",
                                     "2014-03-14 14:30")),
                  end=as.POSIXct(c("2014-03-14 15:00", 
                                   "2014-03-14 16:00",
                                   "2014-03-14 15:30")))

shinyServer(function(input, output) {
  
  # a large table, reative to input$show_vars
  output$plot <- renderGvis({
    gvisTimeline(data = dat, 
                 rowlabel = "Room", barlabel = "Language", 
                 start = "start", end = "end")
  })
  
  # sorted columns are colored now because CSS are attached to them
  output$summary <- renderDataTable({
    mtcars
  }, options = list(orderClasses = TRUE))
  
  # customize the length drop-down menu; display 5 rows per page by default
  output$table <- renderDataTable({
    diamonds
  }, options = list(lengthMenu = c(5, 30, 50), pageLength = 15))
  
})
