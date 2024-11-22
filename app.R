library(shiny)
library(ggplot2)
library(dplyr)
library(DT)

# Load the dataset
drug_spending <- read.csv("data/data.csv")

drug_spending$TIME <- as.numeric(drug_spending$TIME)
drug_spending <- drug_spending[!is.na(drug_spending$TIME), ]

# UI
ui <- fluidPage(
  #Feature 1:Background image to make it visually appealing.
  includeCSS("www/background.css"),
  
  titlePanel("Pharmaceutical Drug Spending by Countries"),
  
  sidebarLayout(
    sidebarPanel(
      # Feature 2: Dynamic filtering by user-selected inputs. This allows users to dynamically filter the dataset by country, year range, and spending metric; based on their preferences
      selectInput("country", "Select Country:", choices = unique(drug_spending$LOCATION), multiple = TRUE, selected = "AUS"),
      sliderInput("year", "Select Year Range:", 
                  min = min(drug_spending$TIME, na.rm = TRUE), 
                  max = max(drug_spending$TIME, na.rm = TRUE), 
                  value = c(min(drug_spending$TIME, na.rm = TRUE), max(drug_spending$TIME, na.rm = TRUE))),
      selectInput("metric", "Select Metric to Plot:", 
                  choices = c("Percentage of Health Expenditure" = "PC_HEALTHXP",
                              "Percentage of GDP" = "PC_GDP",
                              "Per Capita Spending (USD)" = "USD_CAP",
                              "Total Spending" = "TOTAL_SPEND"))
    ),
    mainPanel(
      tabsetPanel(
        # Feature 3: Interactive plot. 
        tabPanel("Plot", plotOutput("spending_plot")),
        # Feature 4 & 5: Data table and download
        tabPanel("Table", DTOutput("data_table")),
        tabPanel("Download", downloadButton("download_data", "Download Filtered Data")),
        tabPanel("About", 
                 h4("About This App"),
                 p("This Shiny app visualizes pharmaceutical drug spending trends across different countries."),
                 p("You can filter data by country and year range, explore various spending metrics, and download the filtered data."),
                 p(
                   "Data Source: ",
                   tags$a(href = "https://datahub.io/core/pharmaceutical-drug-spending", 
                          "Pharmaceutical Drug Spending from Organisation for Economic Cooperation and Development",
                          target = "_blank")
                 )
        )
      )
    )
  )
)

# Server
server <- function(input, output) {
  # Dynamic filtering of data based on user-selected country, year range, and metric
  filtered_data <- reactive({
    drug_spending %>%
      filter(
        LOCATION %in% input$country,
        TIME >= input$year[1],
        TIME <= input$year[2]
      )
  })
  
  # Feature 3: Render plot of filtered data. Users can visualize trends in pharmaceutical spending over time for selected countries and metrics.
  output$spending_plot <- renderPlot({
    data <- filtered_data()
    if (nrow(data) == 0) {
      plot.new()
      text(0.5, 0.5, "No data available for the selected filters", cex = 1.5)
    } else {
      ggplot(data, aes(x = TIME, y = .data[[input$metric]], color = LOCATION)) +
        geom_line(size = 1.2) +
        labs(title = "Pharmaceutical Spending Trends",
             x = "Year",
             y = input$metric) +
        theme_minimal() +
        theme(axis.text.x = element_text(angle = 45, hjust = 1))
    }
  })
  
  # Feature 4: Render data table for filtered data
  output$data_table <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10))
  })
  
  # Feature 5: Allowing the user to download filtered data as CSV
  output$download_data <- downloadHandler(
    filename = function() { "filtered_drug_spending.csv" },
    content = function(file) {
      write.csv(filtered_data(), file, row.names = FALSE)
    }
  )
}

shinyApp(ui = ui, server = server)
