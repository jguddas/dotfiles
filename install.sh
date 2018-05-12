
#  __  __  _  _    ____  _____  ____  ____  ____  __    ____  ___
# (  \/  )( \/ )  (  _ \(  _  )(_  _)( ___)(_  _)(  )  ( ___)/ __)
#  )    (  \  /    )(_) ))(_)(   )(   )__)  _)(_  )(__  )__) \__ \
# (_/\/\_) (__)   (____/(_____) (__) (__)  (____)(____)(____)(___/
#                    linking and installation
#               usage: ./install.sh [folder-name]

# linking helper
ln_i() {
  if [[ $# > 2 ]]; then
    if [[ ! -d ${@: -1} ]]; then
      echo "${@: -1} is not a dictionary"
      exit 1
    fi
    for i in ${@:1:(${#@})-1}; do
      local o="${@: -1}/$(basename $i)"
      if [[ ! $i -ef $o ]]; then
        [[ -a $o ]] && git diff --no-index $o $i
        ln -i $i $o
      fi
    done
  elif [[ ! -d $2 && ! $1 -ef $2 ]]; then
    [[ -a $2 ]] && git diff --no-index $2 $1
    ln -i $1 $2
  elif [[ -d $2 && ! $1 -ef "$2/$(basename $1)" ]]; then
    [[ -a "$2/$(basename $1)" ]] && git diff --no-index "$2/$(basename $1)" $1
    ln -i $1 $2
  fi
}
base=$(dirname $0)

if [[ -z $1 || $1 == "vim" ]]; then
  mkdir -p ~/.vim/autoload ~/.config/nvim
  ln_i $base/vim/*.vim ~/.vim
  ln_i $base/vim/vimrc ~/.vim/vimrc
  ln_i $base/vim/vimrc ~/.config/nvim/init.vim
  # install vim-plug
  [[ -a ~/.vim/autoload/plug.vim ]] || curl -fLo ~/.vim/autoload/plug.vim \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  # install plugins
  if command -v nvim > /dev/null; then
    printf "\033[sinstalling vim and neovim plugins..."
    nvim -u ~/.vim/plugins.vim -c PlugInstall\|qa! 2>&1> /dev/null
    printf "\033[2K\033[u"
  elif command -v vim > /dev/null; then
    printf "\033[sinstalling vim plugins..."
    vim -u ~/.vim/plugins.vim -c PlugInstall\|qa! 2>&1> /dev/null
    printf "\033[2K\033[u"
  fi
fi

if [[ -z $1 || $1 == "zsh" ]]; then
  mkdir -p ~/scripts
  ln_i $base/zsh/zimrc ~/.zimrc
  ln_i $base/zsh/zshrc ~/.zshrc
  ln_i $base/zsh/zprofile ~/.zprofile
  ln_i $base/zsh/prompt.zsh ~/scripts
  # install zim
  if [[ ! -d "$HOME/.zim" ]]; then
    git clone --recursive https://github.com/zimfw/zimfw.git ~/.zim
  fi
  # make zsh the default shell
  [[ $SHELL == "/bin/zsh" ]] || chsh -s /bin/zsh
fi

if [[ -z $1 || $1 == "qutebrowser" ]]; then
  mkdir -p ~/.config/qutebrowser
  ln_i $base/qutebrowser/* ~/.config/qutebrowser
fi

if [[ -z $1 || $1 == "i3wm" ]]; then
  mkdir -p ~/.config/i3/i3ipc ~/scripts
  ln_i $base/i3wm/* ~/.config/i3
  # install i3ipc
  if [[ ! -a ~/.config/i3/i3ipc/i3ipc.py ]]; then
    gh=https://raw.githubusercontent.com
    curl -fLo ~/.config/i3/i3ipc/i3ipc.py \
      $gh/acrisci/i3ipc-python/master/i3ipc/i3ipc.py
    curl -fLo ~/.config/i3/i3ipc/__init__.py \
      $gh/acrisci/i3ipc-python/master/i3ipc/__init__.py
  fi
  # reload i3
  i3-msg reload > /dev/null
fi

if [[ -z $1 || $1 == "x11" ]]; then
  ln_i $base/x11/xinitrc ~/.xinitrc
fi

if [[ -z $1 || $1 == "ranger" ]]; then
  mkdir -p ~/.config/ranger/plugins
  ln_i $base/ranger/* ~/.config/ranger
  # install devicon plugin
  if [[ ! -a ~/.config/ranger/devicons.py ]]; then
    gh=https://raw.githubusercontent.com
    curl -fLo ~/.config/ranger/devicons.py \
      $gh/alexanderjeurissen/ranger_devicons/master/devicons.py
    curl -fLo ~/.config/ranger/plugins/devicons_linemode.py \
      $gh/alexanderjeurissen/ranger_devicons/master/devicons_linemode.py
  fi
fi

if [[ -z $1 || $1 == "urxvt" ]]; then
  mkdir -p ~/.urxvt/ext
  ln_i $base/urxvt/Xresources ~/.Xresources
  # install font-size extention
  if [[ ! -a ~/.urxvt/ext/font-size ]]; then
    gh=https://raw.githubusercontent.com
    curl -fLo ~/.urxvt/ext/font-size \
      $gh/majutsushi/urxvt-font-size/master/font-size
  fi
  # load xresources
  xrdb ~/.Xresources
fi

if [[ -z $1 || $1 == "mpv" ]]; then
  mkdir -p ~/.config/mpv
  ln_i $base/mpv/* ~/.config/mpv
fi
