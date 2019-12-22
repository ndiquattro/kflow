#' Initialize Pipeline Metrics Artifacts
#'
#' Lay the foundational elements of the JSON expected by Kubeflow to provide metrics from your components.
#'
#' @return A list
#' @export
#'
#' @examples
#' metrics <- kf_init_metrics()
#' jsonlite::toJSON(metrics, pretty = TRUE)
kf_init_metrics <- function() {
  structure(list(metrics = list()), class = c("kflow_meta", "list"))
}
