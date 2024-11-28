R.home()
dir.create(lib <- tempfile(), recursive = TRUE, showWarnings = FALSE)
install.packages("pkgconfig", repos = "https://cran.rstudio.com", lib = lib)
library("pkgconfig", lib.loc = lib)
