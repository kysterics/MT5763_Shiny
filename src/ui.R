# Define UI
ui <- fluidPage(theme = shinytheme("slate"),
                
                navbarPage(
                  
                  "My first app",
                  
                  tabPanel("Navbar 1",
                           
                           titlePanel("Simple histogram"),
                           sidebarPanel(
                             
                             tags$h3("Input:"),
                             textInput("txt1", "Given Name:", ""),
                             textInput("txt2", "Surname:", ""),
                             
                             selectInput("day", "Day:",
                                         c("Today" = "today",
                                           "Yesterday" = "yesterday",
                                           "Two days ago" = "twoDaysAgo")),
                             
                             # Download button
                             actionButton(inputId = "dlBtn",
                                          label = "Download",
                                          icon = icon("cloud-download-alt")),
                             
                             # Refresh button
                             actionButton(inputId = "rfBtn",
                                          label = "Refresh",
                                          icon = icon("sync-alt")),
                             
                             # Mean
                             numericInput(inputId = "mean",
                                          label = "Mean of normal distributon.",
                                          value = 0),
                             # Var
                             numericInput(inputId = "var",
                                          label = "Variance of normal distributon.",
                                          value = 1,
                                          min = 0.01),
                             # Bin
                             sliderInput(inputId = "bin",
                                         label = "Number of bins.",
                                         value = 20,
                                         min = 1,
                                         max = 50),
                             
                             # Main panel
                             # Placeholder for histogram plot
                             mainPanel(
                               plotOutput(outputId = "histPlot")
                             )
                           ), # sidebarPanel
  
                           
                           mainPanel(
                             h1("COVID-19 Update Summary"),
                             
                             #h4(paste(input$day)),
                             #tableOutput("tableOut")
                             verbatimTextOutput("txtOut")
                             # verbatimTextOutput("txtout")
                             
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("Navbar 2", "This panel is intentionally left blank"),
                  tabPanel("Navbar 3", "This panel is intentionally left blank"),
                  
                  
                ), # navbarPage

) # fluidPage