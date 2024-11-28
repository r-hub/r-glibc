R.home()
libcurlVersion()

download.file(
  "https://api.r-hub.io/rversions/resolve/release",
  tmp <- tempfile()
)

readLines(tmp)
