{ ... } : {
  programs.bash.promptInit = ''
    PS1="[ \w ] \$\[\033[0m\] "
    eval "$(fzf --bash)"
    bind -x '"\C-p": __fzf_history__'
  '';
}
