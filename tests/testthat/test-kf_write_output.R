test_that("File is saved and returned", {
  mock_file <- tempfile()
  table_name <- "model_predictions"
  saved_output <- kf_write_output(table_name, mock_file)

  expect_equivalent(mock_file, saved_output)
  expect_true(file.exists(mock_file))
})
