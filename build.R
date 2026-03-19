library(knitr)

# 1. Capture filename from PowerShell
args <- commandArgs(trailingOnly = TRUE)
input_file <- if(length(args) > 0) args[1] else "hw.typ"

# 2. Set working directory to the current PowerShell folder
base_path  <- getwd() 
base_name  <- tools::file_path_sans_ext(input_file)
knit_output <- file.path(base_path, paste0(base_name, ".knit.typ"))

# 3. Configure knitr
opts_chunk$set(
  dev = "png",
  fig.path = file.path(base_path, "figure", base_name, "/"),
  fig.show = "asis",
  comment = "" 
)

# 4. Load hooks and Knit
source("g:/My Drive/reference/qmdhooks.r")
knitr::knit(input_file, output = knit_output)

# 5. Compile to PDF
system(sprintf('typst compile --root "%s" "%s"', base_path, knit_output))