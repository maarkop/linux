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
    gcc fzf bombadillo vlc deluge eartag 
		retroarchFull kooha lazygit
    ffmpeg imagemagick optipng jpegoptim
    storj-uplink
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
		gnome-maps simple-scan gnome-characters yelp
    gnome-contacts gnome-music gnome-photos
		cheese snapshot gnome-shell-extensions
		geary gedit totem seahorse gnome-tour
	];
}
