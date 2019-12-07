################################################################################
#
# keapi-ktool
#
################################################################################

KEAPI_KTOOL_VERSION = 3.0.1
KEAPI_KTOOL_SITE = $(call github,kontron,keapi-ktool,$(KEAPI_KTOOL_VERSION))
KEAPI_KTOOL_LICENSE = BSD-3-Clause
KEAPI_KTOOL_LICENSE_FILES = LICENSE
KEAPI_KTOOL_DEPENDENCIES = jansson libatasmart pcre
KEAPI_KTOOL_AUTORECONF = YES

define KEAPI_KTOOL_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) all
endef

define KEAPI_KTOOL_INSTALL_TARGET_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D) DESTDIR=$(TARGET_DIR) install
endef

$(eval $(generic-package))
