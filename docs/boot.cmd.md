# boot.cmd

The boot.cmd (or boot.scr) contains the distro specific boot configuration.
Alonge the functionality required by the U-Boot there are some additional
board specific variables.

## Variables

| Variable name    | Description                                    |
| ---------------- | ---------------------------------------------- |
| variant          | Selects the variant specific dtb overlay. The file has to be present at the boot partition at overlays/sl28-variant${variant}.dtbo. |
| carrier          | Selects the carrier specific dtb overlay. The file has to be present at the boot partition at overlays/carrier-${carrier}.dtbo. |
| overlays         | List with optional dtb overlays. The file(s) has to be located at overlays/${overlay}.dtbo. |

[1]: https://gitlab.denx.de/u-boot/u-boot/blob/master/doc/README.distro
