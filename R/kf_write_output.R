#' Write output to a provided outputPath
#'
#' Writes content to a Kubeflow provided path for output.
#'
#' Defaults to [readr::write_file()], but uses [jsonlite::write_json()] or [readr::write_csv()] for appropriate classes.
#'
#' @param contents R object to save.
#' @param outfile File provided by Kubeflow
#'
#' @return outfile
#' @export
#'
#' @examples
#' predictions_table_name <- "model_predictions"
#' mock_path <- tempfile()
#' kf_write_output(predictions_table_name, mock_path)
kf_write_output <- function(contents, outfile) {
  UseMethod("kf_write_output")
}

#' @export
kf_write_output.default <- function(contents, outfile) {
  fs::dir_create(fs::path_dir(outfile))
  readr::write_file(contents, outfile)

  outfile
}

# Write meta data to json
#' @export
kf_write_output.kflow_meta <- function(contents, outfile) {
  fs::dir_create(fs::path_dir(outfile))
  jsonlite::write_json(contents, outfile)

  outfile
}
