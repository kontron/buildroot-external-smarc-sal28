################################################################################
#
# smarc-sal28-devicetree
#
################################################################################

SMARC_SAL28_DEVICETREE_VERSION = a1b916e02cac4ad8becbfd0cee6883593947db2f
SMARC_SAL28_DEVICETREE_SITE = $(call github,kontron,devicetree-smarc-sal28,$(SMARC_SAL28_DEVICETREE_VERSION))
SMARC_SAL28_DEVICETREE_LICENSE = BSD-2-Clause
SMARC_SAL28_DEVICETREE_LICENSE_FILES = COPYING
SMARC_SAL28_DEVICETREE_INSTALL_TARGET = NO
SMARC_SAL28_DEVICETREE_INSTALL_IMAGES = YES

define SMARC_SAL28_DEVICETREE_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)
endef

define SMARC_SAL28_DEVICETREE_INSTALL_IMAGES_CMDS
	mkdir -p $(BINARIES_DIR)/overlays
	$(MAKE) -C $(@D) install-overlays DEVICETREEDIR=$(BINARIES_DIR)/overlays
endef

$(eval $(generic-package))
