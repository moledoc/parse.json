#' Read json in as a list
#'
#' Read in a json file and parse it into a R list. If both parameters (file,url) are provided, then url value is used.
#' @param file the name of the file, where the json is read from.
#' @param url the url of the json to read.
#' @importFrom utils download.file
#' @export
#' @examples
#' read.json('examples/example_json_self.json') # Reads in an example json as list from examples/.
#' read.json('examples/example_json_self_written.json') # Reads in an example json as list from examples/.
#' read.json('examples/dnd_example.json') # Reads in an example json as list from examples/.
#' read.json(url = 'https://www.dnd5eapi.co/api/spells/acid-arrow/' ) # Reads in json from given url as list.
read.json <- function(file = '', url = ''){
  tryCatch({
    if (url != '') {
      file <- tempfile()
      download.file(url = url, destfile = file)
    }
    file_content <- readChar(file, file.info(file)$size)
    file_content <- gsub(pattern = '{', replacement = 'list(', x = file_content,fixed = T)
    file_content <- gsub(pattern = '[', replacement = 'c(', x = file_content,fixed = T)
    file_content <- gsub(pattern = ':', replacement = '=', x = file_content,fixed = T)
    file_content <- gsub(pattern = ']|}', replacement = ')', x = file_content)
    file_content <- gsub(pattern = '[f,F]alse', replacement = 'FALSE', x = file_content)
    file_content <- gsub(pattern = '[t,T]rue', replacement = 'TRUE', x = file_content)
    file_content <- eval(parse(text = file_content))
    # if json file contained quotes, then we need to eval file_content again.
    if (typeof(file_content) == 'character') {
      file_content <- eval(parse(text = file_content))
    }
    return(file_content)
  },error = function(err){
    print(err)
    print('Given json file has incorrect format! Check that all keys are quoted and no empty values exist in json.')
  })
}
