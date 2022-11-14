library(shiny)
library(leaflet)
library(tidyverse)

function(input, output, session) {
  
#Tabs 
  #Stats 
<<<<<<< HEAD
  
  #School 
    output$schooloutput <-  renderTable({
      search_by_df %>% 
        filter(input$schoolinput) %>% 
        select(1:10)
    })
    
    output$search_by_map <- renderLeaflet({
      IPEDS_data_2 %>%
        filter(input$schoolinput) %>% 
        leaflet() %>% 
        setView(lng = IPEDS_data_2$`Longitude location of institution`, lat = IPEDS_data_2$`Latitude location of institution`, zoom = 12) %>% 
        addTiles()
    })
    
  #Compare
=======
  output$Target_Schools <- renderTable({IPEDS_data_2 %>%
                                        filter(input$statsinput >= `Total SAT 25th Percentile`)
  
  })
   
    
  #School 
    output$schooloutput <-  DT::renderDataTable({
      search_by_df
    }, options = list(pageLength = 1))
 
     #Compare
>>>>>>> 88240bf6c51a1a78c6fd1720dcde1aafab1e75cc
    output$compareoutput1 <- renderPrint(input$compareinput1)
    output$compareoutput2 <- renderPrint(input$compareinput2)
    output$compareoutput3 <- renderPrint(input$compareinput3)
    output$compareoutput4 <- renderPrint(input$compareinput4)
    output$compareoutput5 <- renderPrint(input$compareinput5)
  
  
}