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

# Aliases
alias vi='vim'
alias yup='yaourt -Syua'
alias svim='sudo vim'
alias sfind='sudo find'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias openports='ss --all --numeric --processes --ipv4 --ipv6'
alias ssrecord='simplescreenrecorder'
alias clbin='curl -F "clbin=<-" https://clbin.com'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias wine='WINEPREFIX=/home/schism/.wine32 WINEARCH=win32 wine'
alias _tmux_attach='tmux attach -t RPG'
alias _tmux_kill='tmux kill-session -t RPG'
alias snapshot='sudo snapscreenshot -c1 -x1 > /tmp/snap.tga'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
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

pb() {
  # syntax:  pb <filename>	
  curl -F "c=@${1:--}" https://ptpb.pw/ | tee /tmp/uuid 
  cat /tmp/uuid | grep uuid | awk '{print $2}' >> ${HOME}/uuid
}

pb_rm() {
  # syntax:  pb <hash_from_$HOME/uuid>
  curl -X DELETE https://ptpb.pw/${1}
  line_num=`cat ${HOME}/uuid | grep -n -i "${1}" | cut -d':' -f1`
  sed -i "${line_num}d" ${HOME}/uuid
}

brightness() {
  ${HOME}/Documents/shell/brightness.sh ${1}
}

wifi_on() {
  sudo ifconfig wlp10s0 down
  echo "Successful login. Interface down. Starting profile."
  sleep 0.5
  sudo netctl start pre-network
}


extract() {
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xjf $1        ;;
             *.tar.gz)    tar xzf $1     ;;
             *.bz2)       bunzip2 $1       ;;
             *.rar)       rar x $1     ;;
             *.gz)        gunzip $1     ;;
             *.tar)       tar xf $1        ;;
             *.tbz2)      tar xjf $1      ;;
             *.tgz)       tar xzf $1       ;;
             *.zip)       unzip $1     ;;
             *.Z)         uncompress $1  ;;
             *.7z)        7z x $1    ;;
             *)           echo "'$1' cannot be extracted via extract()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

_tmux() {
	BASE="$HOME/git/rpg-c";
	tmux start-server
	tmux new-session -d -s RPG -n Workspace
	tmux new-window -t RPG:2 -n Shell

	tmux select-window -t RPG:1

	tmux split-window -h
	tmux select-pane -t 1
	tmux split-window -v
	tmux select-pane -t 1
	tmux split-window -v
	tmux select-pane -t 1
	tmux resize-pane -U 4
	tmux select-pane -t 2
	tmux resize-pane -D 7
	tmux resize-pane -R 20

	tmux send-keys -t 0 "cd ${BASE}; vim src/main.c" C-m
	tmux send-keys -t 1 "htop" C-m
	tmux send-keys -t 3 "weechat" C-m

	tmux select-window -t RPG:1
	tmux select-pane -t 0
	tmux attach-session -t RPG
}

pull-stream() {
    livestreamer -p "vlc --file-caching=5000" $1 $2
}

put-stream() {
     source $HOME/.stream.key
     INRES="3840x2160" # input resolution
   # OUTRES="2560x1440" # output resolution
     OUTRES="1920x1080"
     FPS="30" # target FPS
     GOP="60" # i-frame interval, should be double of FPS, 
     GOPMIN="30" # min i-frame interval, should be equal to fps, 
     THREADS="5" # max 6
     CBR="2200k" # constant bitrate (should be between 1000k - 3000k)
     CBR_MIN="2200k"
     CBR_MAX="2200k"
     QUALITY="ultrafast"  # one of the many FFMPEG preset  (x264 --help)
     AUDIO_RATE="44100" # default: 44100
     ACODEC="libmp3lame"  # audio codec  (libfdk_aac, libmp3lame)
     ABIT_RATE="128k"
    #STREAM_KEY="[CHECK $HOME/stream.key" # insert stream key here or another file
     SERVER="live-dfw" # see http://bashtech.net/twitch/ingest.php for list
     
     ffmpeg -f x11grab -thread_queue_size 512 -video_size "$INRES" -r "$FPS" -i $DISPLAY \
       -f alsa -thread_queue_size 512 -i pulse -ac 2 -b:a $ABIT_RATE \
       -f flv -ar $AUDIO_RATE -aq 7 -vcodec libx264 -g $GOP \
       -keyint_min $GOPMIN -b:v $CBR -minrate $CBR_MIN -maxrate $CBR_MAX -pix_fmt yuv420p \
       -s $OUTRES -preset $QUALITY -tune film -acodec $ACODEC -threads $THREADS -strict normal \
       -bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"
}

put-uo() {
     source $HOME/.stream.key
     INRES="2560x1440" # input resolution
   # OUTRES="2560x1440" # output resolution
     OUTRES="1920x1080"
     FPS="60" # target FPS
     GOP="120" # i-frame interval, should be double of FPS, 
     GOPMIN="60" # min i-frame interval, should be equal to fps, 
     THREADS="5" # max 6
     CBR="3000k" # constant bitrate (should be between 1000k - 3000k)
     CBR_MIN="3000k"
     CBR_MAX="3000k"
     QUALITY="ultrafast"  # one of the many FFMPEG preset  (x264 --help)
     AUDIO_RATE="44100" # default: 44100
     ACODEC="libmp3lame"  # audio codec  (libfdk_aac, libmp3lame)
     ABIT_RATE="128k"
     #STREAM_KEY="[CHECK $HOME/stream.key" # insert stream key here or another file
     SERVER="live-dfw" # see http://bashtech.net/twitch/ingest.php for list
     #SERVER="live-lax"

     ffmpeg -f x11grab -thread_queue_size 512 -video_size "$INRES" -r "$FPS" -i $DISPLAY \
       -f alsa -thread_queue_size 512 -i pulse -ac 2 -b:a $ABIT_RATE \
       -f flv -ar $AUDIO_RATE -aq 7 -vcodec libx264 -g $GOP \
       -keyint_min $GOPMIN -b:v $CBR -minrate $CBR_MIN -maxrate $CBR_MAX -pix_fmt yuv420p \
       -s $OUTRES -preset $QUALITY -tune film -acodec $ACODEC -threads $THREADS -strict normal \
       -bufsize $CBR "rtmp://$SERVER.twitch.tv/app/$STREAM_KEY"
}

vlc_stream() {
	vlc -I telnet --telnet-password videolan --rtsp-host 73.136.48.35 --rtsp-port 18411
}

