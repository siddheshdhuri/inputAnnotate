
#' inserts html tags into a string
#'
#' @export
#' @examples
#' string = "Hello World"
#' insertions <- c("<b>" = 3, "</b>" = 6)
#' apply_insertions(string, insertions)
apply_insertions <- function(string, insertions, tags.df){
  if (length(insertions)==0){
    return(string)
  }

  insertions <- ifelse(insertions>nchar(string), nchar(string), insertions)

  stopifnot(all(insertions>=0))
  stopifnot(all(insertions<=nchar(string)))

  insertions <- sort(insertions)
  insertions <- c(0, insertions, nchar(string))

  newString <- ""
  for (i in 2:length(insertions)){
    start <- ifelse(i==1,0,insertions[i-1]+1)
    end <- insertions[i]
    tagname <- names(insertions)[i]

    tagname <- trim_tag(tagname)

    if(grepl("/",tagname, fixed=T)){
      child.tag <- substr(string, start, end)
      matches <- grepl(child.tag, tags.df$child, ignore.case = TRUE)
      number <- tags.df[matches,]$parent.number

      tagname <- paste0(tagname,"<sup>",number,"</sup>")
    }

    newString <- paste0(newString, substr(string, start, end), tagname)
  }
  return(newString)
}


#' removes html tags from strings
#'
#' @param string input string
#' @param pattern pattern for removal
#'
#' @export
#' @examples
#' remove_tags("hello <b>world</b>")
remove_tags <- function(string, pattern = "<[^(<|>)]*>"){

  gsub(pattern, "", string)

}

#' Trims a tag surrounded by text to only tag
#'
#' @param string input string containing tag and possibly other characters eg: 3e</b>gg
#'
#' @export
#' @examples
#' trim_tag("hello <b> world")
trim_tag <- function(string){

  tag.start <- stringr::str_locate(string,"<")[[1]]
  tag.end <- regexpr(">[^>]*$", string)[1]

  tagname <- substr(string,tag.start,tag.end)

  return(tagname)

}


#' inserts html tags into a string for a data.tree
#'
#' @export
#' @examples
#' string = "Hello World"
#' insertions <- c("<b>" = 3, "</b>" = 6)
#' insert_tags(string, insertions)
insert_tags <- function(string, insertions){
  if (length(insertions)==0){
    return(string)
  }

  insertions <- ifelse(insertions>nchar(string), nchar(string), insertions)

  stopifnot(all(insertions>=0))
  stopifnot(all(insertions<=nchar(string)))

  insertions <- sort(insertions)
  insertions <- c(0, insertions, nchar(string))

  newString <- ""
  for (i in 2:length(insertions)){
    start <- ifelse(i==1,0,insertions[i-1]+1)
    end <- insertions[i]
    tagname <- names(insertions)[i]

    tagname <- trim_tag(tagname)

#     if(grepl("/",tagname, fixed=T)){
#       child.tag <- substr(string, start, end)
#       matches <- grepl(child.tag, tags.df$child, ignore.case = TRUE)
#       number <- tags.df[matches,]$parent.number
#
#       tagname <- paste0(tagname,"<sup>",number,"</sup>")
#     }

    newString <- paste0(newString, substr(string, start, end), tagname)
  }
  return(newString)
}

