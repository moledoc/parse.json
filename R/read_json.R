#' Read json in as list
#'
#' Read in a json file and parse it into a R list.
#' @param file the name of the file, where the json is read from.
#' @export
read.json <- function(file = ''){
  # TODO: this function
  fileContent <- readChar(file,file.info(file)$size)

  fileContent <- gsub(pattern = '{',replacement = 'list(',x = fileContent,fixed = T)
  fileContent <- gsub(pattern = '[',replacement = 'c(',x = fileContent,fixed = T)
  fileContent <- gsub(pattern = ':',replacement = '=',x = fileContent,fixed = T)
  fileContent <- gsub(pattern = ']|}',replacement = ')',x = fileContent)
  fileContent <- gsub(pattern = '\n|\t|\ \ ',replacement = ' ',x = fileContent)
  fileContent <- gsub(pattern = '[f,F]alse',replacement = 'FALSE',x = fileContent)
  fileContent <- gsub(pattern = '[t,T]rue',replacement = 'TRUE',x = fileContent)
  # print(fileContent)
  fileContent <- eval(parse(text = fileContent))
  print(fileContent)
}

# TODO: -----
# * if key is a number and unquoted, then the function gives an error.
# * if last element ends with comma, it gives error (because no element)
