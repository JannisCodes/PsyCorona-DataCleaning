recode_if <- function(x, condition, ...) {
  if_else(condition, recode(x, ...), x)
}