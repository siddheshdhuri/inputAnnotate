.onAttach <- function(...) {

  # Create link to javascript and css files for package
  shiny::addResourcePath("inputAnnotate", system.file("www", package="inputAnnotate"))

}

inputAnnotateDep <- htmltools::htmlDependency("inputAnnotate", packageVersion("inputAnnotate"), src = c("href" = "inputAnnotate"), script = "annotate.js")
