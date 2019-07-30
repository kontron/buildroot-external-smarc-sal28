#
# SPI flash updater v1
#
# available environment variabes
#
# non_interactive_update
#   Set to any value to skip any user input.
#
# full_spi_update
#   Set to any value to update the whole SPI flash. Please note,
#   that by default, the first 2 MiB of the SPI flash is
#   write-protected and cannot be written.

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

if test -n "${full_spi_update}"; then
	echo "Updating complete SPI flash.."
	setenv offset 0
else
	# only second half of SPI flash
	echo "Updating user-writable part of SPI flash.."
	setenv offset 200000
fi

echo "Loading image.."
load ${devtype} ${devnum} ${loadaddr} spi-flash.img - ${offset}
if test $? -ne 0; then
	echo "Loading image failed. Aborting"
	exit 1
fi

echo "Writing SPI flash.."
sf probe 0
if test $? -ne 0; then
	echo "Probing SPI flash failed. Aborting"
	exit 1
fi
sf update ${fileaddr} ${offset} ${filesize}
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
