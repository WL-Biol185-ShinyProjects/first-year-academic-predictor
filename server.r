library(shiny)
library(leaflet)
library(tidyverse)

function(input, output, session) {
  
#Tabs 
  #Stats 
      output$schooloutput <- DT::renderDataTable(IPEDS_data_2,
                                                options= list(scrollX= TRUE),
                                                rownames= FALSE)
      

  
  #School 
    output$schooloutput <-  renderTable({
      search_by_df %>% 
        filter(input$schoolinput) 
    })

    output$search_by_map <- renderLeaflet({
      IPEDS_data_2 %>%
        filter(input$schoolinput) %>% 
        leaflet() %>% 
        setView(lng == IPEDS_data_2$`Longitude location of institution`, 
                lat == IPEDS_data_2$`Latitude location of institution`, 
                zoom = 12) %>% 
        addTiles()
    })
    

     #Compare
       observe({
         updateSelectInput(session, "header_input", label = "Area of Interest", choices = colnames(IPEDS_data_2))
         })
       

    output$compareoutput1 <- renderPrint(input$compareinput1)
    output$compareoutput2 <- renderPrint(input$compareinput2)
    output$compareoutput3 <- renderPrint(input$compareinput3)
    output$compareoutput4 <- renderPrint(input$compareinput4)
    output$compareoutput5 <- renderPrint(input$compareinput5)

  
      
}

    output$plot <- renderPlot({
      input$goButton
      hist(IPEDS_data_2, input$header_input, xlab = input$header_input, main=input$data_input, res = 96)
    
    })


    
    



