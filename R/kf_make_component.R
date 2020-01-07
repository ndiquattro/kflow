#' Make Kubeflow component from a function
#'
#' Given a defined R function export a YAML file for Kubeflow to consume.
#'
#' Names of metrics and ui metadata arguments are renamed to required
#' specifications. Kubeflow likes arguments to be typed, which R doesn't handle
#' naturally. This function looks for a slug at the end of each argument to
#' determine the type. For example, `table_name_string` would be considered an
#' input String. Output paths are identified by ending in `_out`. Supported
#' translations are:
#'
#' Inputs
#' * `_string` = String
#' * `_int` = Integer
#' * `_bool` = Bool
#' * `_float` = Float
#'
#' Outputs
#' * `_out` = outputPath
#' * `_metrics` = Metrics
#' * `_uimeta` = UI_metadata
#'
#' @param rfunction Name of target function.
#' @param name Name of component.
#' @param description Description of component.
#' @param image Location of Docker image.
#' @param file Location to write yaml. Optional.
#'
#' @return Component YAML
#' @export
#'
#' @examples
#' tfun <- function(table_string, pred_count_int, path_metrics) 2 * 2
#' kf_make_component("tfun", "Test Component", "Test out the component", "gcr.io/test/test")
kf_make_component <- function(rfunction, name, description, image, file) {
  # Create base YAML
  yaml_base <-
    list(
      name = name,
      description = description,
      inputs = list(),
      outputs = list(),
      implementation = list(
        container = list(
          image = image,
          args = list(),
          command = list()
        )
      )
    )

  # Parse Function Name
  rfun <- stringr::str_split(rfunction, "::", simplify = TRUE)

  # Parse out Input/Output args
  fun_args <- methods::formalArgs(rfun[ncol(rfun)])
  input_args <- purrr::keep(fun_args, stringr::str_ends, pattern = "_string|_int|_bool|_float")
  output_args <- purrr::keep(fun_args, stringr::str_ends, pattern = "_out|_metrics|_uimeta")

  # Write Input/Output args
  yaml_base$inputs <- purrr::map(input_args, ~list(name = ., type = find_kf_type(.)))
  yaml_base$outputs <- purrr::map(output_args, ~list(name = name_fixer(.), type = find_kf_type(.)))

  # Rename metrics/ui outputs

  # Write Implementation Args
  yaml_base$implementation$container$args <- purrr::map(fun_args, ~as.list(setNames(name_fixer(.), find_arg_type(.))))

  # Write Function Call
  arg_calls <- paste0("args[", 1:length(fun_args), "]", collapse = ",")
  yaml_base$implementation$container$command <- list(
    "Rscript",
    "-e", 'args<-commandArgs(trailingOnly=TRUE)',
    "-e", paste0(paste(rfun, collapse = "::"), '(', arg_calls, ")")
  )

  if (missing(file)) {
    return(yaml::as.yaml(yaml_base))
  }

  yaml::write_yaml(yaml_base, file)
}

name_fixer <- function(x) {
  x_stub <- stringr::str_extract(x, "[^_]+$")
  # When argument ends in "_metrics":
  if (x_stub == "metrics") {
    return("mlpipeline_metrics")
  }

  # When argument ends in "_uimeta":
  if (x_stub == "uimeta") {
    return("mlpipeline_ui_metadata")
  }

  x
}
