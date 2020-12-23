library(data.table)

## DEVELOPMENT ----
# # TEMP: remove todor, when building package
# library(todor)
# todor()
#
# # TEMP: for testing purposes only
# test <- list(val1=1,val2=1:12,c(12,2,3,4))
# test1 = list(lstOflst = list(lstInner = list(1:3,3:5,5:6,list(1,2),ts=list(asi=1:4))),lst=list(1,2,3,4),vec=c(1,2,3,4),vec2=1:19,single=5,list(5,3,2,1))
#
# test2 <- data.table::data.table(test=list(l1.1=c(1,2,3,4),l1.2=list(l21=1,l22=2,l23=3),l1.3=4),list(1:4))
# test3 <- data.table::data.table(iris)

# TODO: documentation (roxygen)

# Package ----
# NOTE: assumes list, not a data.frame or data.table (even though they use lists internaly)
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

prepare.json <- function(json){
  return(paste0('{',prepare.elements(json),'}',collapse=','))
}

# TODO: handle data.frames/data.tables. is.data.frame/is.data.table
write.json <- function(to_json,file = 'new_file.json', url = ''){
  if(!is.data.frame(to_json)){
    json <- prepare.json(json = to_json)
    data.table::fwrite(x = list(json),file = file)
  }
}
