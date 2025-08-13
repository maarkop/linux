{ ... } : {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";
  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
      xkb.variant = "";
      xkb.layout = "us";
    };
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    displayManager = {
      gdm.enable = true;
      autoLogin = {
        enable = true;
        user = "marko";
      };
    };
  };

  users.users.marko = {
    isNormalUser = true;
    description = "Marko";
    extraGroups = [ "networkmanager" "wheel" "adbusers" "kvm" "libvirtd"];
  };

  systemd.services = {
    "getty@tty1".enable = false;
    "autovt@tty1".enable = false;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  system.stateVersion = "24.11"; 

  virtualisation.docker.enable = true;
  users.extraGroups.docker.members = [ "marko" ];
  programs.mtr.enable = true;
}
