#' Add a ROC Curve to a UI Metadata Set
#'
#' @param ui_set UI set from [kf_init_ui_meta()] or a previious call of this type of function.
#' @param roc_file Location of coresponding .csv that contains thresholds, FPR, and TPR.
#'
#' @return UI set
#' @export
#'
#' @examples
#' kf_init_ui_meta() %>%
#'   kf_add_roc("gs://project-bucket/roc_file.csv")
kf_add_roc <- function(ui_set, roc_file) {
  new_roc <-
    list(
      type = jsonlite::unbox("roc"),
      format = jsonlite::unbox("csv"),
      schema = list(
        list(name = jsonlite::unbox("thresholds"), type = jsonlite::unbox("NUMBER")),
        list(name = jsonlite::unbox("fpr"), type = jsonlite::unbox("NUMBER")),
        list(name = jsonlite::unbox("tpr"), type = jsonlite::unbox("NUMBER"))
      ),
      source = jsonlite::unbox(roc_file)
    )

  ui_set$outputs <- append(ui_set$outputs, list(new_roc))
  ui_set
}
