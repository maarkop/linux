{ config, pkgs, ... } : {

	documentation.nixos.enable = false;
  nixpkgs.config.allowUnfree = true;
	services.printing.enable = false;
  services.flatpak.enable = true;
	programs.steam.enable = true;

  environment.systemPackages = with pkgs;[
		#System
		i2p zinit fzf
		blackbox-terminal rclone

		#Gnome
		nerd-fonts.jetbrains-mono
		gnome-extension-manager
		dconf dconf-editor gnome-tweaks
		wl-clipboard

		#Development
		neovim git gcc
		
		#Flutter
		openjdk17 unzip firebase-tools
		steam-run waydroid sdkmanager
		clang cmake ninja pkg-config

		#Media
		storj-uplink deluge
		retroarchFull vlc
		zenity eartag 
		bombadillo

		#ZSH
		zsh-powerlevel10k
	];


  services.flatpak.packages = [
		"com.github.tchx84.Flatseal"
    "app.zen_browser.zen"
  ];

	services.xserver.excludePackages = (with pkgs; [ xterm ]);

	environment.gnome.excludePackages = (with pkgs; [
		geary gedit totem seahorse
		gnome-tour gnome-contacts
		gnome-music gnome-photos
		cheese snapshot epiphany
		gnome-shell-extensions
		gnome-maps simple-scan
		gnome-characters yelp
	]);

	environment.etc."powerlevel10k/p10k.zsh".source = ./p10k.zsh;

	programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
		shellInit = ''
    	unset ZSH_NEW_USER_INIT
		'';
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
			source /etc/powerlevel10k/p10k.zsh

      # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
      # Initialization code that may require console input (password prompts, [y/n]
      # confirmations, etc.) must go above this block; everything else may go below.
      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

    '';
  };

}
