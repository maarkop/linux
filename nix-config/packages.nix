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
		gnome-extension-manager
		dconf
	];

  services.flatpak.packages = [
    "app.zen_browser.zen"
		"com.google.AndroidStudio"
  ];

	environment.gnome.excludePackages = (with pkgs; [
		cheese
		epiphany
		geary
		gedit
		gnome-characters
		gnome-music
		gnome-photos
		gnome-tour
		gnome-contacts
		gnome-maps
		totem
		simple-scan
	]);

	services.xserver.excludePackages = (with pkgs; [
		xterm
	]);
}
