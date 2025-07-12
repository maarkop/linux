{ ... } : {

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };
  services.i2p.enable = true;

  networking.firewall.allowedTCPPorts = [ 
    4444 7657 #I2P 
    22000     #Syncthing 
    42410     #I2P Custom
  ];

  networking.firewall.allowedUDPPorts = [ 
    21027     #Syncthing 
    42410     #I2P Custom
  ];

  environment.etc."i2p/router.config".text = ''
    i2np.udp.internalPort=42410
    i2np.udp.port=42410
  '';

}
