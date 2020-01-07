find_kf_type <- function(x) {
  x <- stringr::str_extract(x, "[^_]+$")

  lookup <- list(
    string = "String",
    int = "Integer",
    float = "Float",
    bool = "Bool",
    metrics = "Metrics",
    uimeta = "UI_metadata"
  )

  lookup[[x]]
}

find_arg_type <- function(x) {
  x <- stringr::str_extract(x, "[^_]+$")

  ifelse(x %in% c("string", "int", "float", "bool"), "inputValue", "outputPath")
}
