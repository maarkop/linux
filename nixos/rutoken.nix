{ pkgs, ... } : {
  environment.systemPackages = with pkgs; [ 
    usbutils opensc pcscd pcsc-tools
    ccid gnupg openssl p11-kit
  ];
}

