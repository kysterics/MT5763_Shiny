server <- function(input, output) {
  
  txt1 <- reactive({
    if (input$dayGlobal == "allowNull"){
      return("Today")
    }
    if (input$dayGlobal == "yesterday"){
      return("Yesterday")
    }
    if (input$dayGlobal == "twoDaysAgo"){
      return("Two days ago")
    }
  })
  
  output$txtOut1 <- renderText({
    glue::glue("COVID-19 Update Summary ({txt1()})")
  })
  
  txt2 <- reactive({
    if (input$dayCountry == "today"){
      return("Today")
    }
    if (input$dayCountry == "yesterday"){
      return("Yesterday")
    }
    if (input$dayCountry == "yesterday2"){
      return("Two days ago")
    }
  })
  
  output$txtOut2 <- renderText({
    glue::glue("Cases by Country/Territory ({txt2()})")
  })
  
  # Summary ---------------------------
  # set reactive timer to 3600000 ms, or 1 hour
  autoInvalidate <- reactiveTimer(3600000)
  
  data <- reactive({
    input$rfBtn
    # API call
    # takes `allowNull`(today), `yesterday` and `twoDaysAgo` queries
    URL <- glue::glue("https://disease.sh/v3/covid-19/all?{input$dayGlobal}=true")
    # Send http request
    response <- httr::GET(URL)
    
    # Read / unpack a binary file
    dtaJSON <- readBin(response$content, "text")
    data <- fromJSON(dtaJSON) %>%
      bind_rows()

    # set up auto-refresh
    if (input$autoRf){
      autoInvalidate()
      return(data)
    }
    data
  })
  

  output$tableOut1 <- renderTable({
    data <- data() %>%
      select(`todayCases`, `todayDeaths`, `todayRecovered`, `active`, `critical`) %>%
      # make numbers more readable by removing trailing zeros and adding commas
      mutate(across(everything(), function(x){ number(x, accuracy = 1, big.mark = ",") }))
  })

  output$tableOut2 <- renderTable({
    data <- data() %>%
      select(`cases`, `deaths`, `recovered`, `tests`, `population`) %>%
      # make numbers more readable by removing trailing zeros and adding commas
      mutate(across(everything(), function(x){ number(x, accuracy = 1, big.mark = ",") }))
    # select(-`updated`, -``, -``, -``, -``)
  })
  
  output$tableOut3 <- renderTable({
    data <- data() %>%
      select(`casesPerOneMillion`, `deathsPerOneMillion`, `deathsPerOneMillion`, `recoveredPerOneMillion`) %>%
      # make numbers more readable by removing trailing zeros and adding commas
      mutate(across(everything(), function(x){ number(x, accuracy = 1, big.mark = ",") }))
  })
  
  # Detailed Table ---------------------------
  usefulCol <- c(1:9) # columns to keep
  usefulNumCol <- c(3:9) # columns with numbers
  
  data1 <- reactive({
    input$rfBtn
    # Web page containing data
    URL <- "https://www.worldometers.info/coronavirus/"
    # Download the whole web page
    htmlPage <- read_html(URL) 
    # Access the whole table
    covidCountryTable <- htmlPage %>%
      html_nodes(glue::glue("#main_table_countries_{input$dayCountry}")) %>% # main_table_countries_yesterday
      html_table() %>%
      bind_rows() %>%
      filter(!is.na(`#`)) %>%
      select(usefulCol) %>%
      # read character numerically
      mutate(across(usefulNumCol, readr::parse_number))
    
    # set up sorting order
    if (input$order == "asc") {
      covidCountryTable <- covidCountryTable %>% 
        arrange(get(input$sort)) # `get` turns character into a variable
    }
    if (input$order == "dsc") {
      covidCountryTable <- covidCountryTable %>%
        arrange(desc(get(input$sort)))
    }
    covidCountryTable 
  })
  

  # txt2 <- eventReactive(input$button, {input$txt2})
  
  # output Detailed Table
  output$tableOut4 <- renderTable({
    data1() %>%
      # make numbers more readable by removing trailing zeros and adding commas
      # alternatively # mutate(across(where(is.numeric), as.integer)) # mutate_if(is.numeric, as.integer)
      mutate(across(usefulNumCol, function(x){ number(x, accuracy = 1, big.mark = ",") }))
  })
  
  datasetInput <- reactive({
    if (input$dataset == "globalTotals") {
      # converting rows into columns and columns into rows
      data <- data() %>% 
        rownames_to_column() %>% 
        gather(`0`, values, -rowname) %>% 
        spread(rowname, values)
      return(data)
    }
    if (input$dataset == "casesByCountry") {
      return(data1())
    }
  })
  
  output$downloadData <- downloadHandler(

    filename = function() {
      paste(input$dataset, ".csv", sep = "")
    },
    content = function(file) {
      write.csv(datasetInput(), file, row.names = FALSE)
    }
  )
}