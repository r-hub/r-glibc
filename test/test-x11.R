R.home()

# -------------------------------------------------------------------------

stopifnot(isTRUE(capabilities()[["X11"]]))

# -------------------------------------------------------------------------

tmp <- tempfile(fileext = "png")
png(tmp, type = "Xlib")
plot(1:10)
dev.off()

out <- system2("file", tmp, stdout = TRUE)
message(out)
stopifnot(grepl("PNG", out))

# -------------------------------------------------------------------------

x11()
plot(1:10)
dev.off()
