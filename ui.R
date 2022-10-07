
# -------------------------------------------------------------------------

shinyUI(
  dashboardPage(
    dashboardHeader(title = "Market Area Creator"),
    dashboardSidebar(
      sidebarMenu(
        poi_type,
        conditionalPanel("input.poi_type == 'Coordinates'", poi_latitude, poi_longitude),
        conditionalPanel("input.poi_type == 'Address'", poi_address),
        range_type,
        conditionalPanel("input.range_type == 'Time'", time_input),
        conditionalPanel("input.range_type == 'Distance'", distance_input),
        div(time_of_departure, align = "center", width = "100%"),
        actionButton("go", "Create Service Area", width = "90%", icon = icon("paper-plane"),
                     style="color: #fff; background-color: #337ab7; border-color: #2e6da4"))
    ),
    dashboardBody(
      # File-based CSS for custom styles saved in www folder
      tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "rdn_theme.css")),
      conditionalPanel(
        "input.go == 0",
        fluidRow(
          column(width = 5,
                 box(title = "Welcome!", width = 12, status = "primary",
                     p("Use settings on the left to create a market area.")))
        )
      ),
      conditionalPanel(
        "input.go > 0",
        fluidRow(
          column(
            width = 12,
            tabBox(
              width = 12,
              tabPanel(
                "Market Area Creator",
                div(tmapOutput("map") %>% withSpinner(type = 6), align = "center"))))
        ),
        fluidRow(
          column(
            width = 12,
            tabBox(
              width = 12,
              tabPanel(
                "Downloads",
                downloadButton('download_zip_list', 'Download zipcodes as CSV'),
                downloadButton('download_zip_shp', 'Download zipcodes as GeoJSON'),
                downloadButton('download_isoline_shp', 'Download isoline as GeoJSON'))))
        )
      )
    )
  )
) 

