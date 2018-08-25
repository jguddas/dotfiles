alias yt="youtube-dl"

# vim
alias vi="vim"
if command -v nvim > /dev/null; then
  alias vim="nvim"
fi
alias status='vim $(git rev-parse --show-toplevel)/.git/index'
gv() { vim -c "GV $@" }

# simple helpers
alias add="touch"
alias rmf="rm -rf"
alias rmr="rm -r"
alias cpr="cp -r"
alias his='cat ~/.zsh/.zhistory | sed "s/[^;]\+;//" | awk'
al() { alias | awk "/$@/" }

# yarn
alias y="yarn"
alias ya="yarn add"
alias yd="yarn add -D"
alias yg="yarn global"
alias yga="yarn global add"
alias ygb="yarn global bin"
alias ygr="yarn global remove"
alias ygu="yarn global upgrade"
alias ygui="yarn global upgrade-interactive"
alias yi="yarn init"
alias yiy="yarn init --yes"
alias yr="yarn remove"
alias ys="yarn install"
alias yu="yarn upgrade"
alias yui="yarn upgrade-interactive"
alias yy="yarn run"
publish() {
  if [ -e .npmignore ]; then
    ignored="$(git ls-files --ignored --exclude-from=.npmignore)"
    files="$(git ls-files | grep -vFx "$ignored" | grep -vx ".npmignore")"
  else
    files=$(git ls-files)
  fi
  jq ".files=[${$(printf '"%s",' ${(f)files}): :(-1)}]" package.json | sponge package.json
  git diff
  yarn publish
}

# git
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gap='git add --patch'
alias gau='git add --update'
alias gb='git branch'
alias gbc='git checkout -b'
alias gbd='git branch --delete'
alias gc='git commit --verbose'
alias gca='git commit --verbose --all'
alias gcu='git add --update && git commit --verbose'
alias gcam='git commit --verbose --all --message'
alias gcum='git add --update && git commit --verbose --message'
alias gco='git checkout'
alias gcoh='git checkout HEAD -- '
alias gcm='git commit --message'
alias gd='git diff'
alias gds='git diff --staged'
alias gdw='git diff --color-words'
alias gdc='git diff --word-diff-regex=. --word-diff=color'
alias gfe='git fetch'
alias gg='git clone'
alias gi='git init'
alias gib='git init --bare'
alias glg='git log --topo-order --all --graph --oneline'
alias gls='git ls-files'
alias gm='git merge'
alias gp='git push'
alias gpd='git push --delete'
alias gpf='git push --force'
alias gpl='git pull'
alias grb='git rebase'
alias grbi='git rebase --interactive --autosquash'
alias gri='git rebase --interactive'
alias grm='git rm'
alias grmr='git rm -r'
alias grs='git reset'
alias gsh='git show'
alias gs='git stash'
alias gss='git stash pop'
alias gt='git status'
alias gts='git status --short'
alias gtsu='git status --short --untracked-files'
alias gtu='git status --untracked-files'
alias gw='git worktree'
alias gwa='git worktree add --force'
alias gwl='git worktree list'
alias gwp='git worktree prune'
gcd() {
  git clone "$@"
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

# git flow
alias gf='git flow'
alias gfi='git flow init'
alias gfI='git flow init -d'
alias gfid='git flow init -d'
alias gff='git flow feature'
alias gffs='git flow feature start'
alias gfff='git flow feature finish'
alias gffd='git flow feature delete'
alias gffp='git flow feature publish'
alias gfft='git flow feature track'
alias gfr='git flow release'
alias gfrs='git flow release start'
alias gfrf='git flow release finish'
alias gfrd='git flow release delete'
alias gfh='git flow hotfix'
alias gfhs='git flow hotfix start'
alias gfhf='git flow hotfix finish'
alias gfhd='git flow hotfix delete'
alias gfs='git flow support'
alias gfss='git flow support start'
