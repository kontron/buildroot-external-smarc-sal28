################################################################################
#
# tsntool
#
################################################################################

TSNTOOL_VERSION = LSDK-19.09
TSNTOOL_SITE = https://source.codeaurora.org/external/qoriq/qoriq-components/tsntool
TSNTOOL_SITE_METHOD = git
TSNTOOL_LICENSE = MIT or GPL-2.0+
TSNTOOL_LICENSE_FILES = LICENSE
TSNTOOL_INSTALL_STAGING = YES
TSNTOOL_DEPENDENCIES = linux-headers libnl readline ncurses cjson

define TSNTOOL_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) build
endef

define TSNTOOL_INSTALL_STAGING_CMDS
	$(INSTALL) -D -m 0644 $(@D)/include/tsn/genl_tsn.h $(STAGING_DIR)/usr/include/tsn/genl_tsn.h
	$(INSTALL) -D -m 0644 $(@D)/libtsn.so $(STAGING_DIR)/usr/lib/libtsn.so
endef

define TSNTOOL_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/libtsn.so $(TARGET_DIR)/usr/lib/libtsn.so
	$(INSTALL) -D -m 0755 $(@D)/tsntool $(TARGET_DIR)/usr/bin/tsntool
endef

$(eval $(generic-package))
