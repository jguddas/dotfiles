tmux(){
  if [ -n "$1" ] || [ -n "$TMUX" ]; then
    command tmux "$@"
  else
    command tmux new-session \; new-window "\
      tmux set-option -ga terminal-overrides \",$TERM:Tc\"; \
      tmux detach; \
    "
    command tmux attach
  fi
}
alias t="tmux"
alias ta="tmux attach"

# vim
alias vi="vim"
if command -v nvim > /dev/null; then
  alias vim="nvim"
fi
alias status='vim $(git rev-parse --show-toplevel)/.git/index'
gv() { vim -c "GV $@" }

# simple helpers
alias xin="xclip -selection c"
alias xout="xclip -out -selection c"
alias rmf="rm -rf"
alias rmr="rm -r"
alias cpr="cp -r"
alias pn='printf "%s\\n"'

# yarn aliases and smart switching to different package managers
load-yarn() {
  DIR="$PWD"
  while
    if [[ -f "$DIR/pnpm-lock.yaml" ]]; then
      PACKAGE_MANAGER="pnpm"
      break;
    elif [[ -f "$DIR/yarn.lock" ]]; then
      PACKAGE_MANAGER="yarn"
      break;
    elif [[ -f "$DIR/package-lock.json" ]]; then
      PACKAGE_MANAGER="npm"
      break;
    fi
    [[ -z $PACKAGE_MANAGER ]] && [[ "$DIR" != "/" ]]
  do DIR=$(dirname "$DIR"); done
  PACKAGE_MANAGER="${PACKAGE_MANAGER:-pnpm}"

  alias y="$PACKAGE_MANAGER"
  alias yy="$PACKAGE_MANAGER run"
  alias ya="$PACKAGE_MANAGER add"
  alias yd="$PACKAGE_MANAGER add -D"
  alias yr="$PACKAGE_MANAGER remove"
  alias yg="$PACKAGE_MANAGER global"
  alias yga="$PACKAGE_MANAGER global add"
  alias yi="$PACKAGE_MANAGER init"
  alias yiy="$PACKAGE_MANAGER init --yes"
  alias ys="$PACKAGE_MANAGER install"
}
add-zsh-hook chpwd load-yarn
load-yarn

# git
alias ga='git add'
alias gam='git commit --amend --no-edit'
alias gamm='git commit --amend --message'
alias gap='git add --patch'
alias gau='git add --update'
alias gb='git branch'
alias gbc='git checkout --branch'
alias gbd='git branch --delete'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gcoh='git checkout HEAD -- '
alias gcm='git commit --message'
alias gd='git diff'
alias gds='git diff --staged'
alias gfe='git fetch'
alias gi='git init'
alias glg='git log --topo-order --all --graph --oneline'
alias gls='git ls-files'
alias gm='git merge'
alias gmv='git mv'
alias gp='git push'
alias gpd='git push --delete'
alias gpf='git push --force-with-lease'
alias gpl='git pull'
alias grbi='git rebase --interactive --autosquash'
alias grm='git rm'
alias grs='git reset'
alias gsh='git show'
alias gs='git stash'
alias gss='git stash pop'
alias gt='git status'
alias gts='git status --short'
gcd() {
  if command -v gh > /dev/null; then
    gh repo clone "$@"
  else
    git clone "$@"
  fi
  local dir
  if [[ $2 ]]; then
    dir=$2
  else
    dir=${1%/}
    dir=${dir%.git}
    dir=${dir##*/}
  fi
  cd "$dir"
}
gbcm() {
  gbc "$(sed 's|[^[:alnum:]]\{1,\}|-|g;s|-|\/|' <<< "$1")"
}
gco() {
  git checkout "$@" || git checkout "$(sed 's|[^[:alnum:]]\{1,\}|-|g;s|-|\/|' <<< "$1")"
}
