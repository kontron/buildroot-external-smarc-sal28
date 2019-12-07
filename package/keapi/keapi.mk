################################################################################
#
# keapi
#
################################################################################

KEAPI_VERSION = 3.0.6
KEAPI_SITE = $(call github,kontron,keapi,$(KEAPI_VERSION))
KEAPI_LICENSE = BSD-3-Clause
KEAPI_LICENSE_FILES = LICENSE
KEAPI_DEPENDENCIES = jansson libatasmart pcre
KEAPI_INSTALL_STAGING = YES
KEAPI_AUTORECONF = YES

# Autoreconf step fails due to missing m4 directory
define KEAPI_CREATE_M4_DIR
	mkdir -p $(@D)/m4
endef
KEAPI_PRE_CONFIGURE_HOOKS += KEAPI_CREATE_M4_DIR

$(eval $(autotools-package))
