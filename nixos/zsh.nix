{ config, pkgs, ... } : let
	home = config.users.users.marko.home;
	zshDir = "${home}/.local/share/zsh";
in {

	environment = {
		etc."powerlevel10k/p10k.zsh".source = ./p10k.zsh;
		variables = {ZDOTDIR = "${zshDir}";};
	};

	programs.zsh = {
    enable = true;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    histSize = 10000;
		histFile = "${zshDir}/.zsh_history";
		shellInit = ''
			mkdir -p ${zshDir}
			touch ${zshDir}/.zsh_history
			touch ${zshDir}/.zshrc
			#unset ZSH_NEW_USER_INIT
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
