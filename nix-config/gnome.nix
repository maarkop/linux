{ config, pkgs, ... } : {
	 environment.systemPackages = with pkgs.gnomeExtensions; [
    system-monitor
    blur-my-shell
    tiling-shell
  ];

}
