################################################################################
#
# tsntool
#
################################################################################

TSNTOOL_VERSION = LSDK-20.12
TSNTOOL_SITE = $(call github,nxp-qoriq,tsntool,$(TSNTOOL_VERSION))
TSNTOOL_LICENSE = MIT or GPL-2.0+
TSNTOOL_LICENSE_FILES = LICENSE
TSNTOOL_INSTALL_STAGING = YES
TSNTOOL_DEPENDENCIES = linux-headers libnl readline ncurses cjson

define TSNTOOL_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) build
endef

define TSNTOOL_INSTALL_STAGING_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) DESTDIR=$(STAGING_DIR) install
endef

define TSNTOOL_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
