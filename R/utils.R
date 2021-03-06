#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr:pipe]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL

#' nullify
#' @export
nullify <- function(x, pre = "x = ", suf = ", "){
  ifelse(is.null(x), " ", paste0(pre, x, suf))
}

#' is_pyautogui_installed
#' @describtion check if pyautogui is installed in a container
#' @param container specify the container you wish to perform the action in
#' @export
is_pyautogui_installed <- function(container){
  container %>%
    dockeR::doc_exec(glue::glue("python -c \"import imp as i ; print(i.find_module('pyautogui'))\""), intern = T) %>%
    stringr::str_detect("packages/pyautogui") %>%
    all
}

#' doc_init_pyautogui
#' @describtion install pyautogui in a container
#' @param container specify the container you wish to perform the action in
#' @export
doc_init_pyautogui <- function(container){
  container_name <- dockeR::check_container_name(container)
  if(!is_pyautogui_installed(container_name)){
    message("Installing pyautogui library")
    dockeR::doc_exec(container_name, "sudo apt-get update")
    dockeR::doc_exec(container_name, "sudo apt-get install -y python3-pip")
    dockeR::doc_exec(container_name, "python3 -m pip install pyautogui")
    dockeR::doc_exec(container_name, "sudo apt-get install -y python3-tk python3-dev")
    dockeR::doc_exec(container_name, "sudo apt-get install -y scrot")
    message("Pyautogui was successfully installed")
  }
  return(invisible(container))
}