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
# stopifnot(extSoftVersion()["libdeflate"] != "") TODO
stopifnot(extSoftVersion()["readline"] != "")
