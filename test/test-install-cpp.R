R.home()
dir.create(lib <- tempfile(), recursive = TRUE, showWarnings = FALSE)
install.packages("digest", repos = "https://cran.rstudio.com", lib = lib)
library("digest", lib.loc = lib)
