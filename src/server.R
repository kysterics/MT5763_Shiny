server <- function(input, output) {
  # paths_allowed("https://www.amazon.co.uk/")
  
  txt1 <- reactive({
    if (input$day == "allowNull"){
      return("Today")
    }
    if (input$day == "yesterday"){
      return("Yesterday")
    }
    if (input$day == "twoDaysAgo"){
      return("Two days ago")
    }
  })
  
  output$txtOut1 <- renderText({
    glue("COVID-19 Update Summary ({txt1()})")
  })
  
  # Summary ---------------------------
  # set reactive timer to 3600000 ms, or 1 hour
  autoInvalidate <- reactiveTimer(3600000)
  
  data <- reactive({
    input$rfBtn
    # API call
    # takes `allowNull`(today), `yesterday` and `twoDaysAgo` queries
    URL <- glue("https://disease.sh/v3/covid-19/all?{input$day}=true")
    # Send http request
    response <- httr::GET(URL)
    
    # Read / unpack a binary file
    dtaJSON <- readBin(response$content, "text")
    data <- fromJSON(dtaJSON) %>%
      bind_rows()
    
    if (input$autoRf){
      autoInvalidate()
      return(data)
    }
    
    return(data)
  })
  

  output$tableOut1 <- renderTable({
    data <- data() %>%
      select(`todayCases`, `todayDeaths`, `todayRecovered`, `active`, `critical`)
  })

  output$tableOut2 <- renderTable({
    data <- data() %>%
      select(`cases`, `deaths`, `recovered`, `tests`, `population`)
    # select(-`updated`, -``, -``, -``, -``)
  })
  output$tableOut3 <- renderTable({
    data <- data() %>%
      select(`casesPerOneMillion`, `deathsPerOneMillion`, `deathsPerOneMillion`, `recoveredPerOneMillion`)
  })
  
  # Detailed Table ---------------------------
  data1 <- reactive({
    input$rfBtn
    # Web page containing data
    URL <- "https://www.worldometers.info/coronavirus/"
    # Download the whole web page
    htmlPage <- read_html(URL) 
    # Access the whole table

    marketTable <- htmlPage %>%
      html_nodes("#main_table_countries_today") %>% # main_table_countries_yesterday
      html_table() %>%
      bind_rows() %>%
      filter(!is.na(`#`)) %>%
      select(1:9)

    if (input$order == "asc") {
      marketTable <- marketTable %>% 
        arrange(get(input$sort)) # `get` turns character into a variable
    }
    
    if (input$order == "dsc") {
      marketTable <- marketTable %>% 
        arrange(desc(get(input$sort)))
    }
    marketTable
  })
  

  # txt2 <- eventReactive(input$button, {input$txt2})
  
  output$tableOut4 <- renderTable({
    data1()
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(data1(), file, row.names = FALSE)
    }
  )
}