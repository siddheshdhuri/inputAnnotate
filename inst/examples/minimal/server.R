shinyServer(function(input, output, session) {
  
  output$outputText <- renderText({
    (paste("a: ", paste(as.character(input$selectable1), collapse = ", "),
           "\n\nb: ", paste(as.character(input$selectable2), collapse = ", ")))
  })

})
