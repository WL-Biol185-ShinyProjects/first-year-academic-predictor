library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)

#Load and Refine Data Sets 
IPEDS_data <- read_csv("IPEDS_data.csv")

IPEDS_data_2 <- IPEDS_data_2 <- IPEDS_data[c(1, 2, 3, 4, 6, 7, 8, 22, 23, 24, 25, 27, 28, 29, 30, 31, 32, 42, 65, 66, 70, 73, 75, 80, 83, 84, 85, 86, 88, 89)]
IPEDS_data_2$`Total SAT 25th Percentile` <- IPEDS_data_2$`SAT Critical Reading 25th percentile score`+ IPEDS_data_2$`SAT Math 25th percentile score`
IPEDS_data_2$`Total SAT 75th Percentile` <- IPEDS_data_2$`SAT Critical Reading 75th percentile score`+ IPEDS_data_2$`SAT Math 75th percentile score`
IPEDS_data_2 <- IPEDS_data_2[!is.na(IPEDS_data_2$`Estimated freshman enrollment, full time`),]
IPEDS_data_2 <- IPEDS_data_2[!is.na(IPEDS_data_2$`Total SAT 25th Percentile`),]
IPEDS_data_2 <- IPEDS_data_2[!is.na(IPEDS_data_2$`Total SAT 75th Percentile`),]
IPEDS_data_2 <- IPEDS_data_2[!is.na(IPEDS_data_2$`Tuition and fees, 2013-14`),]

search_by_df <- IPEDS_data_2[, c(2, 8, 9, 19, 12:17)]


function(input, output, session) {
  
  #Tabs 
  # Stats
  output$schooltable <- DT::renderDataTable(
    filter(IPEDS_data_2, `Total SAT 25th Percentile` + 50 <= input$statsInput, `Total SAT 75th Percentile` - 50 >= input$statsInput),
    options= list(scrollX= TRUE),
    rownames= FALSE)
  
  
  #Explore 
  output$searchtable <-  DT::renderDataTable(
    search_by_df, 
    options = list(pageLength = 10)
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
      ggplot(aes(x = `Estimated freshman enrollment, full time`, y = `Total SAT 75th Percentile`)) +
      geom_point()
  )
  
  output$statetuition <- renderPlot(
    IPEDS_data_2 %>%
      filter(IPEDS_data_2$`State abbreviation` == input$explorestate) %>%
      ggplot(aes(x = `Estimated freshman enrollment, full time`, y = `Tuition and fees, 2013-14`)) +
      geom_point()
  )
  
  #output$regionenrollment <- renderPlot()
  
  output$regionsat25th <- renderPlot(
    IPEDS_data_2 %>%
      filter(IPEDS_data_2$`Geographic region` == input$exploreregion) %>%
      ggplot(aes(x = `Estimated freshman enrollment, full time`, y = `Total SAT 25th Percentile`)) +
      geom_point()
  )
  
  output$regionsat75th <- renderPlot(
    IPEDS_data_2 %>%
      filter(IPEDS_data_2$`Geographic region` == input$exploreregion) %>%
      ggplot(aes(x = `Estimated freshman enrollment, full time`, y = `Total SAT 75th Percentile`)) +
      geom_point()
  )
  
  output$regiontuition <- renderPlot(
    IPEDS_data_2 %>%
      filter(IPEDS_data_2$`Geographic region` == input$exploreregion) %>%
      ggplot(aes(x = `Estimated freshman enrollment, full time`, y = `Tuition and fees, 2013-14`)) +
      geom_point()
  )
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  #Compare
  output$distPlot <- renderPlot({
    IPEDS_data %>%
      filter('Name' %in% input$compareaid)
      ggplot(IPEDS_data, aes(x = `Total price for in-state students living on campus 2013-14`, 
                 y = `Total price for out-of-state students living on campus 2013-14`,
                 color = input$compareaid)) + geom_line()
      
      
  })
}
