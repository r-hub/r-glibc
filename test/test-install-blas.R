R.home()
dir.create(lib <- tempfile(), recursive = TRUE, showWarnings = FALSE)
install.packages("mvtnorm", repos = "https://cran.rstudio.com", lib = lib)
library("mvtnorm", lib.loc = lib)
