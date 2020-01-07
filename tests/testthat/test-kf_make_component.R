comp_fun <- function(location_string, count_int, weight_float, flag_bool, path_metrics,
                     path_metaui, results_out) {
  2 * 2
}

test_that("File is written", {
  tfile <- tempfile()

  kf_make_component("mean", "Test Function", "A function for testing",
                    "docker/docker", file = tfile)

  expect_true(file.exists(tfile))
})
