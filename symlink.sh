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
#if [ ! -d ~/.zsh ] ; then
#  ln -s $bashpath/.zsh ~
#else
  for file in .zsh/.*
  do
    if [ $file != "." -a $file != ".." -a $file != ".git" ] ; then
      ln -sfv $basepath/$file ~/.zsh/
    fi
  done
#fi

# symlink snippets into ~/.snippets
#if [ ! -d ~/.snippets ] ; then
#  ln -s $basepath/.snippets ~
#else
  for file in .snippets/*
  do
    if [ $file != "." -a $file != ".." -a $file != ".git" ] ; then
      ln -sfv $basepath/$file ~/.snippets/
    fi
  done
#fi

# symlink binaries into /usr/local/bin
files=bin/*
for file in $files
do
  ln -sf $basepath/$file /usr/local/bin
done
