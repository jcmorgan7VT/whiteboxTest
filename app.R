#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    https://shiny.posit.co/
#

library(shiny)
library(shiny)
library(whitebox)
library(terra)
ui <- fluidPage(
  
  titlePanel(paste("WhiteboxTools-Shiny Test", getwd())),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("threshold", "Threshold:", min = 1, max = 40, value = 8),
      checkboxInput("compress", "Compress Rasters?")
    ),
    mainPanel(
      plotOutput("slopePlot")
    )
  )
)
server <- function(input, output) {
  # setwd("~")
  # wbt_wd("")
  output$slopePlot <- renderPlot({
    # generate threshold slope map based on input$threshold from ui.R
    x <- wbt_slope(sample_dem_data(destfile = "~/input.tif"), "~/output.tif")
    # , compress_rasters = input$compress)
    terra::plot(terra::rast("~/output.tif") > input$threshold)
    unlink("~/output.tif")
  })
}
shinyApp(ui = ui, server = server)