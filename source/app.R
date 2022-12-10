library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
source("./app_server.R")
source("./app_ui.R")

# Run the application 
shinyApp(ui = ui, server = my_server)
