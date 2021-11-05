# Define UI
ui <- fluidPage(theme = shinytheme("slate"),
                tags$head(
                  tags$link(rel = "stylesheet", type = "text/css", href = "style.css")
                ),
                navbarPage(
                  
                  "Data Source",
                  
                  tabPanel("Worldometers",

                           sidebarPanel(
                             
                             tags$h3("Global Totals"),
                             
                             selectInput("dayGlobal", "Day:",
                                         # queries for API
                                         c("Today" = "allowNull",
                                           "Yesterday" = "yesterday",
                                           "Two days ago" = "twoDaysAgo")),
                             
                             tags$h3("Cases by Country/Territory"),
                             
                             selectInput("dayCountry", "Day:",
                                         # queries for API
                                         c("Today" = "today",
                                           "Yesterday" = "yesterday",
                                           "Two days ago" = "yesterday2")),
                             
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
                             verbatimTextOutput("txtOut")
                             
                           ), # sidebarPanel
                           
                           mainPanel(

                             h1(textOutput("txtOut1")),
                             
                             h2("Global Totals"),
                      
                             h4("On the day"),
                             tableOutput("tableOut1"),
                             
                             h4("Overall"),
                             tableOutput("tableOut2"),
                             h4("Per Million"),
                             tableOutput("tableOut3"),
                             
                             h2(textOutput("txtOut2")),
                             tableOutput("tableOut4"),
                             
                           ) # mainPanel
                           
                  ), # Navbar 1, tabPanel
                  
                  tabPanel("JHUCSSE", "This panel is intentionally left blank"),
                  tabPanel("Navbar 3", "This panel is intentionally left blank"),
                  
                  
                ), # navbarPage

) # fluidPage