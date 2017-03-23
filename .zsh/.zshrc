# .zshrc更新時にコンパイルして読み込み高速化
if [ ! -f $ZDOTDIR/.zshrc -o $ZDOTDIR/.zshrc -nt $ZDOTDIR/.zshrc.zwc ] ; then
  zcompile $ZDOTDIR/.zshrc
fi

# Lines configured by zsh-newuser-install
autoload -U colors && colors
PROMPT="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}] %{$fg_no_bold[yellow]%}%3~ %{$reset_color%}%# "
RPROMPT="%* [%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
autoload -Uz compinit
compinit


bindkey -e
stty stop undef

# 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1

# options
setopt bash_auto_list
setopt list_ambiguous
setopt autopushd
setopt auto_cd

# include
[ -f /usr/local/share/zsh/site-functions/_aws ] && . /usr/local/share/zsh/site-functions/_aws
[ -f ~/.zshrc.mine ] && . ~/.zshrc.mine
[ -f ~/.zshrc.zgen ] && . ~/.zshrc.zgen


# functions
function peco-src () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}
zle -N peco-src
bindkey '^]' peco-src

function peco-src-remote () {
  local selected_repo=$(ghq list -p | peco --query "$LBUFFER" | rev | cut -d "/" -f -2 | rev)
  echo $selected_repo
  if [ -n "$selected_repo" ]; then
    BUFFER="hub browse ${selected_repo}"
    # pecoで選択中, Enter を押した瞬間に実行する
    zle accept-line
  fi
  zle clear-screen
}

# 関数をウィジェットに登録
zle -N peco-src-remote
bindkey '^^' peco-src-remote

function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function pet-select() {
  BUFFER=$(pet search --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle redisplay
}
zle -N pet-select
bindkey '^s' pet-select


# zman 調べたい単語 という風に使う
function zman() {
  PAGER="less -g -s '+/^       "$1"'" man zshall
}

moshx() {
  SSHX_COMMAND=mosh sshx $@
}

sshx() {
  local SSH=${SSHX_COMMAND:-ssh}
  local SESSION=${SESSION_NAME:-"${SSH}x-$(date +%s)"}

  if [ -n "$TMUX" ]; then
    tmux new-window
    tmux send-keys "$SSH $1" C-m
    shift
    for h in $*; do
      tmux split-window -h "$SSH $h"
      tmux select-layout tiled
    done
    tmux set-window-option synchronize-panes on
    tmux select-pane -t 0

  else
    tmux new-session -d -s $SESSION "$SSH $1"
    shift
    for h in $*; do
      tmux split-window -h -d -t $SESSION "$SSH $h"
      tmux select-layout -t $SESSION tiled
    done
    tmux set-option -t $SESSION synchronize-panes on
    tmux attach-session -t $SESSION
  fi
}
