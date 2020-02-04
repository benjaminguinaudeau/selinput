#' doc_mouse_position
#' @export
doc_mouse_position <- function(container){
  container <- dockeR::check_container_name(container)
  pos <- dockeR::doc_exec(container, "python -c 'from pyautogui import * ; print(position())'", intern = T)
  x <- as.numeric(stringr::str_extract(pos, "(?<=x=)\\d+"))
  y <- as.numeric(stringr::str_extract(pos, "(?<=y=)\\d+"))
  
  return(tibble::tibble(x, y))
}


#' doc_mouse_move_to
#' @export
doc_mouse_move_to <- function(container, x, y){
  container <- dockeR::check_container_name(container)
  if(!is.null(x)){
    x <- sample(x, 1)
  }
  if(!is.null(y)){
    y <- sample(y, 1)
  }
  dockeR::doc_exec(container, glue::glue("python -c 'from pyautogui import * ; moveTo({x}, {y})'"), intern = T)
  return(invisible(container))
}

#' doc_mouse_move
#' @export
doc_mouse_move <- function(container, x, y){
  container <- dockeR::check_container_name(container)
  if(!is.null(x)){
    x <- sample(x, 1)
  }
  if(!is.null(y)){
    y <- sample(y, 1)
  }

  dockeR::doc_exec(container, glue::glue("python -c 'from pyautogui import * ; move({x}, {y})'"), intern = T)

  return(invisible(container))
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

#' doc_click
#' @export
doc_click <- function(container, x = NULL, y = NULL, button = "left"){
  container <- dockeR::check_container_name(container)
  pos <- doc_mouse_position(container)
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

  dockeR::doc_exec(container_name = container, command = glue::glue("python -c 'from pyautogui import * ; click({x}{y}button = \"{button}\")'"))
  return(invisible(container))
}

#' doc_click_pos
#' @export
doc_click_pos <- function(container, x, y, tol_x = 10, tol_y = 10){
  container <- dockeR::check_container_name(container)
  pos <- doc_mouse_position(container) 
  while(abs(x - pos$x) > tol_x | abs(y - pos$y) > tol_y ){
    doc_mouse_move("chrome", x = as.character(x - pos$x), y= as.character(y - pos$y))
    pos <- doc_mouse_position("chrome") %>% dplyr::glimpse()
  }
  doc_click(container = "chrome")
  return(invisible(container))
}

#' doc_scroll
#' @export
doc_scroll <- function(x){
  container <- dockeR::check_container_name(container)
  dockeR::doc_exec(container, glue::glue("python -c \"from pyautogui import * ; scroll({x})\""))
  return(invisible(container))
}



# doc_mouse_display <- function(message, interval = NULL){
#   doc_exec("chrome", glue::glue("sudo python -c \"from pyautogui import * ; displayMousePosition()\""))
# }




