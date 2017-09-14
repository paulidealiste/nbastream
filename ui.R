#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "nbastream.css"),
    tags$link(rel = "stylesheet", type = "text/css", href = "bootstrap.css"),
    tags$script(src = "https://code.jquery.com/jquery-3.2.1.js"),
    tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/lodash.js/4.17.4/lodash.js"),
    tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.bundle.js"),
    tags$script(src = "scatterChartConfig.js"),
    tags$script(src = "radarChartConfig.js"),
    tags$script(src = "chartUI.js")
  ),
  
  titlePanel('NBA Stream'),
  hr(),
  
  # Vizuelizacija
  fluidRow(
    column(8, style = "padding-right: 1px",
           wellPanel(
             div(class = "chartUIholder",
                 tags$canvas(id = "chartUI"))
           )),
    column(4, style = "padding-left: 1px",
           wellPanel(
             div(class = "chartUIholder",
                 tags$canvas(id = "radarUI"))
           ))
  ),
  
  # Kontrole
  fluidRow(column(12,
                  wellPanel(class = "row", style = "margin-left: 0px; margin-right: 0px",
                    column(2,
                           uiOutput("first_pc", class = "form-horizontal")
                    ),
                    column(2,
                           uiOutput("second_pc", class = "form-horizontal")
                    ),
                    column(6, style = "line-height: 2.3",
                           radioButtons("radio", label = "Odabir performansi",
                                        choices = list("Tim" = 1, "Protivnik" = 2), 
                                        selected = 1, inline = TRUE)
                    )
                  )))
  
))
