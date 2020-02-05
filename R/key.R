
#' doc_type
#' @description Type a (series of) text on your keyboard
#' @param container specify the container you wish to perform the action in
#' @param message specify which text should be typed
#' @param interval #TODO: what is this?
#' 
#' @export
doc_type <- function(container, message, interval = NULL){
  container <- dockeR::check_container_name(container)
  message <- nullify(message, "message = \'", "\', ")
  interval <- nullify(interval, "interval = ", ", ")
  dockeR::doc_exec(container, glue::glue("python -c \"from pyautogui import * ; typewrite({message} {interval})\""))
  return(invisible(container))
}

#' doc_press
#' @description Press a key on your keyboard
#' @param container specify the container you wish to perform the action in
#' @param key press a key
#' 
#' @export
doc_press <- function (container, key) {
  container <- dockeR::check_container_name(container)
  dockeR::doc_exec(container, glue::glue("python -c \"from pyautogui import * ; press('{key}' )\""))
  return(invisible(container))
}

#' doc_hot_keys
#' @description Press a hot key on your keyboard
#' @param container specify the container you wish to perform the action in
#' @param key press a key
#' @param interval #TODO: what is this?
#' 
#' @export
doc_hot_keys <- function (container, key, interval = NULL){
  container <- dockeR::check_container_name(container)
  dockeR::doc_exec(container, glue::glue("python -c \"from pyautogui import * ; hotkey('{key}')\""))
  return(invisible(container))
}

#' hot_keys
#' @description list of hotkeys
#' @export
hot_keys <- list('\t', '\n', '\r', ' ', '!', '"', '#', '$', '%', '&', "'", '(',
                    ')', '*', '+', ',', '-', '.', '/', '0', '1', '2', '3', '4', '5', '6', '7',
                    '8', '9', ':', ';', '<', '=', '>', '?', '@', '[', '\\', ']', '^', '_', '`',
                    'a', 'b', 'c', 'd', 'e','f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o',
                    'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '{', '|', '}', '~',
                    'accept', 'add', 'alt', 'altleft', 'altright', 'apps', 'backspace',
                    'browserback', 'browserfavorites', 'browserforward', 'browserhome',
                    'browserrefresh', 'browsersearch', 'browserstop', 'capslock', 'clear',
                    'convert', 'ctrl', 'ctrlleft', 'ctrlright', 'decimal', 'del', 'delete',
                    'divide', 'down', 'end', 'enter', 'esc', 'escape', 'execute', 'f1', 'f10',
                    'f11', 'f12', 'f13', 'f14', 'f15', 'f16', 'f17', 'f18', 'f19', 'f2', 'f20',
                    'f21', 'f22', 'f23', 'f24', 'f3', 'f4', 'f5', 'f6', 'f7', 'f8', 'f9',
                    'final', 'fn', 'hanguel', 'hangul', 'hanja', 'help', 'home', 'insert', 'junja',
                    'kana', 'kanji', 'launchapp1', 'launchapp2', 'launchmail',
                    'launchmediaselect', 'left', 'modechange', 'multiply', 'nexttrack',
                    'nonconvert', 'num0', 'num1', 'num2', 'num3', 'num4', 'num5', 'num6',
                    'num7', 'num8', 'num9', 'numlock', 'pagedown', 'pageup', 'pause', 'pgdn',
                    'pgup', 'playpause', 'prevtrack', 'print', 'printscreen', 'prntscrn',
                    'prtsc', 'prtscr', 'return', 'right', 'scrolllock', 'select', 'separator',
                    'shift', 'shiftleft', 'shiftright', 'sleep', 'space', 'stop', 'subtract', 'tab',
                    'up', 'volumedown', 'volumemute', 'volumeup', 'win', 'winleft', 'winright', 'yen',
                    'command', 'option', 'optionleft', 'optionright') %>%
  purrr::set_names(.)


#' doc_key_up
#' @export
doc_key_up <- function (container, key){
  container <- dockeR::check_container_name(container)
  dockeR::doc_exec(container, glue::glue("python -c \"from pyautogui import * ; keyUp('{key}')\""))
  return(invisible(container))
}

#' doc_key_down
#' @export
doc_key_down <- function (container, key){
  container <- dockeR::check_container_name(container)
  dockeR::doc_exec(container, glue::glue("python -c \"from pyautogui import * ; keyDown('{key}')\""))
  return(invisible(container))
}

#' doc_press_tabs
#' @description Send several tabs (simplifies going through a website)
#' @param container specify the container you wish to perform action in
#' @param n how often should the tab button be clicked
#' 
#' @export
doc_press_tabs <- function(container, n) {
  
  container <- dockeR::check_container_name(container)
  
  1:n %>% 
    purrr::walk(~{doc_hot_keys(container, hot_keys$tab)})
  
  return(invisible(container))
  
}