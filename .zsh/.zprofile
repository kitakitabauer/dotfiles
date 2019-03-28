alias zmv='noglob zmv -W'

alias g=git
alias vi=vim
alias nv=nvim

alias ls='ls -G'
alias ll='ls -ahl'
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias less='less -R'
alias sed='gsed'
alias tmux='tmux -2'
alias view='vim -R'
alias v='vim -'
alias ag='ag --nogroup --nocolor'
# ページャーを使いやすくする
alias -g G='| grep'
alias -g H='| head'
alias -g L='|& $PAGER'
alias -g S='| sed'
alias -g T='| tail'
alias -g V='| vim -R -'

# coreutils
brew_prefix=`brew --prefix`
alias base64='$brew_prefix/bin/gbase64'
alias basename='$brew_prefix/bin/gbasename'
alias cat='$brew_prefix/bin/gcat'
alias chcon='$brew_prefix/bin/gchcon'
alias chgrp='$brew_prefix/bin/gchgrp'
alias chmod='$brew_prefix/bin/gchmod'
alias chown='$brew_prefix/bin/gchown'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias diff='diff --exclude=".svn"'
alias ag='ag --nogroup --nocolor'
alias f='open .'

alias bashrc='vi ~/.bashrc'
alias zshenv='vi $ZDOTDIR/.zshenv'
alias zprofile='vi $ZDOTDIR/.zprofile'
alias zshrc='vi $ZDOTDIR/.zshrc'

alias vimrc='vi ~/.vimrc'
alias vimdiff='vim -dO'
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'

alias svn-vimdiff='svn diff --diff-cmd svn-vimdiff.sh'

# git
alias gconf='vi ~/.gitconfig'

alias gst='git status --branch'
alias gba='git branch -a'
alias gsb='git show-branch'
alias gc='git commit -v'
alias gca='git commit -va'
alias gco='git checkout'
alias ga='git add'
alias gm='git merge'
alias gf='git fetch'
alias gfr='git fetch && git rebase'
alias ggpush='git push origin $(current_branch)'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias gl='git log --pretty=oneline'
# diff関連
alias gd='git diff'
alias gdm='git diff master'           # masterとのdiff
alias gdw='git diff --color-words'    # 単語単位でいろつけてdiff
alias gdc='git diff --cached'         # addされているものとのdiff
alias gds='git diff --staged'         # 同上(1.6.1移行)
alias gd1='git diff HEAD~'            # HEADから1つ前とdiff
alias gd2='git diff HEAD~~'           # HEADから2つ前とdiff
alias gd3='git diff HEAD~~~'          # HEADから3つ前とdiff
alias gd4='git diff HEAD~~~~'         # HEADから4つ前とdiff
alias gd5='git diff HEAD~~~~~'        # HEADから5つ前とdiff
alias gd10='git diff HEAD~~~~~~~~~~'  # HEADから10前とdiff
alias gdfv='git difftool --tool=vimdiff --no-prompt'

# リポジトリを参照
alias see='hub browse'
alias gometalinter='gometalinter --fast'

# C で標準出力をクリップボードにコピーする
# mollifier delta blog : http://mollifier.hatenablog.com/entry/20100317/p1
if which pbcopy >/dev/null 2>&1 ; then
  # Mac
  alias -g C='| pbcopy'
elif which xsel >/dev/null 2>&1 ; then
  # Linux
  alias -g C='| xsel --input --clipboard'
elif which putclip >/dev/null 2>&1 ; then
  # Cygwin
  alias -g C='| putclip'
fi