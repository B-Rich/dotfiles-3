#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

directories=".colors \
.ncmpcpp \
.config/bspwm/panel \
.config/bspwm \
.config/mpd/playlists \
.config/mpd \
.config/sxhkd \
.config/scripts \
.config/tint2"

files=".bashrc \
.bash_profile \
.compton.conf \
.external_functions \
.ncmpcpp \
.vimrc \
.Xdefaults \
.Xresources \
.xinitrc \
.zshrc"

for dir in ${directories}; do
	rm -rf ${HOME}/${dir}
done

for file in ${files}; do
	rm ${HOME}/${file}
done

##########

for dir in ${directories}; do
        if [[ -d ${dir} && ! -d ${HOME}/${dir} ]]; then
                echo "${dir} => ${HOME}/${dir}"
                mkdir -p ${HOME}/${dir}

                for file in `find ./${dir} -path ./.git -prune -o -print`; do
                        file=`echo ${file} | cut -c 3-`
                        if [[ ! -L ${HOME}/${file} && ! -d ${file} ]]; then
                                echo " linking from ${file}  =>  ${HOME}/${file}"
                                ln -s ${PWD}/${file} ${HOME}/${file}
                        fi
                done
        else
                echo "Directory ${dir} exists? @ ${HOME}/${dir}"
        fi
done

for file in ${files}; do
	ln -s ${PWD}/${file} ${HOME}/${file}
done
