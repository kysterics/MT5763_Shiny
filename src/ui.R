# Define UI
ui <- fluidPage(theme = shinytheme("slate"),
                
                navbarPage(
                  
                  "Data Source",
                  
                  tabPanel("Worldometers",
                           
                           #titlePanel("Floating Panel"),
                           sidebarPanel(
                             
                             # style = "position:fixed;width:15%;",
                             
                             tags$h3("Global Totals"),
                             # textInput("txt1", "Country", ""),
                             #textInput("txt2", "Surname:", ""),
                             
                             selectInput("day", "Day:",
                                         # queries for API
                                         c("Today" = "allowNull",
                                           "Yesterday" = "yesterday",
                                           "Two days ago" = "twoDaysAgo")),
                             
                             tags$h3("Cases by Country/Territory"),
                             
                             selectInput("sort", "Sort by:",
                                         c("#" = "#",
                                           "Country/Territory" = "Country,Other",
                                           "Total Cases" = "TotalCases",
                                           "New Cases" = "NewCases",
                                           "Total Deaths" = "TotalDeaths",
                                           "New Deaths" = "NewDeaths",
                                           "Total Recovered" = "TotalRecovered",
                                           "New Recovered" = "NewRecovered",
                                           "Active Cases" = "ActiveCases")),
                             
                             selectInput("order", "Order:",
                                         c("Ascending" = "asc",
                                           "Descending" = "dsc")),
                             
                             tags$h3("Download in .csv"),
                             # Input: Choose dataset to download
                             selectInput("dataset", "Choose a dataset:",
                                         choices = c("Global Totals (Complete)" = "globalTotals",
                                                     "Cases by Country/Territory" = "casesByCountry")),
                             
                             # Refresh button
                             actionButton(inputId = "rfBtn",
                                          label = "Refresh",
                                          icon = icon("sync-alt")),
                             # Download button
                             downloadButton(outputId = "downloadData",
                                            label = "Download",
                                            icon = icon("cloud-download-alt")),

                             
                             # Auto refresh checkbox
                             checkboxInput("autoRf", "Auto refresh (every hour)", T),
                             
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
                             # mainPanel(
                             #   plotOutput(outputId = "histPlot")
                             # )
                           ), # sidebarPanel
                           
                           mainPanel(
                             
                             # style = "margin-left:-23em",
                             
                             # h1("COVID-19 Update Summary"),
                             h1(textOutput("txtOut1")),
                             
                             h2("Global Totals"),
                      
                             h4("On the day"),
                             tableOutput("tableOut1"),
                             
                             h4("Overall"),
                             tableOutput("tableOut2"),
                             h4("Per Million"),
                             tableOutput("tableOut3"),
                             
                             h2("Cases by Country/Territory"),
                             tableOutput("tableOut4"),
                             #verbatimTextOutput("txtOut")
                             
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  
                  tabPanel("JHUCSSE", "This panel is intentionally left blank"),
                  tabPanel("Navbar 3", "This panel is intentionally left blank"),
                  
                  
                ), # navbarPage

) # fluidPage