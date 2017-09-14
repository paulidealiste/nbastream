#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
library(shiny)
library(jsonlite)
source("engine.R")

# Osnovna funkcija serverske logike
shinyServer(function(input, output, session) {
  
  # Reaktivne promenljive
  
  extractNum <- function(str) { return (as.numeric(gsub("[[:alpha:]]", "", str))) }
  
  pcaList <- reactive({
    performTeamPCA(getInternalData(), data.frame(fpc = extractNum(input$first_pc), spc = extractNum(input$second_pc)))
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
                c("PC1", "PC2", "PC3", "PC4", "PC5"),
                selected = "PC1")
  )
  output$second_pc <- renderUI(
    selectInput("second_pc", "Druga osa", 
                c("PC1", "PC2", "PC3", "PC4", "PC5"),
                selected = "PC2")
  )
  
})
