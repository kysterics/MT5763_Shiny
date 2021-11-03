# Define UI
ui <- fluidPage(theme = shinytheme("slate"),
                titlePanel("Simple histogram"),
                
                sidebarLayout(
                  
                  # Side panel
                  sidebarPanel(
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
                                max = 50)
                  ),
                  
                  # Main panel
                  # Placeholder for histogram plot
                  mainPanel(
                    plotOutput(outputId = "histPlot")
                  )
                ),
                
                navbarPage( 
                  "My first app",
                  tabPanel("Navbar 1",
                           sidebarPanel(
                             tags$h3("Input:"),
                             textInput("txt1", "Given Name:", ""),
                             textInput("txt2", "Surname:", ""),
                             actionButton(inputId = "button",
                                          label = "Press me!",
                                          icon = icon("concierge-bell"))
                           ), # sidebarPanel
                           
                           mainPanel(
                             h1("Header 1"),
                             
                             h4("Output 1"),
                             verbatimTextOutput("txtout")
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  tabPanel("Navbar 2", "This panel is intentionally left blank"),
                  tabPanel("Navbar 3", "This panel is intentionally left blank")
                  
                ) # navbarPage
) # fluidPage