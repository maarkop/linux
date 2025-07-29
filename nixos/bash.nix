{ ... } : {
  programs.bash.promptInit = ''
    PS1="[ \w ] \$\[\033[0m\] "
    eval "$(fzf --bash)"
  '';
}
