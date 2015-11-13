set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" This is the Vundle package, which can be found on GitHub.
" For GitHub repos, you specify plugins using the
" 'user/repository' format
Plugin 'gmarik/vundle'

" We could also add repositories with a ".git" extension
Plugin 'scrooloose/nerdtree.git'
" NERDTree, Use F3 for toggle NERDTree
nmap <silent> <F3> :NERDTreeToggle<CR>


" To get plugins from Vim Scripts, you can reference the plugin
" by name as it appears on the site
Plugin 'Buffergator'

" YouCompleteMe
Plugin 'valloric/YouCompleteMe'
let g:ycm_confirm_extra_conf = 0

"Conque
Plugin 'vim-scripts/Conque-Shell'

" Now we can turn our filetype functionality back on

filetype plugin indent on
set nu
syntax on
set cindent
set background=dark
set nowrap

command CC !clear && cd $C/source/game && gcc -o rpg -Wall headers/*.c % && ./rpg
command ME !make && ./rpg-c
command BAK !tar czvf "bak/bak-`date +\%d\%m-\%H\%M`.tar.gz" obj/ src/ Makefile ecosphere.in README
