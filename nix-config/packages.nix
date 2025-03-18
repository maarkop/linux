{ config, pkgs, ... } : {

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;
	documentation.nixos.enable = false;
	services.printing.enable = false;


  environment.systemPackages = with pkgs;[
		neovim fish git flatpak
		gcc storj-uplink
		wl-clipboard
		firebase-tools

		#Gnome
		jetbrains-mono
		gnome-extension-manager
		dconf dconf-editor
		deluge
		vlc
		
		#Flutter
		clang cmake ninja openjdk21
		pkg-config android-studio
		flutter android-tools
		steam-run google-chrome
	];

  services.flatpak.packages = [
    "app.zen_browser.zen"
		"app.drey.EarTag"
		"com.github.tchx84.Flatseal"
  ];


	environment.gnome.excludePackages = (with pkgs; [
		cheese
		snapshot
		epiphany
		geary
		gedit
		gnome-shell-extensions
		gnome-characters
		gnome-music
		gnome-photos
		gnome-tour
		gnome-contacts
		gnome-maps
		totem
		simple-scan
		seahorse
		yelp
	]);

	programs.fish = {
		enable = true;
		shellAliases = {
			flutter = "steam-run flutter";
		};
	};

	services.xserver.excludePackages = (with pkgs; [ xterm ]);
}
