set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'ervandew/supertab'
Bundle 'tComment'

set rnu
set shiftwidth=2
set tabstop=2
set expandtab
set smartindent

syntax enable
set hlsearch

colorscheme jellybeans
nmap <C-n> :tabn<CR>
nmap <C-p> :tabp<CR>

autocmd BufWritePre *.py :%s/\s\+$//e
