alias zmv='noglob zmv -W'

alias ls='ls -G'
alias ll='ls -ltr'
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
alias base64="$brew_prefix/bin/gbase64"
alias basename="$brew_prefix/bin/gbasename"
alias cat="$brew_prefix/bin/gcat"
alias chcon="$brew_prefix/bin/gchcon"
alias chgrp="$brew_prefix/bin/gchgrp"
alias chmod="$brew_prefix/bin/gchmod"
alias chown="$brew_prefix/bin/gchown"

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias diff='diff --exclude=".svn"'
alias ag='ag --nogroup --nocolor'
alias f='open .'

alias bashrc='vi ~/.bashrc'
alias zshrc='vi ~/dotfiles/.zshrc'
alias ohmyzsh='~/.oh-my-zsh'

alias vimrc='vi ~/.vimrc'
alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'

alias svn-vimdiff='svn diff --diff-cmd svn-vimdiff.sh'

alias g='git'
alias gitc='vi ~/.gitconfig'

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
