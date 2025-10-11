R.home()
dir.create(lib <- tempfile(), recursive = TRUE, showWarnings = FALSE)
install.packages("KernSmooth", repos = "https://cran.rstudio.com", lib = lib)
library("KernSmooth", lib.loc = lib)
