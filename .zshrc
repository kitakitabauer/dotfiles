# Lines configured by zsh-newuser-install
autoload -U colors && colors
PROMPT="[%{$fg[red]%}%n%{$reset_color%}@%{$fg[blue]%}%m%{$reset_color%}] %{$fg_no_bold[yellow]%}%3~ %{$reset_color%}%# "
RPROMPT="%* [%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'
autoload -Uz compinit
compinit


bindkey -e
stty stop undef

# alias
alias g=git
alias vi=vim
alias nv=nvim
alias vimdiff='vim -dO'
alias view='vim -R'
alias gitdiff='git difftool --tool=vimdiff --no-prompt'
alias v='vim -'
alias ls='ls -G'
alias ll='ls -ahl'
alias l='ls -al'
alias ltr='ls -ltr'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias less='less -R'
alias tmux='tmux -2'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias diff='diff --exclude=".svn"'
alias ag='ag -S --nogroup --nocolor'
alias vman='vs man'
alias gometalinter='gometalinter --fast'

# 補完時に大小文字を区別しない
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1

# options
setopt bash_auto_list
setopt list_ambiguous
setopt autopushd
setopt auto_cd


# include
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
