{ config, pkgs, ... } : {

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs;[
		neovim fish git flatpak
		gcc
		dconf-editor
		storj-uplink
		wl-clipboard
		jetbrains-mono
		gnome-tweaks
		gnome-extension-manager
		dconf
		
		clang cmake ninja openjdk17
		pkg-config android-studio
		flutter android-tools
	];

  services.flatpak.packages = [
    "app.zen_browser.zen"
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
