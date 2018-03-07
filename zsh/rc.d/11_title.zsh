#### Window Title
title () {
  # escape '%' chars in $1, make nonprintables visible
  a=${(V)1//\%/\%\%}

  # Strip newlines from command
  a=$(print -Pn "%70>...>$a" | tr -d "\n")
  local xtermtitle="\e]2;$2 $a\a"

  case $TERM in
  screen*)
    print -Pn "$xtermtitle" # plain xterm title
    print -Pn "\ek$a\e\\"      # screen title (in ^A")
    print -Pn "\e_$2   \e\\"   # screen location
    ;;
  xterm*|rxvt*)
    print -Pn "$xtermtitle" # plain xterm title
    ;;
  esac
}

TITLE_LOCATION="[%m:%~]"

# precmd is called just before the prompt is printed
function jake-precmd {
    title "zsh" "$TITLE_LOCATION"
    vcs_info
}

# preexec is called just before any command line is executed
function jake-preexec() {
  title '$1' "$TITLE_LOCATION"
}

#### Add ZSH pre-command hook
add-zsh-hook precmd jake-precmd
add-zsh-hook preexec jake-preexec
