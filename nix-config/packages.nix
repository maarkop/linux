{ config, pkgs, ... } : {

  nixpkgs.config.allowUnfree = true;
  services.flatpak.enable = true;

  environment.systemPackages = with pkgs;[
		neovim fish git flatpak
		gcc storj-uplink
		wl-clipboard

		#Gnome
		jetbrains-mono
		gnome-extension-manager
		dconf dconf-editor
		
		#Flutter
		clang cmake ninja openjdk21
		pkg-config android-studio
		flutter android-tools
		steam-run
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

	programs.fish = {
		enable = true;
		shellAliases = {
			flutter = "steam-run flutter";
		};
	};

	services.xserver.excludePackages = (with pkgs; [ xterm ]);
}
