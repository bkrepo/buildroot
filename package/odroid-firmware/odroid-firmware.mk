################################################################################
#
# odroid-firmware
#
################################################################################

ifeq ($(BR2_PACKAGE_ODROID_FIRMWARE_XU4),y)
ODROID_FIRMWARE_VERSION = 503a120465ae3e43008366005f3a8c278215b354
endif
ODROID_FIRMWARE_SITE = $(call github,hardkernel,u-boot_firmware,$(ODROID_FIRMWARE_VERSION))
ODROID_FIRMWARE_INSTALL_IMAGES = YES

ifeq ($(BR2_PACKAGE_ODROID_FIRMWARE_XU4),y)
define ODROID_FIRMWARE_INSTALL_IMAGES_CMDS
	$(INSTALL) -D -m 0644 $(@D)/bl1.bin.hardkernel $(BINARIES_DIR)/odroid-firmware/bl1.bin
	$(INSTALL) -D -m 0644 $(@D)/bl2.bin.hardkernel $(BINARIES_DIR)/odroid-firmware/bl2.bin
	$(INSTALL) -D -m 0644 $(@D)/tzsw.bin.hardkernel $(BINARIES_DIR)/odroid-firmware/tzsw.bin
endef
endif

$(eval $(generic-package))
