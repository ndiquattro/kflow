#' Write output to a provided outputPath
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
  fs::dir_create(fs::path_dir(outfile))
  readr::write_file(contents, outfile)

  outfile
}
