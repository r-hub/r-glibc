R.home()

# -------------------------------------------------------------------------

tmp <- tempfile(fileext = ".png")
png(tmp)
plot(1:10)
dev.off()

out <- system2("file", tmp, stdout = TRUE)
message(out)
stopifnot(grepl("PNG", out))

# -------------------------------------------------------------------------

tmp <- tempfile(fileext = "jpg")
jpeg(tmp)
plot(1:10)
dev.off()

out <- system2("file", tmp, stdout = TRUE)
message(out)
stopifnot(grepl("JPEG", out))

# -------------------------------------------------------------------------

tmp <- tempfile(fileext = "tiff")
tiff(tmp)
plot(1:10)
dev.off()

out <- system2("file", tmp, stdout = TRUE)
message(out)
stopifnot(grepl("TIFF", out))

# -------------------------------------------------------------------------

tmp <- tempfile(fileext = "pdf")
cairo_pdf(tmp)
plot(1:10)
dev.off()

out <- system2("file", tmp, stdout = TRUE)
message(out)
stopifnot(grepl("PDF", out))

# -------------------------------------------------------------------------

tmp <- tempfile(fileext = "ps")
cairo_ps(tmp)
plot(1:10)
dev.off()

out <- system2("file", tmp, stdout = TRUE)
message(out)
stopifnot(grepl("PostScript", out))
