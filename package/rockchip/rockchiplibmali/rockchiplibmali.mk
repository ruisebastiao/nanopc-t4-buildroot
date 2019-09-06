################################################################################
#
# rockchip libmali For Linux
#
################################################################################

ROCKCHIPLIBMALI_VERSION = 41a1cf80804839137dd2941514df09a2fb69efb1
ROCKCHIPLIBMALI_SITE = https://github.com/rockchip-linux/libmali.git

ROCKCHIPLIBMALI_SITE_METHOD = git
ROCKCHIPLIBMALI_LICENSE = MIT
ROCKCHIPLIBMALI_LICENSE_FILES = LICENSE.md
ROCKCHIPLIBMALI_INSTALL_STAGING = YES

ROCKCHIPLIBMALI_DEPENDENCIES = wayland libdrm

ROCKCHIPLIBMALI_PROVIDES = libgles libegl libgbm


define ROCKCHIPLIBMALI_RM_SO
	$(TARGET_DIR)/usr/lib/libmali* \
	$(TARGET_DIR)/usr/lib/libMali* \
	$(TARGET_DIR)/usr/lib/libEGL.so* \
	$(TARGET_DIR)/usr/lib/libgbm.so* \
	$(TARGET_DIR)/usr/lib/libGLESv1_CM.so* \
	$(TARGET_DIR)/usr/lib/libGLESv2.so* \
	$(TARGET_DIR)/usr/lib/libMaliOpenCL.so \
	$(TARGET_DIR)/usr/lib/libOpenCL.so \
	$(TARGET_DIR)/usr/lib/libwayland-egl.so* 
endef

define ROCKCHIPLIBMALI_RM_SO_STAGING	
	$(STAGING_DIR)/usr/lib/libmali* \
	$(STAGING_DIR)/usr/lib/libMali* \
	$(STAGING_DIR)/usr/lib/libEGL.so* \
	$(STAGING_DIR)/usr/lib/libgbm.so* \
	$(STAGING_DIR)/usr/lib/libGLESv1_CM.so* \
	$(STAGING_DIR)/usr/lib/libGLESv2.so* \
	$(STAGING_DIR)/usr/lib/libMaliOpenCL.so \
	$(STAGING_DIR)/usr/lib/libOpenCL.so \
	$(STAGING_DIR)/usr/lib/libwayland-egl.so*
endef

define ROCKCHIPLIBMALI_SET_SO_STAGING
	cp libmali-midgard-t86x-r14p0-gbm.so libmali.so && \
	ln -s libmali.so libMali.so && \
	patchelf --set-soname libmali.so libmali.so && \
	cp libmali-midgard-t86x-r14p0-gbm.so libEGL.so && \
	patchelf --set-soname libEGL.so libEGL.so && \
	ln -s libEGL.so libEGL.so.1 && \
	patchelf --set-soname libgbm.so.1.0.0 libgbm.so.1.0.0 && \
	ln -s libgbm.so.1.0.0 libgbm.so && \
	ln -s libgbm.so.1.0.0 libgbm.so.1 && \
	cp libmali-midgard-t86x-r14p0-gbm.so libGLESv1_CM.so && \
	patchelf --set-soname libGLESv1_CM.so libGLESv1_CM.so && \
	ln -s libGLESv1_CM.so libGLESv1_CM.so.1 && \
	cp libmali-midgard-t86x-r14p0-gbm.so libGLESv2.so && \
	patchelf --set-soname libGLESv2.so libGLESv2.so && \
	ln -s libGLESv2.so libGLESv2.so.2 && \
	cp libmali-midgard-t86x-r14p0-gbm.so libwayland-egl.so&& \
	patchelf --set-soname libwayland-egl.so libwayland-egl.so && \
	ln -s libwayland-egl.so libwayland-egl.so.1
endef


define ROCKCHIPLIBMALI_LINK_SO
	ln -s libmali.so libMali.so && \
	ln -s libmali.so libEGL.so && \
	ln -s libmali.so libEGL.so.1 && \
	ln -s libgbm.so.1.0.0 libgbm.so && \
	ln -s libgbm.so.1.0.0 libgbm.so.1 && \
	ln -s libmali.so libGLESv1_CM.so && \
	ln -s libmali.so libGLESv1_CM.so.1 && \
	ln -s libmali.so libGLESv2.so && \
	ln -s libmali.so libGLESv2.so.2 && \
	ln -s libmali.so libwayland-egl.so && \
	ln -s libmali.so libwayland-egl.so.1
endef



define ROCKCHIPLIBMALI_LINK_OPENCL_SO
	ln -s libmali.so libMaliOpenCL.so && \
	ln -s libmali.so libOpenCL.so
endef




ifeq ($(BR2_PACKAGE_RK3399),y)


define ROCKCHIPLIBMALI_INSTALL_TARGET_CMDS
	rm -f $(ROCKCHIPLIBMALI_RM_SO)
 	rm -f $(ROCKCHIPLIBMALI_RM_SO_STAGING)

# 	
 	$(INSTALL) -D -m 644 $(@D)/lib/aarch64-linux-gnu/libmali-midgard-t86x-r14p0-gbm.so $(STAGING_DIR)/usr/lib/
 	 	
 	
	$(INSTALL) -D -m 644 $(@D)/lib/aarch64-linux-gnu/libmali-midgard-t86x-r14p0-gbm.so $(TARGET_DIR)/usr/lib/

	
	$(TARGET_CC) -O2 -pipe -Wall -Werror -fPIC -I$(STAGING_DIR)/usr/include/libdrm -shared -L$(STAGING_DIR)/usr/lib/ -lmali-midgard-t86x-r14p0-gbm  $(@D)/src/gbm-wrapper.c -o $(@D)/lib/libgbm.so.1.0.0
	
	$(INSTALL) -D -m 644 $(@D)/lib/libgbm.so.1.0.0 $(STAGING_DIR)/usr/lib/
	
	$(INSTALL) -D -m 644 $(@D)/lib/libgbm.so.1.0.0 $(TARGET_DIR)/usr/lib/

	
	
	cd $(STAGING_DIR)/usr/lib/ && $(ROCKCHIPLIBMALI_SET_SO_STAGING) && cd -
	cd $(TARGET_DIR)/usr/lib/ && ln -s libmali-midgard-t86x-r14p0-gbm.so libmali.so && $(ROCKCHIPLIBMALI_LINK_SO) && $(ROCKCHIPLIBMALI_LINK_OPENCL_SO) && cd -

	
endef
endif

$(eval $(cmake-package))
