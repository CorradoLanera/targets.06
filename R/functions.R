source(here::here("R/utils.R"))




# reader ----------------------------------------------------------
read_data_raw <- function(db_path) {
  readr::read_csv(db_path)
}




# preproc ---------------------------------------------------------
preproc <- function(db_raw) {
  db_raw |>
    janitor::clean_names() |>
    dplyr::select(species, sex, body_mass_g, culmen_depth_mm)
}




# plots

gg_spec_lm <- function(db) {
  db |>
    ggplot(aes(culmen_depth_mm, body_mass_g)) +
    geom_smooth(method = lm, colour = "black", linetype = "dashed") +
    geom_smooth(aes(colour = species), method = lm) +
    geom_point(aes(shape = sex, colour = species)) +
    theme(legend.position = "top")
}



# writers ---------------------------------------------------------
write_obj <- function(obj, name, ver = NULL, dir = "") {
  if (is.null(ver)) {
    ver <- Sys.Date() |>
      stringr::str_remove_all("\\D")
  }
  out_path <- file.path(dir, glue::glue("{name}_{ver}.rds"))

  readr::write_rds(obj, out_path)
  out_path
}

write_output <- function(obj, name, ver = NULL) {
  write_obj(obj, name, ver, dir = get_output_path())
}

write_data <- function(obj, name, ver = NULL) {
  write_obj(obj, name, ver,  dir = get_data_path())
}

write_plot <- function(gg = last_plot(), name, ver = NULL) {
  custom_save <- function(name, gg) {
    ggplot2::ggsave(
      name, gg,
      path = get_output_path(),
      width = 16, height = 9, units = "cm", dpi = "retina", scale = 2
    )
  }

  if (is.null(ver)) {
    ver <- Sys.Date() |>
      stringr::str_remove_all("\\D")
  }

  custom_save(glue::glue("{name}_{ver}.png"), gg)
}
