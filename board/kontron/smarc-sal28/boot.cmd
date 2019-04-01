setenv bootargs root=/dev/mmcblk${devnum}p2 rootwait default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080 cma=256M

fatload ${devtype} ${devnum} $kernel_addr_r Image
fatload ${devtype} ${devnum} $fdt_addr_r sl28.dtb

booti $kernel_addr_r - $fdt_addr_r
