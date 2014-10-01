# Mostly borrowed from oh-my-zsh key-bindings.zsh
# Fixes tmux weirdness which breaks lots of special keys.

 bindkey "^[[3~" delete-char
 bindkey "^[3;5~" delete-char
 bindkey "\e[3~" delete-char
 bindkey "\e[1~" beginning-of-line     # Home
 bindkey "\e[4~" end-of-line     # End

 bindkey '^[[1;5C' forward-word     # [Ctrl-RightArrow] - move forward one word
 bindkey '^[[1;5D' backward-word    # [Ctrl-LeftArrow] - move backward one word

