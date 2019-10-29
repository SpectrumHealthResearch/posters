Generating QR Codes
===================

[QR codes](https://en.wikipedia.org/wiki/QR_code) are 2d barcodes.
You can encode a URL into the QR code.

## Use Case

Someone can use the camera on their mobile device to access the embedded URL
and visit the site. We create a QR code so that someone viewing a poster in
person can pull up a digital copy of that poster on their phone or other device.

## Usage

Creating a QR code is facilitated by the `generate_qr_code.r` utility in this
folder.

```
usage: ./generate_qr_code.r [-h] [-s SIZE] [-r RESOLUTION] [-o OUTFILE] url

Generate a QR code and output it to a PNG file

positional arguments:
  url                   The URL to encode into a QR Code

optional arguments:
  -h, --help            show this help message and exit
  -s SIZE, --size SIZE  Side length (inches) of the image
  -r RESOLUTION, --resolution RESOLUTION
                        Resolution (ppi) of image
  -o OUTFILE, --outfile OUTFILE
                        Image file name
```

## Example

This will create PNG files that correspond to any new files added to
the directory above this one.

```bash
base_url=https://github.com/SpectrumHealthResearch/posters/raw/master/

for f in ../*.pdf; do 

  pdf_name="${f##*/}"
  png_name="${pdf_name/.pdf/.png}"
  
  if [ ! -f "$png_name" ]; then
    Rscript generate_qr_code.r "$base_url$pdf_name" -o "$png_name"
  fi
  
done
```

Please note that this is only an example to provide a sense of how the utility
can be used. You will probably want to add the QR code to the poster itself.
So it will be necessary to either revise the PDF by adding the QR code after
it's generated or alter your workflow so that the QR code is available to the
team prior to publishing to PDF.
