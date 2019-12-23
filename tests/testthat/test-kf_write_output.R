test_that("File is saved and returned", {
  mock_file <- tempfile()
  table_name <- "model_predictions"
  saved_output <- kf_write_output(table_name, mock_file)

  expect_equivalent(mock_file, saved_output)
  expect_true(file.exists(mock_file))
})

test_that("Correct method is used for kflow_meta class", {
  mock_file <- tempfile()
  test_metrics <- kf_init_metrics() %>% kf_add_metric("roc", .5, "RAW")

  output <- kf_write_output(test_metrics, mock_file)

  expect_true(file.exists(output))
  expect_is(jsonlite::read_json(output), "list")
})
