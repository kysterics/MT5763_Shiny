server <- function(input, output) {
  # paths_allowed("https://www.amazon.co.uk/")
  
  # set reactive timer to 3600000 ms, or 1 hour
  autoInvalidate <- reactiveTimer(3600000)
  
  data <- reactive({
    input$refresh
    data <- eventReactive(c(input$rfBtn, input$day), {
      # API call
      # takes `allowNull`(today), `yesterday` and `twoDaysAgo` queries
      URL <- glue("https://disease.sh/v3/covid-19/all?{input$day}=true")
      # Send http request
      response <- httr::GET(URL)
      
      # Read / unpack a binary file
      dtaJSON <- readBin(response$content, "text")
      dta <- jsonlite::fromJSON(dtaJSON)
      dta
    })
    
    if(input$autoRf){
      autoInvalidate()
      return(data())
    }
    return(data())
  })
  

  output$tableOut1 <- renderTable({
    data <- bind_rows(data()) %>%
      select(`todayCases`, `todayDeaths`, `todayRecovered`, `active`, `critical`)
  })

  output$tableOut2 <- renderTable({
    data <- bind_rows(data()) %>%
      select(`cases`, `deaths`, `recovered`, `tests`, `population`)
    # select(-`updated`, -``, -``, -``, -``)
  })
  output$tableOut3 <- renderTable({
    data <- bind_rows(data()) %>%
      select(`casesPerOneMillion`, `deathsPerOneMillion`, `deathsPerOneMillion`, `recoveredPerOneMillion`)
  })
  
  
}