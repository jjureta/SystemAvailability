library(data.table)
library(ggplot2)
require(googleVis)
library(lubridate)

## Get an example of the issue data set
raw_data <- data.frame(
  #Interruption = c("Interruption"),
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

setkey(issues, start, end)

ans = foverlaps(issues, issues, type="any")
ans = ans[, `:=`(start = pmin(start, i.start), end = pmax(end, i.end))]
ans = ans[, `:=`(i.start=NULL, i.end=NULL)][start <= end]
ans = ans[ID != i.ID]
ans = ans[start != end]

ans = ans[, .(start = min(start), end = max(end)) , by = .(ID)]
ans = unique(ans, by = c("start", "end"))
ans = ans[,ID := NULL]

#b = merge(ans, issues, by.x="i.ID", by.y="ID")

#b[start.y < start.x, ID := i.ID]

#ans[, ID = i.ID)]

