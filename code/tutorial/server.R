function(input, output, session){
    
    # STORE INTO AN OBJECT TO BE REUSED IN SERVER
    #filteredData <- reactive({ df[(df$sex==input$gender) & (df$age>=input$age[1]) & (df$age<=input$age[2]),]})
    
    # TRIGGERS SOME CODE EXECUTION AFTER EVENT (WITHOUT RETURN)
    observeEvent(input$calculate, { cat(file=stderr(), "Calculation started")})
    
    output$text <- renderText({ ifelse(input$calculate, "Calculation started", "") })
    
    # TRIGGERS SOME CODE EXECUTION AFTER EVENT (WITH RETURN)
    filteredData <- eventReactive(input$calculate,
                                 { rawData()[(rawData()$sex==input$gender) & (rawData()$age>=input$age[1]) & (rawData()$age<=input$age[2]),]})
    
    
    ## FILE UPLOAD
    rawData <- reactive({
        req(input$file)
        read.csv(input$file$datapath, sep="\t")
    })
    
    
    ## DYNAMIC UI
    observeEvent(input$gender, {
        newLabel <- paste("Analyze ",input$gender)
        #browser()
        updateActionButton(session=session, inputId = "calculate",label = newLabel)   
    })
    
    output$dataByGender <- renderDataTable({
        filteredData()
    })
    
    output$plotByGender <- renderPlotly({
        #barplot(filteredData()$population, filteredData()$age)
        gg <- ggplot(filteredData(), aes(age,population))+
                geom_col(fill="blue")+
                theme_bw()
        ggplotly(gg)
    })
    
    
    output$myMap <- renderLeaflet({
        leaflet() %>%
            addTiles() %>%
            addMarkers(lat = input$lat, lng = input$lng, popup = "City Center")
            
    })
}