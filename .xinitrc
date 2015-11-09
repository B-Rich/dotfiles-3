[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
#hsetroot -solid black
#hsetroot -tile ~/.config/scripts/background0.png
hsetroot -full ~/.config/scripts/background2.jpg
xsetroot -cursor_name left_ptr &

##  BSPWM  ##
#sxhkd &
#compton --config ~/.compton.conf &
urxvt &
  ##panel &
  ##xterm &
exec bspwm

##  OTHERS  ##
#startkde
#startxfce4
#exec gnome-session
