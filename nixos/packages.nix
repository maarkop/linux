{ config, pkgs, ... } : {

	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;
  services.flatpak.enable = true;
	programs.steam.enable = true;

  environment.systemPackages = with pkgs;[
		#System
		fish flatpak zsh i2p
		blackbox-terminal fzf rclone

		#Gnome
		nerd-fonts.jetbrains-mono
		gnome-extension-manager
		dconf dconf-editor gnome-tweaks
		wl-clipboard

		#Development
		neovim git gcc
		
		#Flutter
		openjdk17 unzip firebase-tools
		steam-run waydroid sdkmanager
		clang cmake ninja pkg-config

		#Media
		storj-uplink deluge
		retroarchFull vlc
		zenity eartag 
		metadata-cleaner
	];


  services.flatpak.packages = [
		"com.github.tchx84.Flatseal"
    "app.zen_browser.zen"
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
