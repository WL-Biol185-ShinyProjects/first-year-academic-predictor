library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)


ui <- fluidPage(
  
  # App title ----
  titlePanel("College Search: SAT Score"),
  
  mainPanel(
    
    # Output: Tabset w/ plot, summary, and table ----
    tabsetPanel(type = "tabs",
                
                tabPanel("Search by Your Stats",
                         
                         numericInput(
                           inputId = "statsInput",
                           label = "Enter SAT to see compatible schools",
                           value = "0",
                           min = "0",
                           max = "1600",
                           step= 10),
                         
                         DT::dataTableOutput("schooltable")
                ), 
                
                
                tabPanel("Explore",
                         
                         fluidRow(
                           h4("Explore by School")
                         ),
                         
                         DT::dataTableOutput("searchtable"), 
                         
                         fluidRow(
                           leafletOutput("map")
                         ),
                         
                         selectInput(
                           inputId = "explorestate",
                           label = "Explore by State", 
                           choices = IPEDS_data_2$`State abbreviation`,
                           multiple = FALSE
                         ), 
                         
                         plotOutput(
                           "statesat25th",
                           brush = "statesat25thbrush"
                         ),
                         tableOutput("exploredata1"), 
                         
                         plotOutput(
                           "statesat75th", 
                           brush = "statesat75thbrush"
                         ), 
                         tableOutput("exploredata2"), 
                         
                         plotOutput(
                           "statetuition", 
                           brush = "statetuitionbrush"
                         ), 
                         tableOutput("exploredata3"), 
                         
                         selectInput(
                           inputId = "exploreregion", 
                           label = "Explore by Region", 
                           choices = as.list(IPEDS_data_2$`Geographic region`),
                           multiple = FALSE
                         ),
                         
                         plotOutput(
                           "regionsat25th", 
                           brush = "regionsat25thbrush"
                         ), 
                         tableOutput("exploredata4"), 
                         
                         plotOutput(
                           "regionsat75th", 
                           brush = "regionsat75thbrush" 
                         ), 
                         tableOutput("exploredata5"), 
                         
                         plotOutput(
                           "regiontuition",
                           brush = "regiontuitionbrush"
                         ), 
                         tableOutput("exploredata6")
                ),     
                
                
                tabPanel("Compare Colleges", 
                         
                         fluidRow(
                           column(
                             6,
                             selectInput(
                               inputId = "compareschools",
                               label = "Select Schools to Compare",
                               choices = as.list(IPEDS_data$Name),
                               multiple = TRUE
                             ),
                           ), 
                         ),
                         
                         plotOutput("schoolcompare"),
                         
                         tabPanel("Compare Colleges", 
                                  
                                  fluidRow(
                                    column(
                                      6, 
                                      selectInput(
                                        inputId = "compareschools", 
                                        label = "Select Schools to Compare", 
                                        choices = as.list(IPEDS_data$Name),
                                        multiple = TRUE),
                                    ),
                                  ),
                                  
                                  fluidRow(
                                    column(8,
                                           selectizeInput(
                                             inputID = "comparingaid",
                                             label = "Select Schools for Aid Comparison",
                                             choices = as.list(IPEDS_data$Name),
                                             multiple = TRUE),
                                           
                                           plotOutput("anyaidplot",
                                                      brush = "anyaidbrush"),
                                           tableOutput = "anyaidtable"
                                           
                                    ))
                         )
                         
                ) 
    ) 
  )
)              
    
  



          