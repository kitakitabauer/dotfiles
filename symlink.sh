#!/bin/sh

basepath=$(cd $(dirname $0);pwd)

# symlink dotfiles into ~
files=.*
for file in $files
do
  if [ $file != "." -a $file != ".." -a $file != ".git*" ] ; then
    ln -sf $basepath/$file ~
  fi
done

# symlink zsh configuration files into ~/.zsh
if [ ! -d ~/.zsh ] ; then
  ln -s $bashpath/.zsh ~
else
  files=.zsh/*
  for file in $files
  do
    ln -sf $basepath/$file ~/.zsh/
  done
fi

# symlink snippets into ~/.snippets
if [ ! -d ~/.snippets ] ; then
  ln -s $basepath/.snippets ~
else
  files=.snippets/*
  for file in $files
  do
    ln -sf $basepath/$file ~/.snippets/
  done
fi

# symlink binaries into /usr/local/bin
files=bin/*
for file in $files
do
  ln -sf $basepath/$file /usr/local/bin
done
