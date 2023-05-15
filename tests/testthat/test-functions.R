test_that("read_data_raw() works", {
  # setup
  db_path <- get_data_raw_path("penguins.csv")

  # eval
  db_raw <- read_data_raw(db_path)

  # test
  expect_tibble(db_raw)
})


test_that("preproc() returns expected number of cols", {
  # setup
  db_raw <- get_data_raw_path("penguins.csv") |>
    read_data_raw()

  # eval
  db <- preproc(db_raw)

  # test
  ncol(db) |> expect_equal(4)
})
