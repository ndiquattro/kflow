test_ui <- kf_init_ui_meta()
mock_loc <- "gs://project/rocfile.csv"

test_that("Single roc is added correctly", {
  one_added <- kf_add_roc(test_ui, mock_loc)

  expect_output(print(one_added, pretty = FALSE), '{"outputs":[{"type":"roc","format":"csv","schema":[{"name":"thresholds","type":"NUMBER"},{"name":"fpr","type":"NUMBER"},{"name":"tpr","type":"NUMBER"}],"source":"gs://project/rocfile.csv"}]}', fixed = TRUE)
})

test_that("Multiple rocs are added correctly", {
  two_added <-
    test_ui %>%
    kf_add_roc(mock_loc) %>%
    kf_add_roc(mock_loc)

  expect_output(print(two_added, pretty = FALSE), '{"outputs":[{"type":"roc","format":"csv","schema":[{"name":"thresholds","type":"NUMBER"},{"name":"fpr","type":"NUMBER"},{"name":"tpr","type":"NUMBER"}],"source":"gs://project/rocfile.csv"},{"type":"roc","format":"csv","schema":[{"name":"thresholds","type":"NUMBER"},{"name":"fpr","type":"NUMBER"},{"name":"tpr","type":"NUMBER"}],"source":"gs://project/rocfile.csv"}]}', fixed = TRUE)
})
