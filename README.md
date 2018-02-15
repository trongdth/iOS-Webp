# iOS-Webp
Support encode/decode webp for iOS


## How to build webp for iOS on MAC:

1. Download MacPorts for your Mac OS X version from the MacPorts [downloads site](http://distfiles.macports.org/MacPorts/). MacPorts requires the installation of Xcode.

2. Install the JPEG, PNG, TIFF and GIF dependencies:

 sudo port install jpeg libpng tiff giflib

3. Build webp:
```
 git clone https://github.com/trongdth/iOS-Webp.git
 cd iOS-Webp
 wget https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.6.1.tar.gz
 bash iosbuild.sh
```

## Run iOS source code:

1. 