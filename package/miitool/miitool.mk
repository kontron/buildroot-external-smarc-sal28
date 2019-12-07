################################################################################
#
# miitool
#
################################################################################

MIITOOL_VERSION = 1.1
MIITOOL_SITE = $(call github,kontron,miitool,$(MIITOOL_VERSION))
MIITOOL_LICENSE = BSD-2c
MIITOOL_LICENSE_FILES = COPYING

define MIITOOL_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define MIITOOL_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
