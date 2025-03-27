{ config, pkgs, ... } : {

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
	documentation.nixos.enable = false;
	services.printing.enable = false;

  environment.systemPackages = with pkgs;[
		#System
		fish flatpak zsh
		storj-uplink ntfs3g

		#Gnome
		nerd-fonts.jetbrains-mono
		gnome-extension-manager
		dconf dconf-editor gnome-tweaks

		#Development
		neovim git gcc 
		wl-clipboard
		
		#Flutter
		firebase-tools
		flutter openjdk17
		steam-run google-chrome
		waydroid sdkmanager

		#Media
		deluge vlc

		#Games
		retroarchFull
	];


  services.flatpak.packages = [
    "app.zen_browser.zen"
		"app.drey.EarTag"
		"com.github.tchx84.Flatseal"
  ];

	services.xserver.excludePackages = (with pkgs; [ xterm ]);

	environment.gnome.excludePackages = (with pkgs; [
		geary gedit totem seahorse
		gnome-tour gnome-contacts
		gnome-music gnome-photos
		cheese snapshot epiphany
		gnome-shell-extensions
		gnome-maps simple-scan
		gnome-characters yelp
	]);
}
