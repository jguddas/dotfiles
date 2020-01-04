function __promptline {
  local esc=$'['
  PROMPT="$(__promptline_prompt)"
}

function __promptline_prompt {
  if hash git 2>/dev/null; then
    if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null ); then
      branch=${branch##*/}
      if [[ $KEYMAP = vicmd || -n $finish ]]; then
        printf "%s" "%{${esc}1m%}%{${esc}7m%}%{${esc}108m%}%{${esc}92m%}"
      else
        printf "%s" "%{${esc}1m%}%{${esc}7m%}%{${esc}108m%}%{${esc}94m%}"
      fi
      printf "%s" " ${branch:-unknown} "
      printf "%s" "%{${esc}0m%}"
    fi
  fi
  if [[ "$PWD" == "$HOME" ]]; then
    printf "%s" "%{${esc}100m%} ~ %{${esc}0m%} "
  else
    printf "%s" "%{${esc}100m%} ${PWD/#$HOME/~} %{${esc}0m%} "
  fi
}

function zle-keymap-select {
  __promptline
  zle reset-prompt
  if [ $KEYMAP = vicmd ]; then
    printf "\033[2 q"
  else
    printf "\033[6 q"
  fi
}

function zle-line-finish {
  local finish=true
  __promptline
  zle reset-prompt
}

function zle-line-init {
  printf "\033[6 q"
  TRAPWINCH () {
    __promptline
    zle reset-prompt
  }
}

if [[ ! ${precmd_functions[(r)__promptline]} == __promptline ]]; then
  precmd_functions+=(__promptline)
  TRAPCHLD () {
    __promptline
    zle reset-prompt
  }
fi

printf "\033[6 q"

zle -N zle-keymap-select
zle -N zle-line-finish
zle -N zle-line-init
