R.home()

home <- R.home()
oklibs <- c(
  "libpthread.so.0",
  "libm.so.6",
  "libdl.so.2",
  "libgcc_s.so.1",
  "libc.so.6",
  "libgfortran.so.4",  # TODO: remove
  "librt.so.1",
  "ld-linux-aarch64.so.1",
  "ld-linux-x86-64.so.2"
)

check_libs <- function(path) {
  libs <- system2(
    "patchelf",
    c("--print-needed", file.path(home, path)),
    stdout = TRUE
  )
  if (! all(libs %in% oklibs)) {
    bad <- setdiff(libs, oklibs)
    stop(
      "Unexpected dynamic library: ",
      paste(bad, collapse = ", ")
    )
  }
}

check_libs("bin/exec/R")
check_libs("bin/Rscript")
for (so in dir(home, pattern = "[.]so$", recursive = TRUE)) {
  check_libs(so)
}
