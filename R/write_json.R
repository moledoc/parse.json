# Dependencies ----
library(data.table)

# Package ----
#' Prepare json elements
#'
#' Get and format all the elements in the list into a json format.
#' It takes in a list and for each element produces the json format of that element.
#' @param json list which elements are parsed into json format.
#' @return Returns json format of each element in the list.
prepare.elements <- function(json,depth=1){
  dt <- data.table::data.table(keys = names(json), values = json,check.names = T)
  if (is.null(names(json))) {
    dt$keys <- paste0('V', depth ,'.', 1:nrow(dt))
  }else if (length(dt[keys == '',values]) > 0) {
    dt[keys == '','keys'] <- paste0('V', depth, '.', 1:length(dt[keys == '',values]))
  }
  elements <- apply(dt, 1, function(x){
    if (typeof(x$values) != 'list') {
      if (length(x$values) > 1) {
        return(paste0(x$keys, ':[', paste0(x$values, collapse = ','),']'))
      } else {
        return(paste0(x$keys, ':', paste0(x$values, collapse = ',')))
      }
    } else{
      return(paste0(x$keys, ':{', paste0(prepare.elements(x$values, depth + 1), collapse = ','), '}'))
    }
  })
  return(elements)
}

#' Put together the final json
#'
#' Take list elements, that have been parsed into json format and combine them into single json element.
#' @param json list that is to be parsed into json.
#' @return list parsed into a json format.
prepare.json <- function(json){
  return(paste0('{', paste0(prepare.elements(json), collapse = ','), '}', collapse = ','))
}

#' Write list as json
#'
#' Write given list to given file in json format. Even though data.table and data.frame use lists, then these structures are not supported and only lists can be written as json.
#' @param to_json list that is to be written out as json.
#' @param file the name of the file, where the json is written. By default it is written in the current working directory as 'new_file.json'.
#' @export
write.json <- function(to_json,file = 'new_file.json'){
  tryCatch({
    json <- prepare.json(json = to_json)
    data.table::fwrite(x = list(json), file = file)
  },error = function(err){
    print(err)
    print('vectors, data.frames and data.tables are not supported, use strictly lists!')
  })
}
