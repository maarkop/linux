{ config, pkgs, ... } : {

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs;[
		neovim fish git flatpak
		gcc
		dconf-editor
		storj-uplink
		flutter
		wl-clipboard
		jetbrains-mono
		gnome-tweaks
		gnomeExtensions.blur-my-shell
		gnome-extension-manager
		dconf
	];

  services.flatpak.packages = [
    "app.zen_browser.zen"
		"com.google.AndroidStudio"
  ];
}
