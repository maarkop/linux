{ pkgs, ... } : {
  services.gnome.core-apps.enable = false;
	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;
  programs.firefox.enable = true;
  programs.git.enable = true;

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };

  environment.systemPackages = with pkgs; [
    gnome-disk-utility gnome-system-monitor gcc
    nautilus loupe gnome-console baobab celluloid 
    syncthing eartag retroarchFull lazygit foliate
    fzf bombadillo fragments addwater amberol 
    ffmpeg imagemagick optipng jpegoptim
    blackbox-terminal
	];

  services.flatpak = {
    enable = true;
    packages = [ "org.vinegarhq.Sober" ];
  };

	services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
}
