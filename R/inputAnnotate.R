#' Create an input control that returns the positions of the
#' selected text.
#'
#' @export
inputAnnotate <- function(inputId, value = "") {
  tagList(
    singleton(tags$head(tags$script(src = "inputAnnotate/annotate.js"))),
    tags$div(id = inputId,
             class = "inputAnnotate",
             # type = "div",
             value)
  )
}
