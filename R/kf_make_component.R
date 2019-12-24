kf_make_component <- function(rfunction, name, description, image) {
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

  # Parse out Input/Output args
  fun_args <- formalArgs(rfunction)
  input_args <- purrr::keep(fun_args, stringr::str_ends, pattern = "_string|_num")
  output_args <- purrr::keep(fun_args, stringr::str_ends, pattern = "_out")

  # Write Input/Output args
  yaml_base$inputs <- purrr::map(input_args, ~list(name = .))
  yaml_base$outputs <- purrr::map(output_args, ~list(name = .))

  # Write Implementation Args
  yaml_base$implementation$container$args <- as.list(setNames(fun_args, find_arg_type(fun_args)))

  # Write Function Call
  arg_calls <- paste0("args[", 1:length(fun_args), "]", collapse = ", ")
  yaml_base$implementation$container$command <- list(
    "Rscript",
    "-e", "args <- commandArgs(trailingOnly = TRUE)",
    "-e", paste0(rfunction, '(', arg_calls, ")")
  )

  yaml::as.yaml(yaml_base) %>% cat()
}
