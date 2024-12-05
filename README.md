[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/_WsouPuM)

---

This README file contains introductory information about the assignment B3 and B4 Shiny apps. A different app was developed for each assignment.

# **World Happiness Report Analysis** (Assignment B4)

## **Overview**
This Shiny app explores global happiness trends using data from the World Happiness Report. Users can:
- Visualize top-ranked countries by happiness score.
- Compare happiness scores across regions using boxplots.
- Analyze correlations between happiness scores and other metrics (e.g., Economy, Health, Freedom, Generosity).
- Filter data by region and download customized datasets for offline analysis.

---

## **Link to App**
Access the running instance of the app here:  
[**World Happiness Report Analysis**](https://gelarehmodara.shinyapps.io/assignment-b4-happiness/)

---

## **Dataset**
The dataset used in this app is from the **World Happiness Report**, an annual publication that ranks countries by their happiness levels based on various metrics.

### **Key Columns in the Dataset**
- **Country**: The name of the country.
- **Happiness Rank**: The rank of the country based on its happiness score.
- **Happiness Score**: The overall happiness score.
- **Economy**: The GDP per capita metric.
- **Health**: Life expectancy metric.
- **Freedom**: Perceived freedom to make life choices.
- **Generosity**: Contributions to charity.
- **Corruption**: Perceived corruption levels.
- **Job Satisfaction**: Levels of satisfaction with employment.
- **Region**: The region to which the country belongs.

### **Source Acknowledgment**
I acknowledge the **World Happiness Report** for making this data publicly available. The dataset can be accessed here: [World Happiness Report](https://worldhappiness.report/).

---

## **Features**
- **Ranking Analysis**: Visualize the top N happiest countries by Happiness Score.
- **Region Comparison**: Compare happiness scores across regions using interactive boxplots to analyze median, variation, and outliers.
- **Metric Correlation**: Analyze the relationship between happiness scores and other metrics (e.g., Economy, Health, Freedom) with interactive scatterplots.
- **Data Filtering**: Filter data by region and download customized datasets in CSV format.

---

## **How to Use**
1. **Filters**:
   - Select one or more regions from the dropdown menu to focus the analysis.
   - Specify the number of top-ranked countries to visualize.
   - Choose a metric for correlation analysis.
2. **Visualizations**:
   - Navigate through the tabs to explore rankings, region comparisons, and metric correlations.
   - Hover over the graphs for detailed data points.
3. **Download Data**:
   - Use the download button in the sidebar to export the filtered dataset for offline analysis.

---

## **Installation for Both Projects**
To run these apps locally:
1. Clone the respective repositories to your local machine.
2. Install the required R packages:
   ```R
   install.packages(c("shiny", "ggplot2", "dplyr", "DT", "plotly", "shinyWidgets"))
   ```
3. Run the app:
   ```R
   shiny::runApp()
   ```
---

# **Pharmaceutical Drug Spending by Countries** (Assignment B3)

## **Overview**
This Shiny app visualizes trends in pharmaceutical drug spending across various countries over time. Users can:
- Select countries and time ranges to explore spending trends.
- Choose from multiple spending metrics, such as:
  - Percentage of health expenditure
  - Percentage of GDP
  - Per capita spending in USD
  - Total spending
- View detailed data in a table format and download filtered results as a CSV file.

---

## **Link to App**
Access the running instance of the app here:  
[**Pharmaceutical Drug Spending by Countries**](https://gelarehmodara.shinyapps.io/assignment-b3-gelarehm/)

---

## **Dataset**
The dataset used in this app is sourced from the **Organisation for Economic Cooperation and Development (OECD)**, available on [DataHub](https://datahub.io/core/pharmaceutical-drug-spending).

### **Key Columns in the Dataset**
- **LOCATION**: Country codes.
- **TIME**: Year.
- **PC_HEALTHXP**: Percentage of health expenditure.
- **PC_GDP**: Percentage of GDP.
- **USD_CAP**: Per capita spending in USD.
- **TOTAL_SPEND**: Total spending.

### **Source Acknowledgment**
I acknowledge the Organisation for Economic Cooperation and Development for making this data publicly available. The dataset can be directly accessed here: [Pharmaceutical Drug Spending Dataset](https://datahub.io/core/pharmaceutical-drug-spending).

---

## **Features**
- **Dynamic Filtering**: Filter data by countries, year ranges, and spending metrics.
- **Interactive Plot**: Visualize spending trends with a customizable line plot.
- **Data Table and Download**: Explore filtered data in a tabular format and download it as a CSV file.

---

## **How to Use**
1. Select countries from the sidebar.
2. Adjust the year range using the slider.
3. Choose a metric to plot.
4. Navigate between tabs to view the plot, data table, or download filtered data.

