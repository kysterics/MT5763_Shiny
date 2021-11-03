server <- function(input, output) {
  # paths_allowed("https://www.amazon.co.uk/")
  
  
  data <- eventReactive(input$button, {
    # Web page containing data over several weeks
    #URL <- "https://www.skysports.com/premier-league-table"
    URL <- "https://uk.investing.com/crypto/bitcoin/historical-data"
    
    # Download the whole web page
    htmlPage <- read_html(URL) 
    
    # Access the whole table
    marketTable <- htmlPage %>%
      #html_nodes(".standing-table__table") %>%
      html_nodes("#curr_table") %>%
      html_table

  })

  # txt1 <- eventReactive(input$button, {input$txt1})
  # txt2 <- eventReactive(input$button, {input$txt2})
  
  
  output$tableOut <- renderTable({
    data()
  })
  
}