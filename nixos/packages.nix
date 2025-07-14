{ pkgs, ... } : {
  services.input-remapper.enable = true;
	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;
  programs.firefox.enable = true;
  programs.git.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  environment.systemPackages = with pkgs;[
    gcc fzf bombadillo celluloid fragments
    ffmpeg imagemagick optipng jpegoptim
    addwater amberol syncthing eartag 
		retroarchFull lazygit foliate
	];

  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
    ];
  };

	services.xserver.excludePackages = [ pkgs.xterm ];
	environment.gnome.excludePackages = with pkgs; [
		gnome-maps simple-scan gnome-characters yelp
    gnome-font-viewer gnome-logs gnome-connections
		cheese snapshot gnome-shell-extensions evince
    gnome-contacts gnome-music gnome-photos
		geary gedit totem seahorse gnome-tour
    decibels
	];
}
