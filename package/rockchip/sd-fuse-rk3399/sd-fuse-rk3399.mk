################################################################################
#
# sd_fuse-rk3399
#
################################################################################
SD_FUSE_RK3399_VERSION = 76419a4e80c57a81239cd9dfc279d72572c952c7
SD_FUSE_RK3399_SITE =  $(call github,friendlyarm,sd-fuse_rk3399,$(SD_FUSE_RK3399_VERSION))
SD_FUSE_RK3399_LICENSE = GPL-2.0+
SD_FUSE_RK3399_DEPENDENCIES = linux uboot
SD_FUSE_RK3399_INSTALL_IMAGES = YES


define SD_FUSE_RK3399_INSTALL_IMAGES_CMDS
   

  $(INSTALL) -d $(BINARIES_DIR)/sd-fuse-rk3399/out
  $(INSTALL) -d $(BINARIES_DIR)/sd-fuse-rk3399/buildroot
  $(INSTALL) -d $(BINARIES_DIR)/sd-fuse-rk3399/tools
  $(INSTALL) -D -m 0755 $(@D)/*.sh $(BINARIES_DIR)/sd-fuse-rk3399
  $(INSTALL) -D -m 0755 $(@D)/tools/* $(BINARIES_DIR)/sd-fuse-rk3399/tools
  $(INSTALL) -D -m 0444 $(@D)/prebuilt/idbloader.img $(BINARIES_DIR)/sd-fuse-rk3399/buildroot
  $(INSTALL) -D -m 0444 $(@D)/prebuilt/generic/*.txt $(BINARIES_DIR)/sd-fuse-rk3399/buildroot
  
  cp $(LINUX_DIR)/kernel.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
  cp $(LINUX_DIR)/resource.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
  cp $(UBOOT_DIR)/uboot.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot
  cp $(UBOOT_DIR)/trust.img ${BINARIES_DIR}/sd-fuse-rk3399/buildroot  
  cp $(UBOOT_DIR)/rk3399_loader_v1.12.109.bin ${BINARIES_DIR}/sd-fuse-rk3399/buildroot/MiniLoaderAll.bin

  
endef

$(eval $(generic-package))
