R.home()

zip <- Sys.getenv("R_ZIPCMD")
unzip <- Sys.getenv("R_UNZIPCMD")

stopifnot(startsWith(zip, "/opt/R/"))
stopifnot(basename(zip) == "zip")

stopifnot(startsWith(unzip, "/opt/R/"))
stopifnot(basename(unzip) == "unzip")

write.table(mtcars, tmp <- tempfile())
lines <- readLines(tmp)

options(warn = 2)
tmpzip <- paste0(tmp, ".zip")
setwd(dirname(tmp))
system2(zip, c(tmpzip, basename(tmp)), stdout = TRUE, stderr = TRUE)

unlink(tmp)
stopifnot(!file.exists(tmp))

system2(unzip, c(tmpzip, "-d", getwd()), stdout = TRUE, stderr = TRUE)
stopifnot(file.exists(tmp))

lines2 <- readLines(tmp)
stopifnot(length(lines) == length(lines2) && all(lines == lines2))
