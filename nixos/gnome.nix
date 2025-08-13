{ pkgs, lib, ... } : {
  environment.systemPackages = with pkgs.gnomeExtensions; [
    blur-my-shell just-perfection #app-icons-taskbar
  ];

  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features=['scale-monitor-framebuffer']
    '';
  };
  fonts = {
    packages = [ pkgs.nerd-fonts.jetbrains-mono ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        monospace = [ "JetBrainsMono Nerd Font Mono Semi-Bold" ];
        sansSerif = [ "JetBrainsMono Nerd Font Mono Semi-Bold" ];
        serif     = [ "JetBrains MonoNerd Font Mono Semi-Bold" ];
      };
    };
  };
	programs.dconf.profiles = {
    user.databases = [{
      settings = with lib.gvariant; {
        "org/gnome/desktop/input-sources".sources = [ (mkTuple [ "xkb" "us" ]) ];
        "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
        "org/gnome/desktop/privacy".remember-recent-files = false;
        "org/gnome/desktop/screensaver".lock-enabled = false;
        "org/gnome/desktop/session".idle-delay = mkUint32 0;
        "org/gnome/desktop/wm/keybindings" = { maximize = [ "<Super>f" ]; };
        "org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
					blur-my-shell.extensionUuid
					just-perfection.extensionUuid
        ];
        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          name = "Terminal";
          command = "blackbox";
          binding = "<Super>Return";
        };
        "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];
        "org/gnome/shell".disabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "window-list@gnome-shell-extensions.gcampax.github.com"
          "light-style@gnome-shell-extensions.gcampax.github.com"
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
          "status-icons@gnome-shell-extensions.gcampax.github.com"
          "apps-menu@gnome-shell-extensions.gcampax.github.com"
          "emoji-copy@felipeftn"
        ];
        "org/gnome/shell".favorite-apps = [
          "org.gnome.Nautilus.desktop"
          "firefox.desktop"
          "steam.desktop"
          "com.raggesilver.BlackBox.desktop"
        ];
        "org/gnome/settings-daemon/plugins/color" = {
          night-light-enabled = true;
          night-light-schedule-automatic = false;
          night-light-schedule-from = 6.0;
          night-light-temperature = mkUint32 3532;
        };
				"org/gnome/shell/extensions/just-perfection" = {
          panel = false;
          panel-in-overview = true;
          panel-size = mkInt32 36;
				};
				"org/gnome/desktop/interface" = {
					monospace-font-name = "JetBrainsMono Nerd Font Bold 10";
					document-font-name  = "JetBrainsMono Nerd Font Bold 10";
					font-name           = "JetBrainsMono Nerd Font Bold 10";
				};
				"org/gnome/desktop/wm/preferences" = {
					titlebar-font = "JetBrainsMono Nerd Font Bold 10";
				};
        "dev/qwery/AddWater/Firefox" = {
          theme-enabled = true;
          tabs-as-headerbar = true;
        };
        "com/raggesilver/BlackBox" = {
          font = "JetBrainsMono Nerd Font Bold 10";
          show-headerbar = false;
          show-scrollbars = false;
          floating-controls = true;
        };
      };
    }];
  };
}
