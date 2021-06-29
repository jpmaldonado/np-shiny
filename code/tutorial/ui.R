header <- dashboardHeader(title="My Shiny Application")
sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Upload data", tabName = "upload", icon=icon("file-upload"))
        , menuItem("Population", tabName = "population", icon=icon("users"))
        , menuItem("Location", tabName = "map", icon=icon("map"))
    )
)
body <- dashboardBody(
    
    # Store components in boxes / one row = many boxes
    tabItems(
        tabItem(tabName = "upload",
                fluidRow(
                    box(title = "Data Ingestion"
                        , width = 4
                        , status = "warning"
                        , solidHeader = T
                        , fileInput("file", "Upload your file", accept = c(".tsv",".csv"))    
                    )
                    
                    , box(
                        title = "Parameter selection"
                        , width = 4
                        , status = "info"
                        , solidHeader = T
                        , selectInput("gender", "Choose gender: ", choices = c("male","female"))
                        , sliderInput("age","Select age range: "
                                      , min = 10
                                      , max = 50
                                      , value = c(35,45 ) )
                        , actionButton("calculate", "Analyze")
                    )
                    
                ))
        ,tabItem(
            tabName = "population",
            fluidRow(
                box(dataTableOutput("dataByGender"))
                , box(plotlyOutput("plotByGender")  )
                
            )
        )
        
        ,tabItem(
            tabName = "map",
            fluidRow(
                box(
                    sliderInput("lat", "Choose latitude: "
                                , min = -37, max = -33, value = -35)
                    ,sliderInput("lng", "Choose longitude: "
                                 , min = 147, max = 151, value = 149)
                )
                , box(leafletOutput("myMap"))
                )
            
            , textOutput("text")
            
        )
        
    )
)

dashboardPage(
    skin = "black",
    header,
    sidebar,
    body
)
