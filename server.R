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

# Osnovna funkcija serverske logike
shinyServer(function(input, output, session) {
  observeEvent(
    input$render, {
      pcaList <- performTeamPCA(getInternalData())
      session$sendCustomMessage(type="jsondata", toJSON(pcaList$scores))
      session$sendCustomMessage(type="jsoninfo", toJSON(pcaList$pcainfo))
    }
  )
})
