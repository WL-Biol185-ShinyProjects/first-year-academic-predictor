library(shiny)
library(leaflet)
library(tidyverse)
library(ggplot2)
library(plotly)
library(readr)
library(dplyr)


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
  
  output$map <- renderLeaflet({
    leaflet(IPEDS_data_2) %>%
      addTiles() %>%
      setView(lng = -78.024902, lat = 37.926868, zoom = 7) %>%
      addCircleMarkers(
        lng = ~`Longitude location of institution`,
        lat = ~`Latitude location of institution`,
        label = ~Name,
        stroke = FALSE,
        fillOpacity = 0.5,
        popup = ~paste("<p><b>" , IPEDS_data_2$Name, "</b></p>" , 
                       "<p>", "Admission Yield =", IPEDS_data_2$`Admissions yield - total`, "</p>" , 
                       "<p>", "SAT 25th Percentile =", IPEDS_data_2$`Total SAT 25th Percentile`, "</p>",
                       "<p>", "SAT 75th Percentile =", IPEDS_data_2$`Total SAT 75th Percentile`, "</p>"
        )
      )
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
  output$comparingschools <- renderPlot(
    IPEDS_data %>%
      filter(IPEDS_data$`Name` %in% input$compareschools) %>%
      ggplot(aes(x = `Tuition and fees, 2013-14`, 
                 y = `Total price for in-state students living on campus 2013-14`)) +
      geom_point()
  )
      
  }

