{ config, pkgs, ... } : {

	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs;[
		#System
		fish flatpak zsh i2p
		blackbox-terminal

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
		yt-dlp amberol
		zenity
	];


  services.flatpak.packages = [
		"com.github.tchx84.Flatseal"
    "app.zen_browser.zen"
		"app.drey.EarTag"
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
