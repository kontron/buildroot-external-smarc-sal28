setenv bootargs root=/dev/mmcblk${devnum}p2 rootwait default_hugepagesz=2m hugepagesz=2m hugepages=256 video=1920x1080 cma=256M ${extrabootargs}

load ${devtype} ${devnum} ${kernel_addr_r} Image
load ${devtype} ${devnum} ${fdt_addr_r} sl28.dtb

echo "Preparing for overlays"
setexpr fdt_overlay_addr_r ${fdt_addr_r} + F000
fdt addr ${fdt_addr_r}
fdt resize

if load ${devtype} ${devnum} ${fdt_overlay_addr_r} overlays/sl28-variant${variant}.dtbo; then
	echo "Overlaying sl28-variant${variant}.dtbo"
	fdt apply ${fdt_overlay_addr_r}
fi

if test -n ${carrier}; then
	if load ${devtype} ${devnum} ${fdt_overlay_addr_r} overlays/carrier-${carrier}.dtbo; then
		echo "Overlaying carrier-${carrier}.dtbo"
		fdt apply ${fdt_overlay_addr_r}
	fi
fi

for overlay in ${overlays}; do
	if load ${devtype} ${devnum} ${fdt_overlay_addr_r} overlays/${overlay}.dtbo; then
		echo "Overlaying ${overlay}.dtbo"
		fdt apply ${fdt_overlay_addr_r}
	fi
done

booti ${kernel_addr_r} - ${fdt_addr_r}
