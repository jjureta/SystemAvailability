# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(markdown)

plotLayout <- fluidRow(column(
  12,
  h3("Individual issues:"),
  htmlOutput('plotIssues'),
  h3("Aggregated interval of issues:"),
  htmlOutput('plotAggregatedIssues'))
)

summaryLayout <- fluidRow(column(
  4,
  selectInput(
    'number_of_issue_grouping', 'Number of issues:',
    c("All", "Yearly", "Monthly", "Daily")
  ),
  br(),
  plotOutput("number_of_issue")
))

dataLayout <- fluidRow(column(
  12,
  fileInput('uploadData', 'Upload CSV File',
            accept=c('text/csv', 
                     'text/comma-separated-values,text/plain', 
                     '.csv')),
  downloadButton('downloadData', 'Download'),
  br(),
  br(),
  dataTableOutput('table')
))

shinyUI(fluidPage(
  shinyUI(
    navbarPage(
      "System Availability",
      tabPanel("Plot", plotLayout),
      tabPanel("Summary", summaryLayout),
      tabPanel(
        "Data", dataLayout),
      tabPanel("Help", includeMarkdown("./help/SystemAvailabilityPresentation.md"))
    )
  )))
