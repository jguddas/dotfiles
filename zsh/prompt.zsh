function __promptline {

  local esc=$'[' end_esc=m
  local noprint='%{' end_noprint='%}'
  local wrap="$noprint$esc" end_wrap="$end_esc$end_noprint"

  local space=" "
  local sep=""
  local alt_sep="|"

  local reset="${wrap}0${end_wrap}"
  local reset_bg="${wrap}49${end_wrap}"
  local bold="${wrap}1${end_wrap}"
  local reset_bold="${wrap}0${end_wrap}"
  local a_fg="${wrap}30${end_wrap}"
  local a_bg="${wrap}102${end_wrap}"
  local a_sep_fg="${wrap}92${end_wrap}"
  local name=$USER
  if [[ $KEYMAP = vicmd || -n $finish ]]; then
  else
    local a_bg="${wrap}104${end_wrap}"
    local a_sep_fg="${wrap}94${end_wrap}"
  fi
  local b_fg="${wrap}37${end_wrap}"
  local b_bg="${wrap}100${end_wrap}"
  local b_sep_fg="${wrap}90${end_wrap}"
  PROMPT="$(__promptline_prompt)"
}
function __promptline_wrapper {
  [[ -n "$1" ]] || return 1
  printf "%s" "${2}${1}${3}"
}
function __promptline_cwd {
  if [[ "$PWD" == "/" ]]; then
    printf "/"
  elif [[ "$PWD" == "$HOME" ]]; then
    printf "~"
  else
    local truncation="⋯"
    local tilde="~"
    local cwd="${PWD/#$HOME/$tilde}"
    local first_char="$cwd[1,1]"
    local formatted_cwd=""
    local dir_sep="/"

    # remove leading tilde
    cwd="${cwd#\~}"

    while [[ "$cwd" == */* && "$cwd" != "/" ]]; do
      # pop off last part of cwd
      local part="${cwd##*/}"
      cwd="${cwd%/*}"

      [[ "$cwd" != */* ]] && formatted_cwd="$part$formatted_cwd" && break

      if [[ "$cwd" == */* && "$cwd" != "/" && $(($#formatted_cwd + 80)) -gt $COLUMNS ]]; then
        first_char="$truncation"
        formatted_cwd="$part$formatted_cwd"
        break
      fi
      formatted_cwd="$dir_sep$part$formatted_cwd"
    done

    if [[ "$first_char" == "/" ]]; then
      printf "%s" "$formatted_cwd"
    else
      printf "%s" "$first_char$dir_sep$formatted_cwd"
    fi

  fi
}
function __promptline_prompt {
  local slice_prefix slice_empty_prefix slice_joiner slice_suffix is_prompt_empty=1

  # section "a" header
  slice_prefix="${bold}${a_bg}${sep}${a_fg}${a_bg}${space}" slice_suffix="$space${reset_bold}${a_sep_fg}" slice_joiner="${a_fg}${a_bg}${bold}${alt_sep}${space}" slice_empty_prefix="${bold}${a_fg}${a_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "a" slices
  __promptline_wrapper "$(__promptline_vcs_branch)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }
  __promptline_wrapper "$(__promptline_jobs)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }

  # section "b" header
  slice_prefix="${b_bg}${sep}${b_fg}${b_bg}${space}" slice_suffix="$space${b_sep_fg}" slice_joiner="${b_fg}${b_bg}${alt_sep}${space}" slice_empty_prefix="${b_fg}${b_bg}${space}"
  [ $is_prompt_empty -eq 1 ] && slice_prefix="$slice_empty_prefix"
  # section "b" slices
  __promptline_wrapper "$(__promptline_cwd)" "$slice_prefix" "$slice_suffix" && { slice_prefix="$slice_joiner"; is_prompt_empty=0; }
  # close sections

  printf "%s" "${reset_bg}${sep}$reset$space"
}
function __promptline_vcs_branch {
  local branch
  local branch_symbol=""

  # git
  if hash git 2>/dev/null; then
    if branch=$( { git symbolic-ref --quiet HEAD || git rev-parse --short HEAD; } 2>/dev/null ); then
      branch=${branch##*/}
      printf "%s" "${branch_symbol}${branch:-unknown}"
      return
    fi
  fi
  return 1
}
function __promptline_jobs() {
  local job_count=$( jobs -d | awk '!/pwd/' | wc -l | tr -d " ")
  [[ $job_count -gt 0 ]] || return 1
  printf "%s" "${job_count}"
  return
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
