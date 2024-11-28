R.home()
dir.create(lib <- tempfile(), recursive = TRUE, showWarnings = FALSE)
install.packages("nlme", repos = "https://cran.rstudio.com", lib = lib)
library("nlme", lib.loc = lib)
