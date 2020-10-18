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

The external is tested on Debian 10. The following system build
dependencies are required (by buildroot itself).

```
apt install which sed make binutils build-essential gcc g++ \
bash patch gzip bzip2 perl tar cpio python unzip rsync file \
bc wget libncurses5-dev git subversion
```

This layer was tested on buildroot version 2020.08.

## Build

You have to clone buildroot and this layer. When building, use the
appropriate defconfig in the `buildroot-external-smarc-sal28/configs`
directory.

```
git clone git://git.busybox.net/buildroot -b 2020.08
git clone https://github.com/kontron/buildroot-external-smarc-sal28.git
mkdir build
cd build
make -C ../buildroot BR2_EXTERNAL=../buildroot-external-smarc-sal28 O=`pwd` kontron_smarc_sal28_defconfig
make
```

The resulting bootloader, kernel, root filesystem and SPI flash image will
be put in the `build/images` directory.


## Available images

After building, there will be three images. The `images/spi-flash.img` is a
complete flash image which can be programmed into SPI flash. Please note,
that the first half of the SPI flash is usually write protected and can not
be programmed. Just write the second half of the image. This section will
contain the standard bootloader which is started by default. Alternatively,
you can program the whole image; in this case the programming of the first
half will silently fail u-boot, because it is write-protected by Kontron.

The `images/sdcard-emmc.img` contains an image which can be transferred to the
eMMC on the board as well as to an SD card. It contains two partitions, one
which holds the kernel and device trees and one for the root filesystem.
Additionally, there is a reset configuration word (RCW) as well as a
bootloader. These are loaded during SDHC boot (see next paragraph) or
during eMMC boot. For normal SPI boot these two components are not needed.
The boot partition also contains a boot.cmd script which is started
automatically by the bootloader. The behaviour of the script can be
influenced by environment variables stored in the bootloader. See
[here](#generic-distribution-boot) for details.

This image can also be used for SDHC boot. Use the SMARC test mode to
enable it. This is a last resort booting mechanism which does not depend on
any other flash content on the board and works in every case.

The `images/spi-flash-updater.img` is an update image which can be
flashed to any block device which is supported as a boot device by the
board. For example, you can put it on an USB thumb drive. If the board is
configured to boot from USB, it will automatically load the updater. It
will update the user-writeable part of the SPI flash, ie. the bootloader.
Please note, that this is fail-safe as there is always a second,
write-protected bootloader. You can switch of the interactive behaviour of
the script by setting the environment variable `non_interactive_update` to
a non-empty value. Be careful with that!

The `images/spi-flash-updater.zip` contains the same files as the
corresponding image. Only difference is that you can extract the files
directly onto a pre-formatted storage device like an USB thumb drive. The
files have to be put into the root folder of the drive.

## Booting the board

For further details about the processor's boot process see the documentation of
the board in [u-boot][3] and the documentation of the [rcw][4].

## Generic distribution boot

This external supports the concept of [Generic Distribution Boot][7] of the
u-boot bootloader. In a nutshell, the bootloader will search storage media
for a script with a specific name (by default `boot.cmd`) and run it. The
user can define a search order. All in all, it mimicks the behaviour of a
PC bios.

The boot script provided with this external loads the device trees, device
tree overlays, sets the root filesystem device (`root=` kernel parameter)
and finally loads and executes the kernel. Which device tree overlay is
loaded depends on u-boot environment variables.

First the device tree overlay for the board variant is loaded by looking at
the `variant` environment variable. This variable is set automatically be
the bootloader. After that, if there is a `carrier` variable set, it loads
the corresponding overlay. Finally, there is a generic `overlays` variable,
where you can store any additional overlays names. They are loaded in the
order of appearance. All overlays have to be in the `overlays/` directory
of the same storage device where the `boot.cmd` is stored. See the table
below for more details.

| Variable      | Description                                             |
| ------------- | ------------------------------------------------------- |
| variant       | Loads sl28-variant${variant}.dtbo                       |
| carrier       | If exists, loads carrier-${carrier}.dtbo                |
| overlays      | Space separated list of additional overlays to load     |
| extrabootargs | Additional command line parameters appended to bootargs |

You can find the source at
[board/kontron/smarc-sal28/boot.cmd](board/kontron/smarc-sal28/boot.cmd).

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
[7]: https://gitlab.denx.de/u-boot/u-boot/blob/master/doc/README.distro
