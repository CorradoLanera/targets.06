library(targets)
library(tarchetypes)

tar_option_set(
  packages = c("tibble", "ggplot2"),
  format = "rds"
)

tar_source()

list(
  tar_target(
    name = version,
    command = "1.2"
  ),

  tar_file_read(
    name = penguins_raw,
    command = get_data_raw_path("penguins.csv"),
    read = read_data_raw(!!.x)
  ),

  tar_target(
    name = penguins,
    command = preproc(penguins_raw)
  ),

  tar_target(
    name = gg,
    command = gg_spec_lm(penguins)
  ),

  tar_target(
    name = mod_depth,
    command = lm(body_mass_g ~ culmen_depth_mm, data = penguins)
  ),

  tar_target(
    name = mod_depth_spec,
    command = lm(
      body_mass_g ~ species + culmen_depth_mm,
      data = penguins
    )
  ),

  tar_target(
    name = penguins_ver,
    command = write_data(
      obj = penguins,
      name = "penguins",
      ver = version
    ),
    format = "file"
  ),

  tar_target(
    name = gg_ver,
    command = write_plot(
      gg = gg,
      name = "gg",
      ver = version
    ),
    format = "file"
  ),

  tar_target(
    name = mod_depth_ver,
    command = write_output(
      obj = mod_depth,
      name = "mod_depth",
      ver = version
    ),
    format = "file"
  ),

  tar_target(
    name = mod_depth_spec_ver,
    command = write_output(
      obj = mod_depth_spec,
      name = "mod_depth_spec",
      ver = version),
    format = "file"
  ),

  tar_render(
    name = report,
    path = "report.Rmd"
  )

)
