library(shiny)
rm(ui) ; rm(server)

ui <- fluidPage(
  br(),
  sliderInput("range","range",min = -3, max = 3, value = c(-2, 2)),
  div(verbatimTextOutput("out1"), style = "width: 300px;")
)

server <- function(input, output) { 
  
  output$out1 <- renderText({
    # seq.int(from = input$range[1], to = input$range[2])
    input$range[1]:input$range[2]
  })
  
}
shinyApp(ui, server)