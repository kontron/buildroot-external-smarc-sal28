![Kontron](docs/logo.png)

# Kontron SMARC-sAL28 Buildroot External

This [external buildroot layer][1] provides a basic support package for the
SMARC-sAL28 board. This project provides an extension to buildroot to
provide this BSP outside of the standard buildroot tree.


## Install System Dependencies

The external is tested on Debian 9. The following system build
dependencies are required (by buildroot itself).

```
apt install which sed make binutils build-essential gcc g++ \
bash patch gzip bzip2 perl tar cpio python unzip rsync file \
bc wget libncurses5-dev git subversion
```

This layer was tested on buildroot version 2019.02.

## Build

You have to clone buildroot and this layer. When building, use the
appropriate defconfig in the `buildroot-external-smarc-sal28/configs`
directory.

```
git clone git://git.busybox.net/buildroot -b 2019.02
git clone https://github.com/kontron/buildroot-external-smarc-sal28.git
mkdir build
cd build
make -C ../buildroot BR2_EXTERNAL=../buildroot-external-smarc-sal28 O=`pwd` kontron_smarc_sal28_defconfig
make
```

The resulting bootloader, kernel, root filesystem and SPI flash image will
be put in the `build/images` directory.


## Available images

After building, there will be two images. The `images/spi-flash.img` is a
complete flash image which can be programmed into SPI flash. Please note,
that the first half of the SPI flash is usually write protected and can not
be programmed. Just write the second half of the image. This section will
contain the standard bootloader which is started by default.

The `images/sd-card.img` contains an image which can be transferred to a SD
card. Use the SMARC test mode to enable SDHC boot. This is a last resort
booting mechanism which does not depend on any other flash content on the
board and works in every case.

## Booting the board

For a details on the boot process of the processor see the documentation of
the board in [u-boot][3] and the documentation of the [rcw][4].

## License

This project is licensed under the [GPLv2][2] or later with exceptions. See
the `COPYING` file for more information. Buildroot is licensed under the
[GPLv2][2] or later with exceptions.


[1]: https://buildroot.org/downloads/manual/manual.html#outside-br-custom
[2]: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
[3]: https://github.com/kontron/u-boot-smarc-sal28/blob/master/board/kontron/sl28/README.md
[4]: https://github.com/kontron/rcw-smarc-sal28/blob/master/README.md
