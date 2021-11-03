server <- function(input, output) {
  # paths_allowed("https://www.amazon.co.uk/")
  
  # takes `allowNull`(today), `yesterday` and `twoDaysAgo`
  # returns a reactive object

  data <- eventReactive(c(input$rfBtn, input$day), {
      # API call
      URL <- glue("https://disease.sh/v3/covid-19/all?{input$day}=true")
      # Send http request
      response <- httr::GET(URL)
      
      # Read / unpack a binary file
      dtaJSON <- readBin(response$content, "text")
      dta <- jsonlite::fromJSON(dtaJSON)
      dta
  })
  
  #data <- eventReactive(input$button, {
    # Web page containing data over several weeks
    #URL <- "https://www.skysports.com/premier-league-table"
    #URL <- "https://uk.investing.com/crypto/bitcoin/historical-data"
    
    # Download the whole web page
    #htmlPage <- read_html(URL) 
    
    # Access the whole table
    #marketTable <- htmlPage %>%
      #html_nodes(".standing-table__table") %>%
      #html_nodes("#curr_table") %>%
      #html_table

  #})

  # txt1 <- eventReactive(input$button, {input$txt1})
  # txt2 <- eventReactive(input$button, {input$txt2})
  
  
  #output$tableOut <- renderTable({
    #data()
  #})
  output$txtOut <- renderText({
    paste("Country:", "ALL", "\n",
          
          "Total Cases:", data()$cases, "\n",
          "Cases Today:", data()$todayCases, "\n",
          
          "Total Deaths", data()$deaths, "\n",
          "Deaths today:", data()$todayDeaths, "\n",
          
          "Active Cases:", data()$active, "\n",
          "Critical Cases:", data()$critical, "\n"
    )
  })
  
}