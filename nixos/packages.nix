{ pkgs, lib, ... } : {
  services.gnome.core-utilities.enable = false;
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
    gnome-console blackbox
    nautilus baobab gnome-extension-manager
    gnome-disk-utility gnome-system-monitor
    loupe
	];

  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
    ];
  };

	services.xserver.excludePackages = [ pkgs.xterm ];
  environment = {
    defaultPackages = lib.mkForce [];
    gnome.excludePackages = [ pkgs.gnome-tour ];
  };
}
