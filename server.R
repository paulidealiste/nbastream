#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
source("engine.R")
library(shiny)
library(jsonlite)
pcaList <- reactive({})

# Osnovna funkcija serverske logike
shinyServer(function(input, output, session) {
  
  # Reaktivna promenljiva
  
  pcaList <- reactive({
    performTeamPCA(getInternalData())
  })
  
  # Komunikacija sa javascript stranom - osluskivanje event-a izracunavanja PCA 
  
  observeEvent(pcaList(), {
      session$sendCustomMessage(type="jsondata", toJSON(pcaList()$scores))
      session$sendCustomMessage(type="jsoninfo", toJSON(pcaList()$pcainfo))
    }
  )
  
  # renderUI za povezivanje dropdown menija
  
  output$first_pc <- renderUI(
    selectInput("first_pc", "Prva osa",
                pcaList()$pcainfo$pcaNames,
                selected = "PC1")
  )
  output$second_pc <- renderUI(
    selectInput("second_pc", "Druga osa", 
                pcaList()$pcainfo$pcaNames,
                selected = "PC2")
  )
  
  # Osluskivanje promene izabranih komonenti iz dropdown menija
  
  observeEvent(input$first_pc, {
    print('ds')
  })
  
})
