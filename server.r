library(shiny)
library(leaflet)
library(tidyverse)

function(input, output, session) {
  
#Tabs 
  #Stats 


  
  #School 
    output$schooltable <-  renderTable({
      schooltable <- search_by_df %>% 
        filter(input$searchschool, asJSON(keep_vec_names=TRUE)) 
    })
    

    output$search_by_map <- renderLeaflet({
      IPEDS_data_2 %>%
        filter(input$searchschool) %>% 
        leaflet() %>% 
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        setView(lng = as.numeric(IPEDS_data_2$`Longitude location of institution`), 
                lat = as.numeric(IPEDS_data_2$`Latitude location of institution`), 
                zoom = 12) %>%
        addMarkers(label = IPEDS_data_2$Name)
        
    })
 
     #Compare

    output$compareoutput1 <- renderPrint(input$compareinput1)
    output$compareoutput2 <- renderPrint(input$compareinput2)
    output$compareoutput3 <- renderPrint(input$compareinput3)
    output$compareoutput4 <- renderPrint(input$compareinput4)
    output$compareoutput5 <- renderPrint(input$compareinput5)

  
  }

