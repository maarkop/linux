{ pkgs, ... } : {
  services.input-remapper.enable = true;
	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;
  programs.firefox.enable = true;
  programs.git.enable = true;
  services.i2p.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  
  environment.systemPackages = with pkgs;[
		rclone deluge eartag 
    gcc fzf bombadillo
		retroarchFull vlc
    kooha
	];

  services.flatpak = {
    enable = true;
    packages = [
		  "com.github.tchx84.Flatseal"
      "app.zen_browser.zen"
    ];
  };

	services.xserver.excludePackages = [ pkgs.xterm ];
	environment.gnome.excludePackages = with pkgs; [
		geary gedit totem seahorse
		gnome-tour gnome-contacts
		gnome-music gnome-photos
		cheese snapshot epiphany
		gnome-shell-extensions
		gnome-maps simple-scan
		gnome-characters yelp
	];
}
