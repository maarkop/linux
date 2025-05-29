{ pkgs, ... } : {
	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;
  services.flatpak.enable = true;
	programs.steam.enable = true;

  environment.systemPackages = with pkgs;[
		#System
		i2p rclone git gcc fzf

		#Media
		storj-uplink deluge
		retroarchFull vlc
		zenity eartag 
		bombadillo
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
