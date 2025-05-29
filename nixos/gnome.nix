{ config, pkgs, lib, ... }: {
  environment.systemPackages = (with pkgs.gnomeExtensions; [
    system-monitor
    blur-my-shell
    tiling-shell
		just-perfection
		app-icons-taskbar
  ]) ++ (with pkgs; [
		nerd-fonts.jetbrains-mono
		gnome-extension-manager
		dconf dconf-editor gnome-tweaks
		wl-clipboard
  ]);
	
	fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

	fonts.fontconfig = {
		enable = true;
		defaultFonts = {
			monospace = [ "JetBrainsMono Nerd Font Mono Semi-Bold" ];
			sansSerif = [ "JetBrainsMono Nerd Font Mono Semi-Bold" ];
			serif = [ "JetBrains MonoNerd Font Mono Semi-Bold" ];
		};
	};


	programs.dconf.profiles = {
    user.databases = [{
      settings = with lib.gvariant; {
        "org/gnome/desktop/calendar".show-weekdate = true;
        "org/gnome/desktop/input-sources".sources = [
          (mkTuple [ "xkb" "us" ])
          (mkTuple [ "xkb" "lt" ])
        ];
        "org/gnome/desktop/media-handling".automount = false;
        "org/gnome/desktop/peripherals/mouse".accel-profile = "flat";
        "org/gnome/desktop/privacy".remember-recent-files = false;
        "org/gnome/desktop/screensaver".lock-enabled = false;
        "org/gnome/desktop/session".idle-delay = mkUint32 0;
        "org/gnome/desktop/wm/preferences".resize-with-right-button = true;

        "io/github/celluloid-player/celluloid".always-open-new-window = true;
        "io/bassi/Amberol".background-play = false;

        "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
          binding = "<Super>Return";
          command = "kgx";
          name = "Terminal";
        };

        "org/gnome/settings-daemon/plugins/media-keys".custom-keybindings = [
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        ];

        "org/gnome/desktop/wm/keybindings" = {
          maximize = [ "<Super>f" ];
        };

        "org/gnome/shell/keybindings" = {
          # Following binds are replaced by the ones above.
          toggle-application-view = mkEmptyArray type.string;
          switch-to-application-1 = mkEmptyArray type.string;
          switch-to-application-2 = mkEmptyArray type.string;
          switch-to-application-3 = mkEmptyArray type.string;
          switch-to-application-4 = mkEmptyArray type.string;

          show-screen-recording-ui = mkEmptyArray type.string;
          screenshot = mkEmptyArray type.string;
          show-screenshot-ui = [ "<Shift><Super>s" ];
          screenshot-window = mkEmptyArray type.string;
        };

        "org/gnome/shell".enabled-extensions = with pkgs.gnomeExtensions; [
					blur-my-shell.extensionUuid
					just-perfection.extensionUuid
					app-icons-taskbar.extensionUuid
        ];
        "org/gnome/shell".disabled-extensions = [
          "dash-to-dock@micxgx.gmail.com"
          "window-list@gnome-shell-extensions.gcampax.github.com"
          "windowsNavigator@gnome-shell-extensions.gcampax.github.com"
          "light-style@gnome-shell-extensions.gcampax.github.com"
          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "apps-menu@gnome-shell-extensions.gcampax.github.com"
          "emoji-copy@felipeftn"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "status-icons@gnome-shell-extensions.gcampax.github.com"
        ];
        "org/gnome/shell/extensions/blur-my-shell".color-and-noise = false;
        "org/gnome/shell/extensions/blur-my-shell/applications".blur = false;
				"org/gnome/shell/extensions/blur-my-shell/panel" = {
					blur = true;
					sigma = "0";
					static-blur = false;
					style-panel = "3";
				};
				"org/gnome/shell/extensions/just-perfection" = {
					dash = false;
					power-icon = false;
					search = false;
				};
        "org/gnome/shell/extensions/aztaskbar".notification-badges = false;

				"org/gnome/desktop/interface" = {
					monospace-font-name = [ "JetBrainsMono Nerd Font Mono Semi-Bold 10" ];
					document-font-name = [ "JetBrainsMono Nerd Font Mono Semi-Bold 10" ];
					font-name = [ "JetBrainsMono Nerd Font Mono Semi-Bold 10" ];
				};
				"org/gnome/desktop/wm/preferences" = {
					titlebar-font = "JetBrainsMono Nerd Font Mono Semi-Bold 10";
				};
      };
    }];
  };

}
