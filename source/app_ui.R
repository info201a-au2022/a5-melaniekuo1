library("shiny")
library("plotly")
library("ggplot2")


co2_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

intro_main_content <- mainPanel(h1("Calculating Per Capita Carbon Dioxide Emissions"),
                                h2("Introduction"),
                                p("Carbon dioxide emissions have been a key topic of importance, especially in the analysis of worldwide climate change. I specifically wanted to analyze per capita carbon dioxide emissions over time, as the emissions per country otherwise are skewed due to the factor of population. By using data from Our World in Data’s “Data on Co2 and Greenhouse Gas Emissions'' dataset, I was able to determine a few key findings, shown in the following section."),
                                h3("Key Findings"),
                                p("From this analysis, one can determine that the average per capita carbon dioxide emissions in the United States is", avg_us_co2_data, "tons per year, while", usa_co2_data, "was the year with the highest per capita carbon dioxide emissions in the United States. Lastly,", max_co2_data, "was the country with the highest overall per capita carbon dioxide emissions in 2021."),
                                h3("Sources of Data"),
                                p("https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions"))

intro_tab_panel <- tabPanel("Introduction", intro_main_content)

co2_sidebar <- sidebarPanel(h3("Control Options"), radioButtons("display_choices", 
                            label = "Choose a plot type to display:", 
                            choices = list("Bar Plot" = 1, "Line Plot" = 2), selected = 1),
                            selectInput("country", label = "Choose a country:",
                            choices = filtered_co2_per_capita$country))

co2_main_content <- mainPanel(plotlyOutput("display_plot"),
                              p("This bar plot and line plot show the growth in per capita carbon dioxide emissions over across each country. From this visualization, it can be understood which countries have experienced the most significant growth in per capita carbon dioxide emissions over time."),
                              p(strong("Note: "), "Per capita carbon dioxide emissions are expressed in tons."))

co2_tab_panel <- tabPanel("Co2 Emissions", co2_main_content, co2_sidebar)

ui <- navbarPage("Calculating Per Capita Carbon Dioxide Emissions",
                 intro_tab_panel, co2_tab_panel)

