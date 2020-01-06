# Setup
test_ui <- kf_init_ui_meta()

test_that("Custom class is applied correctly", {

  expect_s3_class(test_ui, "kflow_meta")
  expect_s3_class(test_ui, "list")
})

test_that("Print methods respond correctly", {

  expect_output(print(test_ui, pretty = FALSE), '{"outputs":[]}', fixed = TRUE)
  expect_output(print(test_ui, preview = FALSE), "$outputs\nlist()", fixed = TRUE)
})
