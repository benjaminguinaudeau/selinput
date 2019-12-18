#' doc_locate_on_screen
#' @export
doc_locate_on_screen <- function(x){
  doc_screenshot(file = "'/screen.png'")
  out <- dockeR::doc_exec("chrome", glue::glue("sudo python -c \"import pyautogui as p ; p.locate('/elem.png', '/screen.png')\""), intern = T)

  x <- stringr::str_extract(out, "(?<=x=)\\d+")
  y <- stringr::str_extract(out, "(?<=y=)\\d+")
  return(tibble::tibble(x, y))
}

#' doc_screenshot
#' @export
doc_screenshot <- function(file = NULL, region = NULL){
  file <- nullify(file, "imageFilename = ")
  region <- nullify(region, "region = ")
  dockeR::doc_exec("chrome", glue::glue("sudo python -c \"from pyautogui import * ; screenshot({file} {region})\""))
}
