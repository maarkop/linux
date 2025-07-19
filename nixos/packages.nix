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
    fzf bombadillo fragments addwater amberol 
    gnome-disk-utility gnome-system-monitor gcc
    syncthing eartag retroarchFull lazygit foliate
    nautilus loupe baobab celluloid ptyxis
    ffmpeg imagemagick optipng jpegoptim 
	];

  services.flatpak = {
    enable = true;
    packages = [ "org.vinegarhq.Sober" ];
  };

	services.xserver.excludePackages = [ pkgs.xterm ];
  environment.gnome.excludePackages = [ pkgs.gnome-tour ];
}
