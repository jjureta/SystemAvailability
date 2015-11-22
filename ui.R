
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("System Availability Analysis"),
  
  shinyUI(navbarPage("System Availability",
                     tabPanel("Plot", htmlOutput('plot')),
                     tabPanel("Summary", dataTableOutput('summary')),
                     tabPanel("Table", dataTableOutput('table'))
  ))
))
