#
# ui.R sadrzi definiciju korisnickog interfejsa Shiny aplikacije (slicno kao index.html).
# Aplikacija se moze pokrenuti klikom na 'Run App'.
#
# Saznajte vise o Shiny aplikacijama na:
#
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  #HTML zaglavlje stranice
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
  
  #Naslovna traka
  titlePanel(div(
    img(
      width = 60,
      src = "StreamLogo.png"
    ),
    tags$span("NBA stream"),
    tags$span(style = "font-size: 0.6em; font-variant: small-caps", 
              "analiza glavnih komponenti performansi NBA timova")
  )),
  hr(),
  
  # Vizuelizacija
  fluidRow(
    column(8, style = "padding-right: 1px",
           wellPanel(
             style = "margin-bottom: 2px;",
             div(class = "chartUIholder",
                 tags$canvas(id = "chartUI"))
           )),
    column(4, style = "padding-left: 1px",
           wellPanel(
             style = "margin-bottom: 2px;",
             div(class = "chartUIholder",
                 tags$canvas(id = "radarUI"))
           ))
  ),
  
  # Kontrole
  fluidRow(column(
    12,
    wellPanel(
      class = "row",
      style = "margin-left: 0px; margin-right: 0px; margin-bottom: 0;",
      column(2,
             uiOutput("first_pc", class = "form-horizontal")),
      column(2,
             uiOutput("second_pc", class = "form-horizontal")),
      column(
        6,
        style = "line-height: 2.3",
        radioButtons(
          "stats",
          label = "Odabir tipa performansi",
          choices = list("Tim" = 1, "Protivnik" = 2),
          selected = 1,
          inline = TRUE
        )
      )
    )
  ))
  
))
