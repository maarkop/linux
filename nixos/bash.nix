{ ... } : {
  programs.bash.promptInit = ''
    PROMPT_COLOR="1;31m"
    ((UID)) && PROMPT_COLOR="1;32m"
    PS1="\[\033[$PROMPT_COLOR\][ \w ]\\$\[\033[0m\] "
    
    eval "$(fzf --bash)"
  '';
}
