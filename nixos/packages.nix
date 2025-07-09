{ pkgs, ... } : {
  services.input-remapper.enable = true;
	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;
  programs.firefox.enable = true;
  programs.git.enable = true;
  
  services.i2p.enable = true;

  networking.firewall.allowedTCPPorts = [ 
    4444 7657 #I2P 
    22000     #Syncthing 
  ];

  networking.firewall.allowedUDPPorts = [ 
    21027     #Syncthing 
    42410     #I2P Custom
  ];

  environment.etc."i2p/router.config".text = ''
    i2np.udp.internalPort=42410
    i2np.udp.port=42410
  '';

  programs.steam = {
    enable = true;
    extraCompatPackages = [ pkgs.proton-ge-bin ];
  };
  
  environment.systemPackages = with pkgs;[
    gcc fzf bombadillo vlc fragments eartag 
    ffmpeg imagemagick optipng jpegoptim
		retroarchFull kooha lazygit foliate
    storj-uplink addwater amberol
    syncthing
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
