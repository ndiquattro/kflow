# Setup
test_mets <- kf_init_metrics()

test_that("Custom class is applied correctly", {

  expect_s3_class(test_mets, "kflow_meta")
  expect_s3_class(test_mets, "list")
})

test_that("Print methods respond correctly", {

  expect_output(print(test_mets, pretty = FALSE), '{"metrics":[]}', fixed = TRUE)
  expect_output(print(test_mets, preview = FALSE), "$metrics\nlist()", fixed = TRUE)
})
