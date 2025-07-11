{ pkgs, ... } : {
  environment.systemPackages = with pkgs; [ 
    usbutils opensc pcsclite pcsc-tools
    ccid gnupg openssl p11-kit
  ];
  services.pcscd.enable = true;
}

