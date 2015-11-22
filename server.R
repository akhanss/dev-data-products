# Using Google Maps API with R

library(shiny)
library(RCurl)
library(RJSONIO)
library(plyr)

url <- function(address, return.call = "json", sensor = "false") {
  server <- "http://maps.google.com/maps/api/geocode/"
  ui <- paste(server, return.call, "?address=", address, "&sensor=", sensor, sep = "")
  return(URLencode(ui))
}

geoCode <- function(address, verbose = FALSE) {
  if(verbose) cat(address,"\n")
  ui <- url(address)
  doc <- getURL(ui)
  x <- fromJSON(doc, simplify = FALSE)
  if(x$status == "OK") {
    lat <- x$results[[1]]$geometry$location$lat
    lng <- x$results[[1]]$geometry$location$lng
    location_type  <- x$results[[1]]$geometry$location_type
    formatted_address  <- x$results[[1]]$formatted_address
    return(c(lat, lng, location_type, formatted_address))
    Sys.sleep(0.5)
  } else {
    return(c(NA, NA, NA, NA))
  }
}

shinyServer(
  function(input, output) {
    observe({
      input$goButton
      isolate({
        address <- input$address
        addresses <- strsplit(input$addressArea, "\n")
        addresses <- unlist(addresses)
        locations <- ldply(addresses, function(x) geoCode(x))
        locations <- cbind(addresses,locations)
        names(locations) <- c("Address Entered", "Latitude", "Longtitude", "Location Type", "Mapped Address")
        output$locations <- renderTable({locations})
        output$downloadData <- downloadHandler(
          filename = function() {
            paste('data-', Sys.Date(), '.csv', sep='')
          },
          content = function(file) {
            write.csv(locations, file)
          }
        )
      })
      
    })
  }
)