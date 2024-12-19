R.home()

pager <- Sys.getenv("PAGER")
stopifnot(startsWith(pager, "/opt/R/"))
stopifnot(basename(pager) == "less")

# this errors if less fails
options(warn = 2)
ret <- system2(pager, stdout = TRUE, stderr = TRUE)
