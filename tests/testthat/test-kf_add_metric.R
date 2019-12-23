test_metrics <- kf_init_metrics()

test_that("Input validation works", {
  expect_error(kf_add_metric(test_metrics, "ROC"), "Name does not match required pattern.")
  expect_error(kf_add_metric(test_metrics, name = "roc", value = "15"), "Value must be numeric.")
  expect_error(kf_add_metric(test_metrics, name = "roc", value = .15, format = "plain"), "Format must be either RAW or PERCENTAGE.")
})

test_that("Single metric is added correctly", {
  one_added <- kf_add_metric(test_metrics, "roc", .5, "RAW")

  expect_output(print(one_added, pretty = FALSE), '{"metrics":[{"name":"roc","numberValue":0.5,"format":"RAW"}]}', fixed = TRUE)
})

test_that("Multiple metrics are added correctly", {
  two_added <-
    test_metrics %>%
    kf_add_metric("roc", .5, "RAW") %>%
    kf_add_metric("accuracy", .5, "PERCENTAGE")

  expect_output(print(two_added, pretty = FALSE), '{"metrics":[{"name":"roc","numberValue":0.5,"format":"RAW"},{"name":"accuracy","numberValue":0.5,"format":"PERCENTAGE"}]}', fixed = TRUE)
})
