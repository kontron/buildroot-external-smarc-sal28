![Kontron](docs/logo.png)

# Kontron SMARC-sAL28 Buildroot External

This [external buildroot layer][1] provides a basic support package for the
SMARC-sAL28 board. This project provides an extension to buildroot to
provide this BSP outside of the standard buildroot tree.


## Quick Start

The external is tested on Debian 9. The tree shouldn't have any other
dependencies that buildroot itself. This layer was tested on buildroot
version 2018.11.


## Build

You have to clone buildroot and this layer. When building, use the
appropriate defconfig in the `buildroot-external-smarc-sal28/configs`
directory.

```
git clone git://git.busybox.net/buildroot
git clone https://github.com/kontron/buildroot-external-smarc-sal28.git -b 2018.11.3
mkdir build
cd build
make BR2_EXTERNAL=../buildroot-external-smarc-sal28 O=`pwd` kontron_smarc_sal28_defconfig
make
```

The resulting bootloader, kernel, root filesystem and SPI flash image will
be put in the `build/images` directory.


## Flash the SPI image

The `output/flash.bin` is a complete SPI flash image which can be
programmed into the flash.


## License

This project is licensed under the [GPLv2][2] or later with exceptions. See
the `COPYING` file for more information. Buildroot is licensed under the
[GPLv2][2] or later with exceptions.


[1]: https://buildroot.org/downloads/manual/manual.html#outside-br-custom
[2]: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
