library("shiny")
library("plotly")
library("ggplot2")

co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

intro_main_content <- mainPanel(h1("Calculating Per Capita Carbon Dioxide Emissions | Introduction"),
                                p("Text here to come!"))

intro_tab_panel <- tabPanel("Introduction", intro_main_content)

# select_oil <- radioButtons("radio", label = "Choose a plot to display: ", 
                           #choices = c("Co2 Emissions Per Capita", 
                                      #      "Oil Co2 Emissions Per Capita"),
                          # selected = "lineplot")

co2_sidebar <- sidebarPanel(h3("Control Options"), checkboxGroupInput("checkboxes", 
                            label = "Choose which plot(s) to display", 
                            choices = list("Line Plot" = 1, "Bar Plot" = 2), selected = 1),
                            selectInput("country", label = "Choose a Country:",
                            choices = filtered_co2_per_capita$country, 
                            selected = "United States", multiple = FALSE))

co2_main_content <- mainPanel(plotlyOutput("lineplot"), plotlyOutput("barplot"))

co2_tab_panel <- tabPanel("Co2 Emissions", co2_main_content, co2_sidebar)

ui <- navbarPage("Calculating Per Capita Carbon Dioxide Emissions",
                 intro_tab_panel, co2_tab_panel)

