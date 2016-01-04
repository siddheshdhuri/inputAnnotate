library(inputAnnotate)

shinyUI(fluidPage(
  titlePanel("Selectable example"),

  fluidRow(
    column(4, wellPanel(
      inputAnnotate("selectable1", value = HTML("Hello <b>World</b>")),
      tags$br(),
      inputAnnotate("selectable2", value = HTML("Hello <span>World</span>"))
    )),
    column(8, wellPanel(
      verbatimTextOutput("outputText")
    ))
  )
))
