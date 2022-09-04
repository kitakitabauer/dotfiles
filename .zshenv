export PATH=/usr/local/bin:$PATH
export EDITOR=vim
export BROWSER=google-chrome
export LANG=ja_JP.UTF-8

# User specific aliases and functions
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

export PATH="$PATH:$HOME/.rvm/bin"
export PATH="$PATH:$HOME/apache-cassandra-1.2.9/bin"

export PATH="$PATH:$HOME/bin"

source /home/ec2-user/.gimme-aws-creds-xaws

export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
eval "$(goenv init -)"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"

eval "$(hub alias -s)"

ZSH_CUSTOM=:~/.zsh/oh-my-zsh/custom
