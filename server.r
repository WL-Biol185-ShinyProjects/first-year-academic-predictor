library(shiny)
library(leaflet)
library(tidyverse)

function(input, output, session) {
  
#Tabs 
  #Stats 
  
  #School 
    output$schooloutput <-  renderTable({
      search_by_df %>% 
        filter(inputId$schoolinput) %>% 
        select(1:10)
    })
    
    output$search_by_map <- renderLeaflet({
      IPEDS_data_2 %>%
        filter(inputId$schoolinput) %>% 
        leaflet() %>% 
        setView(lng = IPEDS_data_2$`Longitude location of institution`, lat = IPEDS_data_2$`Latitude location of institution`, zoom = 12) %>% 
        addTiles()
    })
    
  #Compare
    output$compareoutput1 <- renderPrint(input$compareinput1)
    output$compareoutput2 <- renderPrint(input$compareinput2)
    output$compareoutput3 <- renderPrint(input$compareinput3)
    output$compareoutput4 <- renderPrint(input$compareinput4)
    output$compareoutput5 <- renderPrint(input$compareinput5)
  
  
}