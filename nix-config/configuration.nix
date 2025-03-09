{ config, pkgs, ... } : {

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Belgrade";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.marko = {
    isNormalUser = true;
    description = "Marko";
    extraGroups = [ "networkmanager" "wheel" "adbusers"];
    packages = with pkgs; [];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "marko";
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;

  nix.settings.experimental-features = [ "nix-command" "flakes"];
  users.defaultUserShell = "/run/current-system/sw/bin/fish";
  system.stateVersion = "24.11"; 

}
