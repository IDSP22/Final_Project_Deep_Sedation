# normal R function to get type of assignment inside of a reactive function
# Saved in a file called R inside the app file

get_type <- function(x){
  # if the assignment is not numeric return discrete 
  if(is.numeric(x) == FALSE){type <- 'discrete'} 
  
  # if the assignment is numeric but has less than 5 unique values return discrete
  else if(length(unique(x))<5){type <- 'discrete'}
  
  # everything else mark continuous
  else{type <- 'continuous'}
  
  
  return(type)
} 
