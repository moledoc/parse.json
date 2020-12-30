#' Prepare json elements
#'
#' Get and format all the elements in the list into a json format.
#' It takes in a list and for each element produces the json format of that element.
#' @param json list which elements are parsed into json format.
#' @return Returns json format of each element in the list.
prepare.elements <- function(json,depth=1){
  # Make list into data table, where one column is keys and other values.
  dt <- data.table::data.table(keys = names(json), values = json,check.names = T)
  # If list element does not have key, then generate keys.
  if (is.null(names(json))) {
    dt$keys <- paste0('V', depth ,'.', 1:nrow(dt))
  }else if (length(dt[keys == '',values]) > 0) {
    dt[keys == '','keys'] <- paste0('V', depth, '.', 1:length(dt[keys == '',values]))
  }
  elements <- apply(dt, 1, function(row){
    # If value is data.frame, make it into a list, so it can be parsed.
    if (is.data.frame(row$values)) {
      row$values <- data.table::data.table(as.matrix(row$values),stringsAsFactors = F)
      row$values <- as.list(row$values)
    }
    # If value is not list, then
    # parse value, depending on whether it is a vector or a single value.
    # Also, handle string values differently by adding quotes.
    if (typeof(row$values) != 'list') {
      if (typeof(row$values) == 'logical') {
        row$values <- tolower(as.character(row$values))
      }
      if (length(row$values) > 1) {
        if (typeof(row$values) == 'character') {
          return(paste0('\"', row$keys, '\"', ':[\"', paste0(row$values, collapse = '\",\"'),'\"]'))
        } else {
          return(paste0('\"', row$keys, '\"', ':[', paste0(row$values, collapse = ','),']'))
        }
      } else {
        if (typeof(row$values) == 'character') {
          return(paste0('\"', row$keys, '\"', ':\"', row$values,'\"'))
        } else {
          return(paste0('\"', row$keys, '\"', ':', row$values))
        }
      }
    } else{
      # If value is list, then parse inner list.
      return(paste0("\"", row$keys, "\"", ':{', paste0(prepare.elements(row$values, depth + 1), collapse = ','), '}'))
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
#' Write given list to given file in json format. Structures such as data.frame and data.table work also.
#' @param to_json list that is to be written out as json.
#' @param file the name of the file, where the json is written. By default it is written in the current working directory as 'new_file.json'.
#' @export
#' @examples
#' write.json(lst) # The argument value of lst is in examples/example_list.txt.
write.json <- function(to_json,file = 'new_file.json'){
  tryCatch({
    if (is.data.frame(to_json)) {
      to_json <- data.table::data.table(as.matrix(to_json),stringsAsFactors = F)
    }
    json <- prepare.json(json = as.list(to_json))
    data.table::fwrite(x = list(json), file = file, quote = FALSE)
  },error = function(err){
    print(err)
    #print('vectors, data.frames and data.tables are not supported, use strictly lists!')
  })
}
