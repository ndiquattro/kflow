find_kf_type <- function(x) {
  x <- str_extract(x, "[^_]+$")

  lookup <- list(
    string = "String",
    num = "Numeric"
  )

  lookup[[x]]
}

find_arg_type <- function(x) {
  x <- stringr::str_extract(x, "[^_]+$")

  ifelse(x %in% c("string", "num"), "inputValue", "outputPath")
}
