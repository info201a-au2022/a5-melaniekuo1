library("dplyr")
library("ggplot2")
library("plotly")


co2_df <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# filtering DF
filtered_co2_per_capita <- co2_df %>% 
  select(country, year, co2_per_capita)

# calculate average co2 per capita in the United States
avg_us_co2_data <- co2_df %>% 
  filter(country == "United States") %>% 
  summarise(mean_co2 = mean(co2_per_capita, na.rm = TRUE)) %>% 
  pull(mean_co2)

# DYNAMIC PARAGRAPH VALUES
# calculate highest year of co2 per capita in the United States
usa_co2_data <- co2_df %>% 
  filter(country == "United States") %>% 
  filter(co2_per_capita == max(co2_per_capita)) %>% 
  pull(year)

# calculate country with highest co2 per capita in 2021
max_co2_data <- co2_df %>% 
  filter(year == 2021) %>% 
  filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>% 
  pull(country)

# PLOTS
my_server <- function(input, output) {
    output$display_plot <- renderPlotly({
      if (input$display_choices == 2) {
      filtered_co2_per_capita <- filtered_co2_per_capita %>% 
        filter(country %in% input$country, na.rm = TRUE) %>% 
        group_by(country)
      co2_us <- ggplot(filtered_co2_per_capita, aes(x = year, y = co2_per_capita)) +
        geom_line() +
        geom_point() +
        ggtitle("Co2 Per Capita Emissions Per Year: Line Plot") +
        xlab("Year") + ylab("Per Capita Carbon Dioxide Emissions (Tons)")
      co2_us
  } 
   else if (input$display_choices == 1) {
      filtered_co2_per_capita <- filtered_co2_per_capita %>% 
        filter(country %in% input$country, na.rm = TRUE) %>% 
        group_by(country)
      co2_bar <- ggplot(filtered_co2_per_capita, aes(x = year, y = co2_per_capita)) +
        geom_col() +
        ggtitle("Co2 Per Capita Emissions Per Year: Bar Plot") +
        xlab("Year") + ylab("Per Capita Carbon Dioxide Emissions (Tons)")
      co2_bar
   }
    })
}


