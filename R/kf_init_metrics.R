#' Initialize Pipeline Metrics Artifacts
#'
#' Lay the foundational elements of the JSON expected by Kubeflow to provide metrics from your components.
#'
#' @return A list
#' @export
#'
#' @examples
#' metrics <- kf_init_metrics()
#' kf_add_metric(metrics, "roc", .5, "RAW")
kf_init_metrics <- function() {
  metrics <- list(metrics = list())
  class(metrics) <- c("kflow_meta", class(metrics))
  metrics
}


#' Prints kflow_meta objects
#'
#' Extends print to work with kflow_meta objects
#'
#' @param x kflow_meta object. Likely from [kf_init_metrics()].
#' @param preview Boolean to indicate whether JSON should be printed. Set to `FALSE` to inspect underlying list structure.
#' @param pretty Boolean to indicate whether to pretty print or not.
#' @param ... Other arguments passed on.
#'
#' @export
#'
#' @examples
#' # By default it displays the eventual JSON
#' test_mets <- kf_init_metrics()
#' test_mets
#'
#' # Use print() to see in list form
#' print(test_mets, preview = FALSE)
print.kflow_meta <- function(x, preview = TRUE, pretty = TRUE, ...) {
  if (preview) {
    print(jsonlite::toJSON(x, pretty = pretty))
    return(invisible(x))
  }

  class(x) <- NULL
  print(x)
}
