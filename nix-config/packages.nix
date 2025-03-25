{ config, pkgs, ... } : {

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
	documentation.nixos.enable = false;
	services.printing.enable = false;

  environment.systemPackages = with pkgs;[
		#System
		fish flatpak zsh
		storj-uplink

		#Gnome
		nerd-fonts.jetbrains-mono
		gnome-extension-manager
		dconf dconf-editor gnome-tweaks

		#Development
		neovim git gcc 
		wl-clipboard
		
		#Flutter
		android-studio
		firebase-tools
		flutter openjdk17
		steam-run google-chrome

		#Media
		deluge vlc

		#Games
		retroarchFull
	];

	fonts.packages = [ pkgs.nerd-fonts.jetbrains-mono ];

  services.flatpak.packages = [
    "app.zen_browser.zen"
		"app.drey.EarTag"
		"com.github.tchx84.Flatseal"
  ];



	programs.fish = {
		enable = true;
		shellAliases = {
			#flutter = "steam-run flutter";
		};
		shellInit = ''
      export JAVA_HOME="${pkgs.openjdk17.home}"
			export CHROME_EXECUTABLE="${pkgs.google-chrome}/bin/google-chrome-stable"
    '';
	};

	  fonts.fontconfig.enable = true;

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
