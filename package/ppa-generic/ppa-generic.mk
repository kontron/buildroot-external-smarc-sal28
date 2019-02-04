################################################################################
#
# ppa firmware for NXP layerscape platforms
#
################################################################################

PPA_GENERIC_VERSION = LSDK-18.09
PPA_GENERIC_SITE = https://source.codeaurora.org/external/qoriq/qoriq-components/ppa-generic
PPA_GENERIC_SITE_METHOD = git
PPA_GENERIC_LICENSE = BSD-3-Clause
PPA_GENERIC_LICENSE_FILES = license.txt
PPA_GENERIC_INSTALL_TARGET = NO
PPA_GENERIC_INSTALL_IMAGES = YES
PPA_GENERIC_DEPENDENCIES = host-uboot-tools

PPA_GENERIC_VARIANT = $(call qstrip,$(BR2_PACKAGE_PPA_GENERIC_VARIANT))
PPA_GENERIC_PLATFORM = $(call qstrip,$(BR2_PACKAGE_PPA_GENERIC_PLATFORM))

define PPA_GENERIC_BUILD_CMDS
	cd $(@D)/ppa/ && CROSS_COMPILE=$(TARGET_CROSS) ./build $(PPA_GENERIC_VARIANT)-fit $(PPA_GENERIC_PLATFORM)
endef

define PPA_GENERIC_INSTALL_IMAGES_CMDS
	cp $(@D)/ppa/soc-$(PPA_GENERIC_PLATFORM)/build/obj/ppa.itb $(BINARIES_DIR)/
endef

$(eval $(generic-package))
