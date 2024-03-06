## Published App
https://kysterics.shinyapps.io/covid/

## Description
### Overview
The shiny app brings an update summary of covid cases, both globally and regionally. It provides the relevant information by use of two tables — `Global Totals` and `Cases by Country/Territory`. Users can configure the displayed data according to their liking.

### Configuration Panel

```{r shiny1, echo= FALSE, fig.align = 'center', out.width="35%", fig.cap="Unexpanded configuration panel in full"}
knitr::include_graphics("../png/config_panel.png")
```

The configuration panel consists of three sections: `Global Totals`, `Cases by Country/Territory` and `Download in .csv`. Users have 3 options for the day of the data: `Today`, `Yesterday` and `Two days ago` for each of the tables. For the detailed table at the bottom, users can sort it by columns in an ascending or descending order.

Once any configuration is selected, the dataset will update automatically. By default, the data on screen will be updated every hour but users have the option to disable it. Users can also update the datasets manually using the `Refresh` button. For confirmation purposes, the last refreshed time will be displayed at the bottom of the configuration panel.

\vspace{1cm}

```{r shiny2, echo= FALSE, fig.align = 'center', out.width="90%", fig.cap="Example of displayed information"}
knitr::include_graphics("../png/summary_example.png")
```

\vspace{1cm}


Finally, users can download both datasets displayed in `.csv` using the `Download` button. Note that the numbers in the app are displayed with commas for clarity but all numbers available in the downloaded file will be numeric. Also, the table for `Global Totals` is split and reduced for better presentation. All available data can be obtained from the download.

### Data Source
It uses the API from https://disease.sh/ to obtain the data for `Global Totals` and webscrapes https://www.worldometers.info/coronavirus/#main_table directly for `Cases by Country/Territory`.

