################################################################################
#
# smarc-sal28-rcw
#
################################################################################

SMARC_SAL28_RCW_VERSION = 11
SMARC_SAL28_RCW_SITE = $(call github,kontron,rcw-smarc-sal28,v$(SMARC_SAL28_RCW_VERSION))
SMARC_SAL28_RCW_LICENSE = BSD-2-Clause
SMARC_SAL28_RCW_LICENSE_FILES = COPYING
SMARC_SAL28_RCW_INSTALL_TARGET = NO
SMARC_SAL28_RCW_INSTALL_IMAGES = YES
SMARC_SAL28_RCW_DEPENDENCIES = host-uboot-tools

SMARC_SAL28_RCW_VARIANT = $(call qstrip,$(BR2_PACKAGE_SMARC_SAL28_RCW_VARIANT))

define SMARC_SAL28_RCW_BUILD_CMDS
	MKIMAGE=$(HOST_DIR)/bin/mkimage $(MAKE) -C $(@D)/contrib all
endef

define SMARC_SAL28_RCW_INSTALL_IMAGES_CMDS
	mkdir -p $(BINARIES_DIR)/rcw/
	cp $(@D)/sl28-*.bin $(BINARIES_DIR)/rcw/
	cp $(@D)/contrib/update-rcw.img $(BINARIES_DIR)/
	ln -sf rcw/sl28-$(SMARC_SAL28_RCW_VARIANT).bin $(BINARIES_DIR)/rcw.bin
endef

$(eval $(generic-package))
