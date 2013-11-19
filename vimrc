set nocompatible

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'ervandew/supertab'
Bundle 'tComment'
Bundle 'airblade/vim-gitgutter'
Bundle 'thoughtbot/vim-rspec'

set rnu
set shiftwidth=2
set tabstop=2
set expandtab
set smartindent

syntax enable
set hlsearch

colorscheme jellybeans
nmap <C-T>n :tabn<CR>
nmap <C-T>p :tabp<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

autocmd BufWritePre *.js,*.rb,*.js,*.hs,*.py :%s/\s\+$//e
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" ctrlp stuff
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.ctrlp']

" Configure ctrlp for SPEED
if executable('ag')
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Rspec.vim mappings
let g:rspec_command = "!(hash zeus 2> /dev/null && \zeus rspec {spec}) || (hash zeus 2> /dev/null || bash -l -c 'rspec {spec}')"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
