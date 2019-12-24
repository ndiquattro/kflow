#' Initialize UI Meta Artifacts
#'
#' Lay the foundational elements of the JSON expected by Kubeflow to provide UI meta data from your components.
#'
#' @return A list
#' @export
#'
#' @examples
#' metrics <- kf_init_ui_meta()
#' kf_add_metric(metrics, "roc", .5, "RAW")
kf_init_ui_meta <- function() {
  ui_meta <- list(outputs = list())
  class(ui_meta) <- c("kflow_meta", class(ui_meta))
  ui_meta
}
