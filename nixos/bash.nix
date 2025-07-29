{ ... } : {
  programs.bash.shellInit = ''
    __fzf_history__() {
      local selected
      selected=$(history | fzf +s --tac | sed 's/ *[0-9]* *//')
      # Inject selected command into shell input
      READLINE_LINE=$selected
      READLINE_POINT=\$\{#selected}
    }

    bind -x '"\C-p": __fzf_history__'
  '';
}
