#
# ~/.bashrc
#
# Exports
export EDITOR=vim
export PATH=$PATH:${HOME}.config/bspwm/panel:${HOME}/scripts:${HOME}/.gem/ruby/2.2.0/bin:${HOME}/.local/bin
export SCRIPTS=$HOME/scripts
export RUBY=$HOME/Documents/ruby
export C=$HOME/Documents/c
export WMSCRIPT=$HOME/.config/scripts

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[ ! -s ~/.config/mpd/pid ] && mpd

color_prompt=yes
if [ "$color_prompt" = yes ]; then
     export PS1="\W » "
fi

[[ -f .external_functions ]] && source .external_functions
