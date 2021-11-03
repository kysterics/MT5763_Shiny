# Define UI
ui <- fluidPage(theme = shinytheme("slate"),
                
                navbarPage(
                  
                  "Data Source",
                  
                  tabPanel("Worldometers",
                           
                           #titlePanel("Simple"),
                           sidebarPanel(
                             #tags$h3("Configurator"),
                             #textInput("txt1", "Given Name:", ""),
                             #textInput("txt2", "Surname:", ""),
                             
                             selectInput("day", "Day:",
                                         # queries for API
                                         c("Today" = "allowNull",
                                           "Yesterday" = "yesterday",
                                           "Two days ago" = "twoDaysAgo")),
                             
                             # Refresh button
                             actionButton(inputId = "rfBtn",
                                          label = "Refresh",
                                          icon = icon("sync-alt")),
                             
                             # Auto refresh checkbox
                             checkboxInput("autoRf","Auto refresh (every hour)", T),
                             
                             
                             # Download button
                             actionButton(inputId = "dlBtn",
                                          label = "Download",
                                          icon = icon("cloud-download-alt")),
                             # 
                             # # Mean
                             # numericInput(inputId = "mean",
                             #              label = "Mean of normal distributon.",
                             #              value = 0),
                             # # Var
                             # numericInput(inputId = "var",
                             #              label = "Variance of normal distributon.",
                             #              value = 1,
                             #              min = 0.01),
                             # # Bin
                             # sliderInput(inputId = "bin",
                             #             label = "Number of bins.",
                             #             value = 20,
                             #             min = 1,
                             #             max = 50),
                             
                             # Main panel
                             # Placeholder for histogram plot
                             mainPanel(
                               plotOutput(outputId = "histPlot")
                             )
                           ), # sidebarPanel
  
                           
                           mainPanel(
                             h1("COVID-19 Update Summary"),
                             
                             #h4("General"),
                             tableOutput("tableOut1"),
                             tableOutput("tableOut2"),
                             tableOutput("tableOut3"),
                             tableOutput("tableOut4"),
                             #verbatimTextOutput("txtOut")
                             
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("JHUCSSE", "This panel is intentionally left blank"),
                  tabPanel("Navbar 3", "This panel is intentionally left blank"),
                  
                  
                ), # navbarPage

) # fluidPage