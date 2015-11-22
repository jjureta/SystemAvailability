library(data.table)
library(ggplot2)
library(lubridate)

## Group issues by given time span.
## grouping_type: enum value
## issues: issues data table
group_issues <- function(grouping_type, issues) {
  switch(grouping_type,
         All = issues[, .(DATE = start)],
         Yearly = issues[, .(DATE = floor_date(start, "year"))],
         Monthly = issues[, .(DATE = floor_date(start, "month"))],
         Daily = issues[, .(DATE = floor_date(start, "day"))])  
}

## Plot the bar of issues data table where x axis is done by DATA variable.
## issues: issue data set
display_number_of_issues <- function(issues) {
  ggplot(issues, aes(x = factor(DATE))) + 
    geom_bar(colour="black", fill="#DD8888", width=.8, stat = "bin") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
    ylab("Number of issues") +
    xlab("Date/Time of issue")
}