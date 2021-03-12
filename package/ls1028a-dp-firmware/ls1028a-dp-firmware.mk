################################################################################
#
# ls1028a-dp-firmware
#
################################################################################

LS1028A_DP_FIRMWARE_VERSION = lsdk2012
LS1028A_DP_FIRMWARE_SITE = https://www.nxp.com/lgfiles/sdk/$(LS1028A_DP_FIRMWARE_VERSION)
LS1028A_DP_FIRMWARE_SOURCE = firmware-cadence-$(LS1028A_DP_FIRMWARE_VERSION).bin
LS1028A_DP_FIRMWARE_INSTALL_TARGET = NO
LS1028A_DP_FIRMWARE_INSTALL_IMAGES = YES

LS1028A_DP_FIRMWARE_LICENSE = NXP Semiconductor Software License Agreement
LS1028A_DP_FIRMWARE_LICENSE_FILES = EULA COPYING
LS1028A_DP_FIRMWARE_REDISTRIBUTE = NO

define LS1028A_DP_FIRMWARE_EXTRACT_CMDS
	$(call FREESCALE_EXTRACT_HELPER,$(LS1028A_DP_FIRMWARE_DL_DIR)/$(LS1028A_DP_FIRMWARE_SOURCE))
endef

define LS1028A_DP_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/dp/ls1028a-dp-fw.bin $(BINARIES_DIR)/ls1028a-dp-fw.bin
endef

$(eval $(generic-package))
