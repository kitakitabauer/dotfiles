# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.zsh/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git docker docker-compose)

source $ZSH/oh-my-zsh.sh
source $ZSH/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
# .bashrc

# Source global definitions

source ~/.zalias

export LANG=ja_JP.UTF-8
setopt print_eight_bit

# sudo の後ろでコマンド名を補完
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
                   /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin

fpath=(/usr/local/share/zsh-completions $fpath)

setopt PROMPT_SUBST
source ~/.zsh/git-prompt.sh
#PROMPT='%F{cyan}%W%f %F{cyan}%*%f:%F{yellow}%m%f:%F{magenta}%n%f: %F{green}%~%f %F{red}$(__git_ps1 "%s" )%f '

function left_prompt() {
    fullpath=`pwd`
    echo "$fullpath" | grep $(echo "$HOME") > /dev/null
    if [ $? ] ; then
        fullpath_length=`expr ${(m)#fullpath} - ${(m)#HOME} + 1`
    else
        fullpath_length=`expr ${(m)#fullpath}`
    fi
    host_length=0
    if [ -n "$SSH_CONNECTION" ]; then
        host_length=`expr ${(m)#USER} + ${(m)#HOST} - 4` # ホスト名には.localがつくため
    fi
    total_length=`expr $fullpath_length + $host_length`
    limit_length=`echo "($COLUMNS) / 2" | bc`
    base_color=`echo yellow`
    # 文字数が多すぎるとき
    if [ $total_length -gt $limit_length ]; then
        current=`basename "\`pwd\`"`
        current_length=${(m)#current}
        final_length=`expr $limit_length - $current_length - $host_length`
        if [ $final_length -lt 6 ]; then
            final_length=4
        fi
        if [ -n "$SSH_CONNECTION" ]; then
            PROMPT="%{$fg[magenta]%}%n@%m%{$reset_color%}:%{$fg_bold[$base_color]%}%$final_length>.../>%~%<<%c%{$reset_color%} %# "
        else
            PROMPT="%{$fg_bold[$base_color]%}%$final_length>.../>%~%<<%c%{$reset_color%} %# "
        fi
    # 全て表示できる時
    else
        if [ -n "$SSH_CONNECTION" ]; then
            PROMPT="%{$fg[magenta]%}%n@%m%{$reset_color%}:%{$fg_bold[$base_color]%}%~%{$reset_color%} %# "
        else
            PROMPT="%{$fg_bold[$base_color]%}%~%{$reset_color%} %# "
        fi
    fi
}

function right_prompt {
  local branch_name st branch_status

  if git rev-parse 2>/dev/null; then
    branch_name=`git rev-parse --abbrev-ref HEAD 2> /dev/null`
    st=`git status 2> /dev/null`
    # コンフリクトが起こった状態
    if [[ -n `echo "$st" | grep "^rebase in progress"` ]]; then
      branch_status="%U%F{red}"
      branch_name="CONFLICT"
    # 自動マージできないファイルがある状態
    elif [[ -n `echo "$st" | grep "^Unmerged paths"` ]]; then
      if [[ -n `echo "$st" | grep "Changes to be committed:"` ]]; then
        branch_status="%K{red}"
      else
        branch_status="%F{red}"
      fi
    # ステージングファイルがある場合
    elif [[ -n `echo "$st" | grep "Changes to be committed:"` ]]; then
      # 新規ファイル、リネーム、削除ファイルがある場合はマゼンタ塗りつぶし
      # ステージング部分の文字列のみ抽出し、そこに特定の文字が含まれているかどうか
      if [[ -n `echo "$st" | awk '/Changes to be committed:/,/(Changes not staged for commit:|Untracked files:)/' | grep -e "new file:" -e "deleted:" -e "renamed:"` ]]; then
        branch_status="%K{magenta}"
      else
        branch_status="%K{yellow}"
      fi
    # 変更はあるがステージングされていないファイルがある場合
    # ステージングされているファイルがないので、文字列の抽出は必要ない
    # elif [[ -n `echo "$st" | grep "Changes not staged for commit:"` ]]; then
    # 新規ファイル、リネーム、削除ファイルがある場合はマゼンタ
    elif [[ -n `echo "$st" | grep -e "Untracked files:" -e "deleted:"` ]]; then
      branch_status="%F{magenta}"
    elif [[ -n `echo "$st" | grep "modified"` ]]; then
      branch_status="%F{yellow}"
    # 全てcommitされてクリーンな状態
    elif [[ -n `echo "$st" | grep "^nothing to"` ]]; then
      # pushされていなければ塗りつぶし
      if [[ -n `git log origin/"$branch_name".."$branch_name"` ]]; then
        branch_status="%K{green}"
      else
        branch_status="%F{green}"
      fi
    # 上記以外の状態の場合
    else
      branch_status=""
    fi
    # ブランチ名を色付きで表示する
    RPROMPT="${branch_status}[$branch_name]%{$reset_color%}"
  else
    # git 管理されていないディレクトリは何も返さない
    RPROMPT="%{$fg[green]%}[%D{%m/%d} %*]%{$reset_color%}"
  fi
}

autoload -Uz add-zsh-hook
PERIOD=1 # gitディレクトリでのright_promptは描画にやや負荷がかかるため1秒以内はキャッシュしたものを使う
add-zsh-hook periodic right_prompt
add-zsh-hook precmd left_prompt

# コマンド実行時プロンプト再描画
re-prompt() {
    zle .accept-line
    zle .reset-prompt
}
zle -N accept-line re-prompt

setopt auto_cd
setopt auto_pushd
setopt correct
HISTFILE=~/.zsh_history
export HISTSIZE=10000
export SAVEHIST=100000
setopt inc_append_history
setopt share_history
setopt hist_reduce_blanks
setopt hist_ignore_all_dups

plugins+=(
  zsh-completions
  zsh-autosuggestions
)
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*:commands' reahs 1


# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

function peco-history-selection() {
    BUFFER=`history -n 1 | tail -r  | awk '!a[$0]++' | peco`
    CURSOR=$#BUFFER
    zle reset-prompt
}

zle -N peco-history-selection
bindkey '^R' peco-history-selection

# cdr
if [[ -n $(echo ${^fpath}/chpwd_recent_dirs(N)) && -n $(echo ${^fpath}/cdr(N)) ]]; then
    autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
    add-zsh-hook chpwd chpwd_recent_dirs
    zstyle ':completion:*' recent-dirs-insert both
    zstyle ':chpwd:*' recent-dirs-default true
    zstyle ':chpwd:*' recent-dirs-max 1000
    zstyle ':chpwd:*' recent-dirs-file "$HOME/.cache/chpwd-recent-dirs"
fi
function peco-cdr () {
    local selected_dir="$(cdr -l | sed 's/^[0-9]\+ \+//' | peco --prompt="cdr >" --query "$LBUFFER")"
    if [ -n "$selected_dir" ]; then
        BUFFER="cd ${selected_dir}"
        zle accept-line
    fi
}
zle -N peco-cdr
bindkey '^E' peco-cdr

function peco-ghq-look () {
  local selected_dir=$(ghq list -p | peco --query "$LBUFFER")
  if [ -n "$selected_dir" ]; then
    BUFFER="cd ${selected_dir}"
    zle accept-line
  fi
  zle clear-screen
}

zle -N peco-ghq-look
bindkey '^G' peco-ghq-look

# kubectl
[[ /home/ec2-user/bin/kubectl ]] && source <(kubectl completion zsh)

# eksctl
fpath=($fpath ~/.zsh/completion)

# 補完機能を有効にする
autoload -Uz compinit && compinit

