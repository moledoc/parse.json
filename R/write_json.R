# Dependencies ----
library(data.table)

# Package ----
#' Prepare json elements
#'
#' Get and format all the elements in the list into a json format.
#' It takes in a list and for each element produces the json format of that element.
#' @param json list which elements are parsed into json format.
#' @return Returns json format of each element in the list.
prepare.elements <- function(json){
  dt <- data.table::data.table(keys=names(json),values=json,check.names = T)
  elements<-apply(dt,1,function(x){
    if(typeof(x$values) != 'list'){
      return(paste0(x$keys,':[',paste0(x$values,collapse=','),']'))
    } else{
      return(paste0(x$keys,':{',paste0(prepare.elements(x$values),collapse=','),'}'))
    }
  })
  return(elements)
}

#' Put together the final json
#'
#' Take list elements, that have been parsed into json format and combine them into single json element.
#' @param json list that is to be parsed into json.
prepare.json <- function(json){
  return(paste0('{',paste0(prepare.elements(json),collapse=','),'}',collapse=','))
}

#' Write list as json
#'
#' Write given list to given file in json format. Even though data.table and data.frame use lists, then these structures are not supported and strictly lists must be used.
#' @param to_json list that is to be written out as json.
#' @param file the name of the file, where the json is written. By default it is written in the working directory as 'new_file.json'
#' @export
write.json <- function(to_json,file = 'new_file.json'){
  tryCatch({
    json <- prepare.json(json = to_json)
    data.table::fwrite(x = list(json),file = file)
  },error = function(err){
    print(err)
    print('data.frames and data.tables are not supported, use strictly lists!')
  })
}
