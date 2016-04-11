[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
hsetroot -full ~/bgb.png
xsetroot -cursor_name left_ptr &

##  BSPWM  ##
urxvt &
exec bspwm -c /home/schism/.config/bspwm/bspwm

##  OTHERS  ##
#startkde
#startxfce4
#exec gnome-session
