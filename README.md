
<!-- README.md is generated from README.Rmd. Please edit that file -->

# selinput <img src="man/figures/selinput_logo.jpeg" width="160px" align="right" />

[![](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://www.tidyverse.org/lifecycle/#experimental)
[![](https://img.shields.io/github/languages/code-size/benjaminguinaudeau/tidyweb.svg)](https://github.com/benjaminguinaudeau/tidyweb)
[![](https://img.shields.io/github/last-commit/benjaminguinaudeau/tidyweb.svg)](https://github.com/benjaminguinaudeau/tidyweb/commits/master)

# selinput

<!-- badges: start -->

<!-- badges: end -->

Selinput is a wrapper for the python API pyautogui, which allows to
simulate input from a real mouse and keyboard in a Docker container.

# Installation

``` r
devtools::install_github("benjaminguinaudeau/selinput")
```

``` r
library(selinput)
```

# Usage

Get a few more libraries

``` r
#devtools::install_github("benjaminguinaudeau/tidyweb")

pacman::p_load(tidyverse, selinput, dockeR, tidyselenium)
```

Start a container and a browser

``` r
# First Container
chrome_container <- docker$new(
  image_src = "selenium/standalone-chrome-debug", #Image to be used (model for the container)
  container_name = "chrome",
  other_arguments = "-p 4446:4444 -p 4447:5900"
  
  # Name you want to use
)
```

``` r
chrome <- tidyselenium::get_driver(4446)

chrome$open()
```

If you don’t have `pyautoguy` installed yet, run the following:

``` r
selinput::doc_init_pyautogui(chrome)
```

This should return `TRUE`

``` r
selinput::is_pyautogui_installed(chrome)
```

Get a screenshot (currently broken?)

``` r
chrome %>% 
  go("https://news.google.com/") %>% 
  selinput::doc_screenshot(file = "screenie.png")
```

List of hotkeys that can be pressed:

``` r

hot_keys %>% sample(10) %>% glimpse

## press tab
chrome %>%  
  selinput::doc_hot_keys(key = hot_keys$tab)

## press enter
chrome %>%  
  selinput::doc_hot_keys(key = hot_keys$enter)
```

Type on keyboard:

``` r
## Type on Keyboard
chrome %>%  
  selinput::doc_type(key = "Hello! My name is Fitzgerald.")
```

## Thanks

A huge thank you to [Favstats](https://github.com/favstats) for
designing each of the hex-stickers.
