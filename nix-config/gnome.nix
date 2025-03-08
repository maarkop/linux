{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs.gnomeExtensions; [
    system-monitor
    blur-my-shell
    tiling-shell
  ];

  programs.dconf = {
    enable = true;
    profiles = {
      user = {
        "org/gnome/shell" = {
          disable-user-extensions = false;
          enabled-extensions = with pkgs.gnomeExtensions; [
            blur-my-shell.extensionUuid
            tiling-shell.extensionUuid
            system-monitor.extensionUuid
          ];
          disabled-extensions = [
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
        };
      };
    };
  };
}
