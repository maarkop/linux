{ config, pkgs, ... } : {
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";
  security.rtkit.enable = true;

  services = {
    xserver = {
      enable = true;
      xkb.variant = "";
      xkb.layout = "us";
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
    pulseaudio.enable = false;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    displayManager.autoLogin = {
      enable = true;
      user = "marko";
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
}
