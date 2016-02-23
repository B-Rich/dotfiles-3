[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
hsetroot -full ~/.config/scripts/background3.jpg
xsetroot -cursor_name left_ptr &

##  BSPWM  ##
urxvt &
exec bspwm

##  OTHERS  ##
#startkde
#startxfce4
#exec gnome-session
