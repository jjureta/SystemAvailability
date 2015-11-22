data(Stock)
Stock

dat <- data.frame(
  Interruption = c("Interruption"),
  ID = c("ID1", "ID2", "ID3", "ID4", "ID5", "ID6"),
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
      "2014-03-16 14:30"
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
      "2014-03-16 15:30"
    )
  )
)

A1 <- gvisAnnotatedTimeLine(Stock, datevar="Date",
                            numvar="Value", idvar="Device",
                            titlevar="Title", annotationvar="Annotation",
                            options=list(displayAnnotations=TRUE,
                                         legendPosition='newRow',
                                         width="600px", height="350px")
)
plot(A1)