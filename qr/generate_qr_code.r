#!/usr/bin/env Rscript
# Generate a QR code and output it to a PNG file
# Paul W. Egeler, M.S., GStat
# 10 Oct 2019
# Licensed under GPL-3

# Check if packages are installed -----------------------------------------
suppressPackageStartupMessages({
  pkgs_installed <- sapply(
    c("qrcode", "argparse"),
    require,
    quietly = TRUE,
    character.only = TRUE
  )
})

if ( !all(pkgs_installed) ) {
  stop("This script requires 'argparse' and 'qrcode' packages to be installed")
}


# Parse command-line args -------------------------------------------------
parser <- argparse::ArgumentParser(
  description = "Generate a QR code and output it to a PNG file"
)

parser$add_argument("url",
                    help = "The URL to encode into a QR Code")
parser$add_argument("-s", "--size",
                    default = 1,
                    type = "double",
                    help = "Side length (inches) of the image")
parser$add_argument("-r", "--resolution",
                    default = 300L,
                    type = "integer",
                    help = "Resolution (ppi) of image")
parser$add_argument("-o", "--outfile",
                    help = "Image file name")

args <- parser$parse_args()

# Process outfile argument
if ( is.null(args$outfile) ) {
  args$outfile <- sprintf(
    "QRplot%03i.png",
    length(list.files(pattern = "QRplot[0-9]{3}\\.png")) + 1L
  )
} else if ( !grepl("\\.png$", args$outfile, ignore.case = TRUE) ) {
  args$outfile <- paste0(args$outfile, ".png")
}

# Create matrix -----------------------------------------------------------
m <- qrcode::qrcode_gen(args$url, dataOutput = TRUE, plotQRcode = FALSE)
m <- t(m[nrow(m):1,])

# Generate image ----------------------------------------------------------
# Manual plot instead of using `plotQRcode` because we don't want margins
with(
  args,
  png(outfile, size, size, "in", res = resolution)
)

par(mai = rep(0, 4L))
image(m, col = c("#FFFFFF", "#000000"), axes = FALSE)

invisible(dev.off())

# All done ----------------------------------------------------------------
message("Image output to: ", args$outfile)
q("no")
