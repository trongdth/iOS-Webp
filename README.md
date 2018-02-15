# iOS-Webp
Support encode/decode webp for iOS


## How to build webp for iOS on MAC:

1. Download MacPorts for your Mac OS X version from the MacPorts [downloads site](http://distfiles.macports.org/MacPorts/). MacPorts requires the installation of Xcode.

2. Install the JPEG, PNG, TIFF and GIF dependencies:
```
 sudo port install jpeg libpng tiff giflib
```

3. Build webp:
```
 git clone https://github.com/trongdth/iOS-Webp.git
 cd iOS-Webp
 wget https://storage.googleapis.com/downloads.webmproject.org/releases/webp/libwebp-0.6.1.tar.gz
 bash iosbuild.sh
```

4. You will see WebP.framework, WebPDecoder.framework at current folder. 


## Run iOS source code:

1. Copy all classed under WebP-UIImage folder.
2. Copy 2 frameworks WebP.framework, WebPDecoder.framework to your project.
3. How to use:

```
 imv.image = UIImage(webPAtPath: Bundle.main.path(forResource: "5D35AF5217A59F7CABC570F09F53D67B09D3F49EEB7B85242A", ofType: "webp")!)
```

If there is any issue, feel free to contact me: trongdth@gmail.com