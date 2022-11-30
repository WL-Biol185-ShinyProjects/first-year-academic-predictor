library(shiny)
library(leaflet)
library(tidyverse)

function(input, output, session) {
  
#Tabs 
  #Stats 
      output$schooltable <- DT::renderDataTable(filter(IPEDS_data_2, `Total SAT 25th Percentile` + 50 <= input$statsInput, `Total SAT 75th Percentile` - 50 >= input$statsInput),
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
    


  output$Target_Schools <- renderTable(IPEDS_data_2 %>%
                                        filter(input$statsinput >= `Total SAT 25th Percentile`)
)
  
 output$schoolTable <- renderTable(IPEDS_data_2$`Total SAT 75th Percentile`)
    
   
  
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 

     #Compare
       observe({
         updateSelectInput(session, "header_input", label = "Area of Interest", choices = colnames(IPEDS_data_2))
         })
       

    output$compareoutput1 <- renderPrint(input$compareinput1)
    output$compareoutput2 <- renderPrint(input$compareinput2)
    output$compareoutput3 <- renderPrint(input$compareinput3)
    output$compareoutput4 <- renderPrint(input$compareinput4)
    output$compareoutput5 <- renderPrint(input$compareinput5)

  data <- reactive({
    input$newplot
    IPEDS_data_2 + rnorm(nrow(IPEDS_data_2))


    output$plot <- renderPlot({
      input$goButton
      hist(IPEDS_data_2, input$header_input, xlab = input$header_input, main=input$data_input, res = 96)
    
    })


    
    




  output$plot <- renderPlot({
    d <- IPEDS_data_2
    plot(d$Name, d$'Tuition and fees, 2013-14')
  })
  
  output$plot_clickinfo <- renderPrint({
    cat("Click:\n")
    str(input$plot_click)
  })
  
  output$plot_hoverinfo <- renderPrint({
    cat("Hover (throttled):\n")
    str(input$plot_hover)
  })
  
  output$plot_brushinfo <- renderPrint({
    cat("Brush (debounced):\n")
    str(input$plot_brush)
  })
  
  output$plot_clickedpoints <- renderTable({
    res <- nearPoints(data, input$plot_click, "Name", "Tuition and fees, 2013-14")
    if (nrow(res) == 0)
      return()
    res
  })
      input$goButton
      hist(IPEDS_data_2, input$header_input, xlab = input$header_input, main=input$data_input, res = 96)
 })
}
    

