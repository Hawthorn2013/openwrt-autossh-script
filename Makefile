include $(TOPDIR)/rules.mk

PKG_NAME:=autossh-scripts
PKG_VERSION:=1.4e
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/$(PKG_NAME)
  Section:=net
  CATEGORY:=Network
  TITLE:=AutoSSH scripts
  URL:=https://github.com/Hawthorn2013/openwrt-autossh-scripts
  SUBMENU:=SSH
  DEPENDS:=autossh-bin
endef

define Package/$(PKG_NAME)/description
  AutoSSH scripts
  Manipulate autossh binary with openwrt script interface.
endef

define Build/Compile
	$(CP) ./files $(PKG_BUILD_DIR)
endef

define Package/$(PKG_NAME)/conffiles
/etc/config/autossh
endef

define Package/$(PKG_NAME)/install
	$(INSTALL_DIR) $(1)/etc/hotplug.d/iface
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/autossh.hotplug $(1)/etc/hotplug.d/iface/20-autossh
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) $(PKG_BUILD_DIR)/files/autossh.init $(1)/etc/init.d/autossh
	$(INSTALL_DIR) $(1)/etc/config
	$(INSTALL_CONF) $(PKG_BUILD_DIR)/files/autossh.config $(1)/etc/config/autossh
endef

$(eval $(call BuildPackage,$(PKG_NAME)))
