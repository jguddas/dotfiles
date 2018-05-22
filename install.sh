#!/bin/sh

#  __  __  _  _    ____  _____  ____  ____  ____  __    ____  ___
# (  \/  )( \/ )  (  _ \(  _  )(_  _)( ___)(_  _)(  )  ( ___)/ __)
#  )    (  \  /    )(_) ))(_)(   )(   )__)  _)(_  )(__  )__) \__ \
# (_/\/\_) (__)   (____/(_____) (__) (__)  (____)(____)(____)(___/
#                    linking and installation
#               usage: ./install.sh [folder-name]

# linking and download helper
ln_i() {
  if [ $# -gt 2 ]; then
    if [ ! -d "${*: -1}" ]; then
      echo "${*: -1} is not a dictionary"
      exit 1
    fi
    for i in "${@:1:(${#@})-1}"; do
      o="${*: -1}/$(basename "$i")"
      if [ ! "$i" -ef "$o" ]; then
        [ -e "$o" ] && git diff --no-index "$o" "$i"
        ln -i "$i" "$o"
      fi
    done
  elif [ ! -d "$2" ] && [ ! "$1" -ef "$2" ]; then
    [ -e "$2" ] && git diff --no-index "$2" "$1"
    ln -i "$1" "$2"
  elif [ -d "$2" ] && [ ! "$1" -ef "$2/$(basename "$1")" ]; then
    if [ -e "$2/$(basename "$1")" ]; then
      git diff --no-index "$2/$(basename "$1")" "$1"
    fi
    ln -i "$1" "$2"
  fi
}
dl_e() {
  if [ -d "$2" ]; then
    out="$2/$(basename "$1")"
  else
    out="$2"
  fi
  if [ ! -e "$out" ]; then
    curl -fLo "$out" "$1"
  fi
}
base=$(dirname "$0")
gh=https://raw.githubusercontent.com

if [ -z "$1" ] || [ "$1" = "vim" ]; then
  mkdir -p ~/.vim/{autoload,ftplugin,snippets} ~/.config/nvim
  ln_i $base/vim/*.vim ~/.vim
  ln_i $base/vim/vimrc ~/.vim/vimrc
  ln_i $base/vim/vimrc ~/.config/nvim/init.vim
  ln_i $base/vim/ftplugin/* ~/.vim/ftplugin
  ln_i $base/vim/snippets/* ~/.vim/snippets
  # install vim-plug
  dl_e $gh/junegunn/vim-plug/master/plug.vim ~/.vim/autoload
  # install plugins
  if command -v nvim > /dev/null; then
    printf "\033[sinstalling vim and neovim plugins..."
    nvim -u ~/.vim/plugins.vim -c PlugInstall\|qa! 1>&2> /dev/null
    printf "\033[2K\033[u"
  elif command -v vim > /dev/null; then
    printf "\033[sinstalling vim plugins..."
    vim -u ~/.vim/plugins.vim -c PlugInstall\|qa! 1>&2> /dev/null
    printf "\033[2K\033[u"
  fi
fi

if [ -z "$1" ] || [ "$1" = "zsh" ]; then
  mkdir -p ~/scripts
  ln_i $base/zsh/zimrc ~/.zimrc
  ln_i $base/zsh/zshrc ~/.zshrc
  ln_i $base/zsh/zprofile ~/.zprofile
  ln_i $base/zsh/prompt.zsh ~/scripts
  # install zim
  if [ ! -d "$HOME/.zim" ]; then
    git clone --recursive https://github.com/zimfw/zimfw.git ~/.zim
  fi
  # make zsh the default shell
  [ "$SHELL" = "/bin/zsh" ] || chsh -s /bin/zsh
fi

if [ -z "$1" ] || [ "$1" = "qutebrowser" ]; then
  mkdir -p ~/.config/qutebrowser
  ln_i $base/qutebrowser/* ~/.config/qutebrowser
fi

if [ -z "$1" ] || [ "$1" = "i3wm" ]; then
  mkdir -p ~/.config/i3/i3ipc ~/scripts
  ln_i $base/i3wm/* ~/.config/i3
  # install i3ipc
  dl_e $gh/acrisci/i3ipc-python/master/i3ipc/i3ipc.py ~/.config/i3/i3ipc
  dl_e $gh/acrisci/i3ipc-python/master/i3ipc/__init__.py ~/.config/i3/i3ipc
  # reload i3
  i3-msg reload > /dev/null
fi

if [ -z "$1" ] || [ "$1" = "x11" ]; then
  ln_i $base/x11/xinitrc ~/.xinitrc
fi

if [ -z "$1" ] || [ "$1" = "ranger" ]; then
  mkdir -p ~/.config/ranger/plugins
  ln_i $base/ranger/* ~/.config/ranger
  # install devicon plugin
  repo=$gh/alexanderjeurissen/ranger_devicons
  dl_e $repo/master/devicons.py ~/.config/ranger
  dl_e $repo/master/devicons_linemode.py ~/.config/ranger/plugins
fi

if [ -z "$1" ] || [ "$1" = "urxvt" ]; then
  mkdir -p ~/.urxvt/ext
  ln_i $base/urxvt/Xresources ~/.Xresources
  # install font-size extention
  dl_e $gh/majutsushi/urxvt-font-size/master/font-size ~/.urxvt/ext
  # load xresources
  xrdb ~/.Xresources
fi

if [ -z "$1" ] || [ "$1" = "mpv" ]; then
  mkdir -p ~/.config/mpv/{scripts,lua-settings}
  ln_i $base/mpv/{mpv,input}.conf ~/.config/mpv
  ln_i $base/mpv/osc.conf ~/.config/mpv/lua-settings
  # install autoload script
  dl_e $gh/mpv-player/mpv/master/TOOLS/lua/autoload.lua ~/.config/mpv/scripts
fi
