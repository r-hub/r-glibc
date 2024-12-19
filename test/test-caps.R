R.home()
stopifnot(capabilities()["jpeg"])
stopifnot(capabilities()["png"])
stopifnot(capabilities()["tiff"])
stopifnot(capabilities()["iconv"])
stopifnot(capabilities()["NLS"])
stopifnot(capabilities()["cairo"])
stopifnot(capabilities()["ICU"])
stopifnot(capabilities()["libcurl"])

stopifnot(extSoftVersion()["xz"] != "")
if (getRversion() >= "4.4.0") {
  stopifnot(extSoftVersion()["libdeflate"] != "")
}
stopifnot(extSoftVersion()["readline"] != "")
