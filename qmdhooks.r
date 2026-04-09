library(knitr)
knitr::opts_chunk$set(
  message = FALSE, 
  warning = FALSE,
  comment = NA
)

# hook for the code source
knit_hooks$set(source = function(x, options) {
  # If include is FALSE or echo is FALSE, return nothing
  if (options$include == FALSE || options$echo == FALSE) {
    return("")
  }
  
  full_code <- paste(x, collapse = "\n")
  
  # Escape double quotes so they don't break the Typst raw() function 
  escaped_code <- gsub('"', '\\"', full_code, fixed = TRUE)
  
  sprintf('#block(
    fill: luma(240), 
    inset: 8pt, 
    radius: 4pt, 
    width: 100%%, 
    raw("%s", lang: "r")
  )', escaped_code)
})

# hook for the console output
knit_hooks$set(output = function(x, options) {
  # Guard: Check for include, results: 'hide', and empty strings
  if (isFALSE(options$include) || options$results == 'hide' || trimws(x) == "") {
    return("")
  }

  sprintf('#block(
    stroke: 0.5pt + luma(200), 
    inset: 8pt, 
    radius: 4pt, 
    width: 100%%, 
    raw("%s")
  )', x)
})

# hook for plots
knit_hooks$set(plot = function(x, options) {
  # Guard: prevent plots from rendering if include is FALSE
  if (options$include == FALSE) return("")
  
  sprintf('#align(center, image("%s", width: 80%%))', x)
})

# hook for in-text variables
knit_hooks$set(inline = function(x) {
  if (is.numeric(x)) {
    # Check for 'digits' in global env, default to 4
    d <- if (exists("digits", envir = .GlobalEnv)) get("digits", envir = .GlobalEnv) else 4
    x <- round(x, d)
  }
  
  # Convert to character
  res <- as.character(x)
  
  # Optional: If you want to ensure scientific notation 
  # uses Typst math syntax (e.g., 1.2 x 10^3)
  res <- gsub("e\\+?(-?\\d+)", " times 10^(\\1)", res)
  
  return(res)
})
