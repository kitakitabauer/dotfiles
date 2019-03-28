export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-256color
export GREP_OPTIONS='--color=none'
export GIT_MERGE_AUTOEDIT=no
export XDG_CONFIG_HOME=~/.config
export LESS='-g -i -M -R -S -W -z-4 -x4'
export PAGER=less
export EDITOR=vim

path=(
  /usr/local/bin(N-/)
  $path
)

if (( $+commands[go] )); then
  export GOPATH=$HOME/go
  path+=($GOPATH/bin)
fi

if (( $+commands[nodebrew] )); then
  path+=($HOME/.nodebrew/current/bin)
fi

# python, perl, ruby, perl6
for xenv in pyenv plenv rbenv rakudobrew; do
  if (( $+commands[$xenv] )); then
    path=($($xenv root)/shims $path)
    eval "$(SHELL=zsh $xenv init - --no-rehash)"
  fi
done

path+=(./node_modules/bin)
path+=(/usr/local/opt/maven@3.2/bin/)

# history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
HISTFILE=$ZDOTDIR/.zsh_history
HISTSIZE=16384
SAVEHIST=16384
LISTMAX=1000
# !を使ったヒストリ展開を行う(d)
setopt bang_hist
# ヒストリファイルにコマンドラインだけではなく実行時刻と実行時間も保存する。
setopt extended_history
# 同じコマンドラインを連続で実行した場合はヒストリに登録しない。
setopt hist_ignore_dups
# スペースで始まるコマンドラインはヒストリに追加しない。
setopt hist_ignore_space
# すぐにヒストリファイルに追記する。
setopt inc_append_history
# zshプロセス間でヒストリを共有する。
setopt share_history
# C-sでのヒストリ検索が潰されてしまうため、出力停止・開始用にC-s/C-qを使わない。
setopt no_flow_control
setopt hist_no_store       # ヒストリにhistoryコマンドを記録しない
setopt hist_reduce_blanks  # 余分なスペースを削除してヒストリに記録
setopt magic_equal_subst   # コマンドラインの引数で--prefix=/usr などの = 以降でも補完できる
# 補完時にヒストリを自動的に展開する。
setopt hist_expand