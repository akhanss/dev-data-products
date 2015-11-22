---
title       : Developing Data Products for Coursera
subtitle    : Google Map Geocode Query Tool
author      : Mohammad Azam Khan
job         : Student, Cousera MOOC
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Background

The Google Maps Geocode Query Tool aims to simplify the collection of geocodes by providing a simple interface for users to query latitude and longtitude coordinates. The tool makes use of the Google Maps API service for latidue and longtitude coordnate information and the Shiny Package for User Interface creation.

--- .class #id 

## Features
1. Users do not need to know Google Maps API and R.
2. Latitude and Longtitude coordinates can be viewed and downloaded as CSV file.<br>
3. It's completely free! (Courtesy of Google Maps API)

## Limitation
Currently, the application is only supporting a maximum of 10 addresses can be queried at one time due to limits set for the free version of Google Maps API

---

## How it works!
The main function that queries Google Maps API for latitude and longtitude information is the <code>geoCode</code> function. This function takes in the search criteria and returns the latitude, longtitude, type of location and address identified.

---
## References
This development procedure and code can be found in the following link:
* https://github.com/akhanss/dev-data-products



