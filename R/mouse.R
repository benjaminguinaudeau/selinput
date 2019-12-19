#' doc_init_pyautogui
#' @export
doc_init_pyautogui <- function(container){
  dockeR::doc_exec(container, "sudo apt-get update")
  dockeR::doc_exec(container, "sudo apt-get install -y python-pip")
  dockeR::doc_exec(container, "python -m pip install pyautogui")
  dockeR::doc_exec(container, "sudo apt-get install -y python-tk python-dev")
  dockeR::doc_exec(container, "sudo apt-get install -y scrot")
}

#' doc_mouse_position
#' @export
doc_mouse_position <- function(){
  pos <- dockeR::doc_exec("chrome", "python -c 'from pyautogui import * ; print(position())'", intern = T)
  x <- stringr::str_extract(pos, "(?<=x=)\\d+")
  y <- stringr::str_extract(pos, "(?<=y=)\\d+")
  return(tibble::tibble(x, y))
}


#' doc_mouse_moveTo
#' @export
doc_mouse_move_to <- function(x, y){

  if(!is.null(x)){
    x <- sample(x, 1)
  }
  if(!is.null(y)){
    y <- sample(y, 1)
  }
  dockeR::doc_exec("chrome", glue::glue("python -c 'from pyautogui import * ; moveTo({x}, {y})'"), intern = T)
}

#' doc_mouse_move
#' @export
doc_mouse_move <- function(x, y){
  if(!is.null(x)){
    x <- sample(x, 1)
  }
  if(!is.null(y)){
    y <- sample(y, 1)
  }

  dockeR::doc_exec("chrome", glue::glue("python -c 'from pyautogui import * ; move({x}, {y})'"), intern = T)
}

#' get_absolute_location
#' @export
get_absolute_location <- function(chrome, elem){
  off <- chrome %>% dockeR::execute('return window.outerHeight - window.innerHeight;')
  pos <- elem %>% get_location()
  abs_x = pos$x + 9 + pos$width/2
  abs_y = pos$y + as.numeric(off) + 5 + pos$height/2
  return(list(x = as.character(abs_x), y = as.character(abs_y)))
}

#' doc_mouse_click
#' @export
doc_click <- function(x = NULL, y = NULL, button = "left"){
  pos <- doc_mouse_position()
  if(!is.null(x)){
    x <- sample(x, 1)
  } else {
    x <- pos$x
  }
  if(!is.null(y)){
    y <- sample(y, 1)
  }else {
    y <- pos$y
  }

  x <- nullify(x, "x = ", ", ")
  y <- nullify(y, "y = ", ", ")

  dockeR::doc_exec("chrome", glue::glue("python -c 'from pyautogui import * ; click({x}{y}button = \"{button}\")'"))
}


#' doc_scroll
#' @export
doc_scroll <- function(x){
  dockeR::doc_exec("chrome", glue::glue("python -c \"from pyautogui import * ; scroll({x})\""))
}



# doc_mouse_display <- function(message, interval = NULL){
#   doc_exec("chrome", glue::glue("sudo python -c \"from pyautogui import * ; displayMousePosition()\""))
# }




