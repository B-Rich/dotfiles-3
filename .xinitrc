[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
hsetroot -full ~/bgb.ping
xsetroot -cursor_name left_ptr &

##  BSPWM  ##
urxvt &
exec bspwm

##  OTHERS  ##
#startkde
#startxfce4
#exec gnome-session
