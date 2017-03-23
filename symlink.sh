#!/bin/sh

basepath=$(cd $(dirname $0);pwd)

# symlink dotfiles into ~
files=.*
for file in $files
do
  if [ ! -d $file -a $file != "." -a $file != ".." -a $file != ".git" ] ; then
    ln -sf $basepath/$file ~
  fi
done

# symlink zsh configuration files into ~/.zsh
if [ ! -d ~/.zsh ] ; then
  mkdir ~/.zsh
fi
for file in .zsh/.*
do
  if [ $file != "." -a $file != ".." -a $file != ".git" ] ; then
    ln -sf $basepath/$file ~/.zsh/
  fi
done

# symlink snippets into ~/.snippets
if [ ! -d ~/.snippets ] ; then
  mkdir ~/.snippets
fi
for file in .snippets/*
do
  if [ $file != "." -a $file != ".." -a $file != ".git" ] ; then
    ln -sf $basepath/$file ~/.snippets/
  fi
done

# symlink binaries into /usr/local/bin
files=bin/*
for file in $files
do
  ln -sf $basepath/$file /usr/local/bin
done
