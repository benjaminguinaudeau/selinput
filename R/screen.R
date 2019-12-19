#' doc_locate_on_screen
#' @export
doc_locate_on_screen <- function(container, x){
  container <- dockeR::check_container_name(container)
  
  doc_screenshot(file = "'/screen.png'")
  out <- dockeR::doc_exec(container, glue::glue("sudo python -c \"import pyautogui as p ; p.locate('/elem.png', '/screen.png')\""), intern = T)

  x <- stringr::str_extract(out, "(?<=x=)\\d+")
  y <- stringr::str_extract(out, "(?<=y=)\\d+")
  return(tibble::tibble(x, y))
}

#' doc_screenshot
#' @export
doc_screenshot <- function(container, file = NULL, region = NULL){
  container <- dockeR::check_container_name(container)
  
  file <- nullify(file, "imageFilename = ")
  region <- nullify(region, "region = ")
  dockeR::doc_exec(container, glue::glue("sudo python -c \"from pyautogui import * ; screenshot({file} {region})\""))
}
