library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)

function(input, output, session) {
  
#Tabs 
  # Stats
    output$schooltable <- DT::renderDataTable(
      filter(IPEDS_data_2, `Total SAT 25th Percentile` + 50 <= input$statsInput, `Total SAT 75th Percentile` - 50 >= input$statsInput),
      options= list(scrollX= TRUE),
      rownames= FALSE
    )

    
  #Explore 
    output$searchtable <-  DT::renderDataTable(
      search_by_df[, input$searchschool], 
      pageLength = 1
    )

    output$search_by_map <- renderLeaflet({
      IPEDS_data_2 %>%
        filter(input$exploreschool) %>% 
        leaflet() %>% 
        addProviderTiles(providers$Esri.NatGeoWorldMap) %>%
        setView(lng = as.numeric(IPEDS_data_2$`Longitude location of institution`), 
                lat = as.numeric(IPEDS_data_2$`Latitude location of institution`), 
                zoom = 12) %>%
        addMarkers(label = IPEDS_data_2$Name)
    })
    
    #output$stateenrollment <- renderPlot(
      #IPEDS_data %>%
        #filter(IPEDS_data$`State abbreviation` == input$explorestate) %>%
        #ggplot()
    #)
    
    output$statesat25th <- renderPlot(
      IPEDS_data_2 %>%
        filter(IPEDS_data_2$`State abbreviation` == input$explorestate) %>%
        ggplot(aes(x = `Estimated freshman enrollment, full time`, y = `Total SAT 25th Percentile`)) +
          geom_point()
    )
    
    output$statesat75th <- renderPlot(
      IPEDS_data_2 %>%
        filter(IPEDS_data_2$`State abbreviation` == input$explorestate) %>%
        ggplot(aes(IPEDS_data_2$`Estimated freshman enrollment, full time`, IPEDS_data_2$`Total SAT 75th Percentile`)) +
        geom_point()
    )
    
    output$statetuition <- renderPlot(
      IPEDS_data_2 %>%
        filter(IPEDS_data_2$`State abbreviation` == input$explorestate) %>%
        ggplot(aes(IPEDS_data_2$`Estimated freshman enrollment, full time`, IPEDS_data_2$`Tuition and fees, 2013-14`)) +
        geom_point()
    )
    
    #output$regionenrollment <- renderPlot()
    
    #output$regionsat25th <- renderPlot()
    
    #output$regionsat75th <- renderPlot()
    
    #output$regiontuition <- renderPlot()
    
    #Compare
}