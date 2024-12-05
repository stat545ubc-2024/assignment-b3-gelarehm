

# Load required libraries
library(shiny)
library(ggplot2)
library(dplyr)
library(DT)
library(plotly)
library(shinyWidgets)

# Load data

happiness_data <- read.csv("data/World Happiness Report.csv")
#happiness_data <- read.csv("/Users/gelareh/Downloads/World Happiness Report.csv")

# UI
ui <- fluidPage(
  titlePanel("World Happiness Report Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      h4("About"),
      p("The World Happiness Report Shiny App allows users to explore global happiness trends."),
      p("Features include:"),
      tags$ul(
        tags$li("Visualize top-ranked countries by happiness score."),
        tags$li("Compare happiness scores across regions using boxplots."),
        tags$li("Analyze correlations between happiness and other metrics."),
        tags$li("Filter data by region and download customized datasets.")
      ),
      p(
        "Data Source: ",
        tags$a(href = "https://worldhappiness.report/", 
               "World Happiness Report", target = "_blank")
      ),
      
      hr(),
      
      h4("Filters"),
      pickerInput(
        "region", 
        "Select Region(s):", 
        choices = unique(happiness_data$Region), 
        multiple = TRUE, 
        options = list(
          `actions-box` = TRUE,
          `title` = "Select one or more regions to analyze"
        ),
        selected = unique(happiness_data$Region)
      ),
      
      h4("Analysis Settings"),
      numericInput("rank", "Top N Countries by Happiness Rank:", 
                   value = 10, min = 1, max = nrow(happiness_data)),
      selectInput("metric", "Select Metric for Correlation:", 
                  choices = c("Economy", "Health", "Freedom", "Generosity", "Corruption", "Job.Satisfaction"), 
                  selected = "Economy"),
      
      hr(),
      
      h4("Download Data"),
      p("Click the button below to download the filtered dataset in CSV format."),
      downloadButton("download_filtered", "Download Filtered Dataset")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Ranking", plotlyOutput("rankPlot")),
        tabPanel("Region Comparison", plotlyOutput("regionBoxPlot")),
        tabPanel("Metric Correlation", plotlyOutput("metricCorrelationPlot")),
        tabPanel("Filtered Data", DTOutput("filteredData"))
      )
    )
  )
)

# Server
server <- function(input, output, session) {
  # Custom theme for ggplot2
  custom_theme <- theme_minimal(base_family = "Arial") +
    theme(
      text = element_text(size = 12),
      axis.text = element_text(size = 10),
      axis.title = element_text(size = 12)
    )
  
  # Reactive filtered data
  filtered_data <- reactive({
    happiness_data %>%
      filter(Region %in% input$region)
  })
  
  # Ranking plot
  output$rankPlot <- renderPlotly({
    top_countries <- filtered_data() %>%
      arrange(Happiness.Rank) %>%
      head(input$rank)
    
    # Color palette for rankings
    rank_colors <- colorRampPalette(c("gold", "orange", "red"))(nrow(top_countries))
    
    plot_ly(top_countries, 
            x = ~reorder(Country, -Happiness.Score), 
            y = ~Happiness.Score, 
            type = "bar",
            marker = list(color = rank_colors)) %>%
      layout(
        title = list(text = "Top Countries by Happiness Rank", font = list(family = "Arial", size = 14)),
        xaxis = list(title = "Country", tickangle = 45, font = list(family = "Arial")),
        yaxis = list(title = "Happiness Score", font = list(family = "Arial")),
        font = list(family = "Arial")
      )
  })
  
  # Region comparison interactive boxplots
  output$regionBoxPlot <- renderPlotly({
    plot <- ggplot(filtered_data(), aes(x = Region, y = Happiness.Score, fill = Region)) +
      geom_boxplot(outlier.color = "red", outlier.size = 2) +
      scale_fill_brewer(palette = "Set3") +  # Improved color scheme
      labs(title = "Happiness Score Distribution by Region",
           x = "Region", y = "Happiness Score") +
      custom_theme +
      theme(axis.text.x = element_text(angle = 45, hjust = 1))
    
    ggplotly(plot) %>% 
      layout(
        title = list(font = list(family = "Arial", size = 14)),
        xaxis = list(title = "Region", tickangle = 45, font = list(family = "Arial")),
        yaxis = list(title = "Happiness Score", font = list(family = "Arial")),
        font = list(family = "Arial")
      )
  })
  
  # Metric correlation plot
  output$metricCorrelationPlot <- renderPlotly({
    metric_data <- filtered_data()
    
    # Custom color palette
    warm_cool_palette <- colorRampPalette(c("blue", "green", "yellow", "orange", "red"))
    colors <- warm_cool_palette(nrow(metric_data))
    
    plot_ly(metric_data,
            x = ~.data[[input$metric]],
            y = ~Happiness.Score,
            text = ~Country, 
            type = "scatter",
            mode = "markers",
            marker = list(size = 10, color = colors)) %>%
      layout(
        title = list(text = paste("Relationship between", input$metric, "and Happiness Score"), font = list(family = "Arial", size = 14)),
        xaxis = list(title = input$metric, font = list(family = "Arial")),
        yaxis = list(title = "Happiness Score", font = list(family = "Arial")),
        font = list(family = "Arial")
      )
  })
  
  # Filtered data table
  output$filteredData <- renderDT({
    datatable(filtered_data(), options = list(pageLength = 10, searchHighlight = TRUE))
  })
  
  # Download filtered dataset
  output$download_filtered <- downloadHandler(
    filename = function() { "filtered_happiness_data.csv" },
    content = function(file) {
      write.csv(filtered_data(), file, row.names = FALSE)
    }
  )
}

# Run the app
shinyApp(ui = ui, server = server)



