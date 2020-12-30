#' Read json in as list
#'
#' Read in a json file and parse it into a R list.
#' @param file the name of the file, where the json is read from.
#' @export
read.json <- function(file = ''){
  tryCatch({
    file_content <- readChar(file,file.info(file)$size)
    file_content <- gsub(pattern = '{',replacement = 'list(',x = file_content,fixed = T)
    file_content <- gsub(pattern = '[',replacement = 'c(',x = file_content,fixed = T)
    file_content <- gsub(pattern = ':',replacement = '=',x = file_content,fixed = T)
    file_content <- gsub(pattern = ']|}',replacement = ')',x = file_content)
    file_content <- gsub(pattern = '[f,F]alse',replacement = 'FALSE',x = file_content)
    file_content <- gsub(pattern = '[t,T]rue',replacement = 'TRUE',x = file_content)
    file_content <- eval(parse(text = file_content))
    return(file_content)
  },error = function(err){
    print(err)
    print('Given json file has incorrect format! Check that all keys are quoted and no empty values exist in json.')
  })
}
