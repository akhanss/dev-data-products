library(shiny)
shinyUI(fluidPage(
  fluidRow(
    headerPanel("Developing Data Products Coursera Project"),
    titlePanel('Google Maps Geocode Query Tool'),
    helpText("Enter the addresses in the input box. A maximum of 10 addresses and one address per line can be entered."),
    helpText("You can then view and/or download the results in the Output section below."),
    helpText("An example has been pre-populated in the app."),
    h3('Input'),
    helpText("Note: Put only one address per line. A maximum of 10 addresses i.e. 10 lines can be queried at one time."),
    HTML('<textarea id="addressArea" rows="10" cols="50">Kolkata, India</textarea>'),
    br(),
    actionButton("goButton", "Go!"),
    hr()
  ),
  fluidRow(
    h3('Output'),
    h4('Locations identified'),
    tableOutput("locations"),
    helpText("You can save the above output as a CSV file by clicking on the Download button below."),
    downloadButton('downloadData', 'Download')
  )
))