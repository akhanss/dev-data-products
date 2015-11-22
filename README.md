## Developing Pata Products Coursera Project

# Using Google Maps API with R

This script uses RCurl and RJSONIO to download data from Google's API to get the latitude, longitude, location type, and formatted address


```{r echo = TRUE}
library(RCurl)
library(RJSONIO)
library(plyr)
```

Build a URL to access the API:

```{r echo = TRUE}
url <- function(address, return.call = "json", sensor = "false") {
  server <- "http://maps.google.com/maps/api/geocode/"
  ui <- paste(server, return.call, "?address=", address, "&sensor=", sensor, sep = "")
  return(URLencode(ui))
}

```

Function to parse the results:
```{r echo = TRUE}
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
```
Test with one address
```{r echo = TRUE}
address <- geoCode("Kolkata, India")
```
First two items are the latitude and longitude coordinates, then the location type and 
formatted address
```{r echo = TRUE}
address
```
We can use Plyr to geocode a vector with addresses
```{r echo = TRUE}
address <- c("Kolkata, India", "Kolkata, West Bengal, India")
locations  <- ldply(address, function(x) geoCode(x))
names(locations)  <- c("lat", "lon", "location_type", "formatted")
head(locations)
```
The following are the different location types:
* "ROOFTOP" indicates that the returned result is a precise geocode for which we have location information accurate down to street address precision.
* RANGE_INTERPOLATED" indicates that the returned result reflects an approximation (usually on a road) interpolated between two precise points (such as intersections). Interpolated results are generally returned when rooftop geocodes are unavailable for a street address.
* GEOMETRIC_CENTER" indicates that the returned result is the geometric center of a result such as a polyline (for example, a street) or polygon (region).
* APPROXIMATE" indicates that the returned result is approximate.

For more info on Google Maps API, please check [here](https://developers.google.com/maps/documentation/directions/)
