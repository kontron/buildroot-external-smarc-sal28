![Kontron](docs/logo.png)

# Kontron SMARC-sAL28 Buildroot External

This [external buildroot layer][1] provides a basic support package for the
SMARC-sAL28 board. It is an extenstion to buildroot which is provided
outside of the standard buildroot tree.

The [Kontron SMARC-sAL28][5] board is an upcoming product not yet
available. This layer does not provide the full functionality of the board.
Instead its intention is to be used to create a small footprint filesystem
image as well as to be easy to use.

Esp. this layer lacks the following functionalities:
* 3D GPU support
* KEAPI

If you need the full functionality it is recommanded to use the [Yocto Project][6] layer
provided together with the board.

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

The `images/sdcard-emmc.img` contains an image which can be transferred to the
eMMC on the board as well as to an SD card. It contains two partitions, one
which holds the kernel and device trees and one for the root filesystem.
The boot partition also contains a boot.cmd script which is
started automatically by the bootloader. Additionally, it conatins a reset configuration
word (RCW) as well as a bootloader. These are loaded during SDHC boot (see
next paragraph) or during eMMC boot. For normal SPI boot these two
components are not needed.

This image can also be used for SDHC boot. Use the SMARC test mode to
enable it. This is a last resort booting mechanism which does not depend on
any other flash content on the board and works in every case.


## Booting the board

For further details about the processor's boot process see the documentation of
the board in [u-boot][3] and the documentation of the [rcw][4].

## Further readings

* [Das u-boot SMARC-sAL28 board documenation][3]
* [Reset Configuration Word documentation][4]

## License

This project is licensed under the [GPLv2][2] or later with exceptions. See
the `COPYING` file for more information. Buildroot is licensed under the
[GPLv2][2] or later with exceptions.


[1]: https://buildroot.org/downloads/manual/manual.html#outside-br-custom
[2]: https://www.gnu.org/licenses/old-licenses/gpl-2.0.en.html
[3]: https://github.com/kontron/u-boot-smarc-sal28/blob/master/board/kontron/sl28/README.md
[4]: https://github.com/kontron/rcw-smarc-sal28/blob/master/README.md
[5]: https://www.kontron.de/products/boards-and-standard-form-factors/smarc/smarc-sal28.html
[6]: https://www.yoctoproject.org/
