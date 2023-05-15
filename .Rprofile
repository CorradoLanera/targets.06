source("renv/activate.R")

if (interactive()) {

  .attach_pkg <- function(pkg) {
    suppressPackageStartupMessages(suppressWarnings(
      library(pkg, character.only = TRUE)
    ))
    usethis::ui_done("Package {usethis::ui_value(pkg)} attached.")
  }

  .attach_pkg("devtools")
  .attach_pkg("checkmate")
  .attach_pkg("testthat")
  .attach_pkg("targets")
  .attach_pkg("tarchetypes")
}
