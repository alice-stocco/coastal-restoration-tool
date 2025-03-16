#########################################################################
#    Decision-making support tool for coastal restoration techniques    #
#     Script Author: Alice Stocco (alice.stocco@unive.it)               #
#     Citation: Horneman F., Stocco A., et al., 2025                    #
#               Evaluating Nature-Based Adaptation Techniques in        #
#               Human Dominated Coastal Continuum                       #
#               Journal Name
#               DOI/URL
#
#########################################################################
# ----------------------------------------------------------------------------------------------------------------------------------------------------- #
# Description: 
# This Shiny application visualizes the relationship between ecological restoration techniques 
# and various environmental pressures/impacts. It generates radar charts for structural 
# characteristics and natural process support based on selected pressures.

# Last update: March 12th, 2025
# ----------------------------------------------------------------------------------------------------------------------------------------------------- #
# This script uses the following libraries:
# - shiny
# - dplyr
# - DT
# - ggplot2
# - fmsb (for radar charts)

# Ensure that the necessary libraries are installed before running the app.
# The dataset used in this app should be called correctly from the specified file path.
# ----------------------------------------------------------------------------------------------------------------------------------------------------- #

#### 0. Install and load required libraries #####

# Run this section only once to install all the required libraries.
# Uncomment the line below to install the necessary packages:
# install.packages(c("shiny", "readxl", "dplyr", "DT", "ggplot2", "fmsb", "plotly"))

#### 1. Environment setup #####
# Load the necessary libraries for the app
library(readxl)
library(dplyr)
library(shiny)
library(DT)
library(ggplot2)
library(fmsb)

# ONLY IF RUN LOCALLY (ON YOUR PC):
# Load dataset (UPDATE THE LINE BELOW WITH YOUR PATH TO THE FILE)
# setwd("/home/alice/Desktop/files/restcoast/coastal_restoration_tool")
df <- read_excel("restoration_tool_dataset.xlsx", 
                 sheet = "database")

# Define column names for radar charts
structural_cols <- c("spatial", "time_to_build", "time_to_stabilize", "time_to_function", 
                     "longevity", "local_origin_materials", "biodegradable_materials")

natural_process_cols <- c("sedimentation", "current_reduction", "wave_reduction", 
                          "carbon_seq", "nutr_uptake", "nutr_retention", 
                          "plants_restoration", "fish_habitat", "birds_habitat")

#### 2. User Interface setup  #####
ui <-  fluidPage (
  tags$style("body {background-color: #b3d9ff;}"), 
  
  titlePanel("Restoration Techniques to Address Pressures and Impacts"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("selected_pressure", "Select pressure to mitigate/address:",
                  choices = unique(df$pressure),
                  selected = NULL,
                  multiple = TRUE),
      uiOutput("agreement_mean")
    ),
    
    mainPanel(
      DTOutput("filtered_table"),
      
      # Layout for radar charts: Two columns in one row
      fluidRow(
        column(6, plotOutput("structural_chart")),
        column(6, plotOutput("natural_chart"))
              )
             )
           ),
 tags$footer(
  style = "position: fixed; bottom: 10px; width: 100%; text-align: center; font-size: 12px; color: #555;",
  HTML("
      <p>Decision-support tool for coastal restoration - v.1.0 2025 </p>
      <p>This program comes with no warranty.</p>
      <p>This is free software under GNU General Public License. You are welcome to redistribute it under certain conditions. Visit https://www.gnu.org/licenses/ for details.</p>
    ")
)
)

#### 3. Server panels ####
server <- function(input, output) {
  
  # Reactive filtered data based on selected pressure
  filtered_data <- reactive({
    if (is.null(input$selected_pressure) || length(input$selected_pressure) == 0) {
      return(df[0, ])  # Return empty dataset if nothing is selected
    }
    
    df_filtered <- df %>% filter(pressure %in% input$selected_pressure)
    
    # Keep only techniques that match all selected pressures:
    common_techniques <- df_filtered %>%
      group_by(`Restoration Techniques`) %>%
      summarise(count = n_distinct(pressure)) %>%
      filter(count == length(input$selected_pressure)) %>%
      pull(`Restoration Techniques`)
    
    df_filtered %>% filter(`Restoration Techniques` %in% common_techniques)
      })
  
  # Display filtered table
  output$filtered_table <- renderDT({
    df_to_show <- filtered_data() %>%
      select(`Restoration Techniques`, description) 
    
    datatable(df_to_show, options = list(pageLength = 10), selection = "single")
      })
  
  # Get selected technique
  selected_technique <- reactive({
    req(input$filtered_table_rows_selected)
    selected_row <- filtered_data()[input$filtered_table_rows_selected, ]
    return(selected_row)
      })
  
  # Display mean agreement level
  output$agreement_mean <- renderUI({
    req(selected_technique())
    mean_value <- selected_technique()[["mean_agreement_level"]]
    color <- ifelse(mean_value >= 3.5, "green",
                    ifelse(mean_value >= 2.0, "orange", "red"))
    HTML(paste0("<b><span style='font-size: 24px; color:", color, ";'>Agreement Level (Mean): ", 
                round(mean_value, 2), "</span></b>"))})
  
  # Radar Chart for Structural Characteristics
  output$structural_chart <- renderPlot({
    req(selected_technique())  # Ensure a technique is selected
    
    data <- selected_technique()[, structural_cols, drop = FALSE]
    
    if (any(is.na(data))) return(NULL)  # Prevent errors with missing data
    
    data <- as.numeric(as.vector(data))  
    data <- rbind(rep(5, length(structural_cols)), rep(0, length(structural_cols)), data)
    
    radarchart(as.data.frame(data), 
               title = "Structural Characteristics", 
               plwd = 2,
               axistype = 2,          
               vlabels = structural_cols,    
               vlcex = 1.2,
               pcol = "#000080")           
  })
  
  # Radar Chart for Natural Processes
  output$natural_chart <- renderPlot({
    req(selected_technique())
    
    data <- selected_technique()[, natural_process_cols, drop = FALSE]
    
    if (any(is.na(data))) return(NULL)
    
    data <- as.numeric(as.vector(data))  
    data <- rbind(rep(5, length(natural_process_cols)), rep(0, length(natural_process_cols)), data)
    
    radarchart(as.data.frame(data), 
               title = "Natural Processes Support", 
               plwd = 2,
               axistype = 2,          
               vlabels = natural_process_cols,     
               vlcex = 1.2,
               pcol = "#90EE90")           
  })
}

#### Run this command to open the app ####
shinyApp(ui = ui, server = server)
# App opens in a new window #


#######################################################################################################
# "Decision-making support tool for coastal restoration techniques"
# Copyright (C) 2025  Alice Stocco - Ca' Foscari University of Venice
# alice.stocco@unive.it
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3 of the License.
  
# This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  
#  See the GNU General Public License for more details.