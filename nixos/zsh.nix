{ config, pkgs, ... } : let
	home = config.users.users.marko.home;
	zshDir = "${home}/.cache/zsh";
in {
	environment = {
		etc."powerlevel10k/p10k.zsh".source = ./p10k.zsh;
    variables = { ZDOTDIR = zshDir; };
    systemPackages = with pkgs; [ zsh-powerlevel10k];
	};

  users.defaultUserShell = pkgs.zsh;

	programs.zsh = {
    enable = true;
    histSize = 10000;
    enableCompletion = true;
    enableBashCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
		histFile = "${zshDir}/.zsh_history";
		shellInit = ''
			mkdir -p ${zshDir}
			touch ${zshDir}/.zshrc
			touch ${zshDir}/.zsh_history
			#unset ZSH_NEW_USER_INIT
		'';
    promptInit = ''
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
			source /etc/powerlevel10k/p10k.zsh

      setopt HIST_IGNORE_SPACE
      eval "$(fzf --zsh)"

      bindkey '^P' fzf-history-widget

      if [[ -r "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-''$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

    '';
  };
}
