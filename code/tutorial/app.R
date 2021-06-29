library(shiny)

## GOAL: Simple app that lets me select gender and show stats of that 
## gender.

df <- read.csv("./data/neiss/population.tsv", sep="\t")

ui <- fluidPage(
  selectInput("gender", "Choose gender: ", choices = unique(df$sex))
  , dataTableOutput("dataByGender")
  
)

server <- function(input, output){
  output$dataByGender <- renderDataTable({
    df[df$sex==input$gender,]
  })
}

shinyApp(ui=ui, server=server)