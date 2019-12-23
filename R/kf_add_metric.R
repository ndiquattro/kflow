#' Add metric to pipeline metrics set
#'
#' Adds on to an existing metric set and checks values are formatted correctly.
#'
#' You can repeatedly chain this function to iteratively build up a pipeline metrics output.
#'
#' @param metric_set Metric set from [kf_init_metrics()] or a previious call of this function.
#' @param name Name of metric.
#' @param value Value of metric. Must be numeric.
#' @param format Format to display metric in Kubeflow. Must be either RAW or PERCENTAGE.
#'
#' @return Metric set
#' @export
#'
#' @examples
#' # Create ROC AUC and PR AUC output
#' kf_init_metrics() %>%
#'   kf_add_metric("roc-auc", .75, "RAW") %>%
#'   kf_add_metric("pr-auc", .45, "RAW")
kf_add_metric <- function(metric_set, name, value, format) {
  # Check requirements
  if (!grepl("^[a-z]([-a-z0-9]{0,62}[a-z0-9])?$", name)) {
    stop("Name does not match required pattern. See https://www.kubeflow.org/docs/pipelines/sdk/pipelines-metrics/")
  }

  if (!is.numeric(value)) {
    stop("Value must be numeric.")
  }

  format <- toupper(format)
  if (!format %in% c("RAW", "PERCENTAGE")) {
    stop("Format must be either RAW or PERCENTAGE.")
  }

  new_metric <-
    list(
      name = jsonlite::unbox(name),
      numberValue = jsonlite::unbox(value),
      format = jsonlite::unbox(format)
    )

  metric_set$metrics <- append(metric_set$metrics, list(new_metric))
  metric_set
}
