export LANG=ja_JP.UTF-8
export LSCOLORS=gxfxcxdxbxegedabagacad
export TERM=xterm-256color
export GREP_OPTIONS='--color=none'
export GIT_MERGE_AUTOEDIT=no
export XDG_CONFIG_HOME=~/.config

# history
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end
bindkey '^R' history-incremental-pattern-search-backward
bindkey '^S' history-incremental-pattern-search-forward
HISTFILE=~/.zsh_history
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
# zshプロセス間でヒストリを共有する。
setopt share_history
setopt hist_no_store       # ヒストリにhistoryコマンドを記録しない
setopt hist_reduce_blanks  # 余分なスペースを削除してヒストリに記録
setopt magic_equal_subst   # コマンドラインの引数で--prefix=/usr などの = 以降でも補完できる
# 補完時にヒストリを自動的に展開する。
setopt hist_expand

