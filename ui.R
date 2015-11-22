
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

summaryLayout <- fluidRow(
  column(4,
         selectInput('number_of_issue_grouping', 'Number of issues:',
                     c("All", "Yearly", "Monthly", "Daily")),
         br(),
         plotOutput("number_of_issue")
  )
)

shinyUI(fluidPage(
  
  shinyUI(navbarPage("System Availability",
                     tabPanel("Plot", htmlOutput('plot')),
                     tabPanel("Summary", summaryLayout),
                     tabPanel("Table", dataTableOutput('table'))
  ))
))
