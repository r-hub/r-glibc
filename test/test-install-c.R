R.home()
dir.create(lib <- tempfile(), recursive = TRUE, showWarnings = FALSE)
install.packages("filelock", repos = "https://cran.rstudio.com", lib = lib)
library("filelock", lib.loc = lib)
