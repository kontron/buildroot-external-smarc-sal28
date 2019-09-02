#
# SPI flash updater v1
#
# available environment variabes
#
# non_interactive_update
#   Set to any value to skip any user input.

# running u-boot version is only valid if there was a normal boot-up. During
# failsafe boot we would get the failsafe bootloader verion. This would
# obviously confuse the user. Therefore, we just print "unknown" in this
# case.
if test "${bootsource}" -eq 3; then
	setenv running_version "${ver}"
else
	setenv running_version "<unknown>"
fi

echo "||"
echo "|| SPI flash updater v1"
echo "||"
echo "|| Current installed version: ${running_version}"
echo "|| This will install version: %INSTALLVERSION%"
echo "||"
if test "${bootsource}" -ne 3; then
	echo "|| Please note, that the currently installed version can only be"
	echo "|| displayed during non-failsafe boot."
	echo "||"
fi

if test -z "${non_interactive_update}"; then
	askenv sure "|| Are you sure? (y/N)"
	if test "${sure}" != "y" -a "${sure}" != "Y"; then
		echo "Aborting."
		exit 1
	fi
fi

# only second half of SPI flash
setenv offset 200000

echo "Loading image.."
load ${devtype} ${devnum} ${loadaddr} spi-flash.img
if test $? -ne 0; then
	echo "Loading image failed. Aborting"
	exit 1
fi

echo "Verify checksum.."
setenv spi-flash.img.sha1 %SHA1CHECKSUM%
hash -v sha1 ${fileaddr} ${filesize} ${spi-flash.img.sha1}
if test $? -ne 0; then
	echo "Verify image checksum failed. Aborting"
	exit 1
fi

setexpr imageaddr ${fileaddr} + ${offset}
setexpr imagesize ${filesize} - ${offset}

echo "Writing SPI flash.."
sf probe 0
if test $? -ne 0; then
	echo "Probing SPI flash failed. Aborting"
	exit 1
fi

sf update ${imageaddr} ${offset} ${imagesize}
if test $? -ne 0; then
	echo "Updating SPI flash failed. Aborting"
	exit 1
fi

echo "Successfully written SPI flash."

if test -z "${non_interactive_update}"; then
	echo "Resetting Board."
	reset
else
	echo "Non-interactive update. Skip resetting board."
fi
