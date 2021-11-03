server <- function(input, output) {
  paths_allowed("https://www.amazon.co.uk/")
  
  
  txt1 <- eventReactive(input$button, {input$txt1})
  txt2 <- eventReactive(input$button, {input$txt2})
  output$txtout <- renderText({
    paste(txt1(), txt2(), sep = " ")
  })
}