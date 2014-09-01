set nocompatible

" having some issues with this at home
filetype plugin indent on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'airblade/vim-gitgutter'
Bundle 'ervandew/supertab'
Bundle 'gmarik/vundle'
Bundle 'alfredodeza/pytest.vim'
Bundle 'itchyny/lightline.vim'
Bundle 'kchmck/vim-coffee-script'
Bundle 'kien/ctrlp.vim'
Bundle 'majutsushi/tagbar'
Bundle 'nanotech/jellybeans.vim'
Bundle 'othree/html5.vim'
Bundle 'scrooloose/nerdtree'
Bundle 'stefanoverna/vim-i18n'
Bundle 'tComment'
Bundle 'thoughtbot/vim-rspec'
Bundle 'tpope/vim-dispatch'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'
Bundle 'vim-ruby/vim-ruby'

set backspace+=start,eol,indent
set rnu
set nu
set expandtab
set smartindent

" tab size stuff, default to 2 spaces 
set shiftwidth=2
set tabstop=2
set softtabstop=2
set laststatus=2

" python should use 4 space
au FileType python setl sw=4 sts=4

syntax enable
filetype plugin indent on
" searching
set hlsearch
set showmatch
set incsearch
set hlsearch
set ignorecase
set smartcase

colorscheme jellybeans
set colorcolumn=81

" tab management
nmap <C-T>n :tabn<CR>
nmap <C-T>p :tabp<CR>

" pane navigation
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" shortcuts
nnoremap <space> zvzz

autocmd BufWritePre *.yml,*sh,*.html,*.md,*.js,*.rb,*.js,*.hs,*.py,*.erb,*.coffee,*.styl :%s/\s\+$//e
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" ctrlp stuff
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_use_caching = 1

" Configure ctrlp for SPEED
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ tags
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif

" Find in Files
command -nargs=+ -complete=file -bar FindInFiles silent! grep! <args> * |cwindow|redraw!
map <C-S-F> :FindInFiles<SPACE>


" Rspec.vim mappings
let g:rspec_command = "Dispatch rspec {spec}"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
vmap <Leader>t :call I18nTranslateString()<CR>

function! UseZeus()
  let g:rspec_command = "Dispatch zeus rspec {spec}"
endfunction
command! UseZeus call UseZeus()

function! NoZeus()
  let g:rspec_command = "Dispatch rspec {spec}"
endfunction
command! NoZeus call NoZeus()

" Lightline
function! CurrentFilename()
  return ('' != expand('%:p') ? substitute(expand('%:p'), expand('$HOME'), '~', 'g') : '[No Name]')
endfunction
let g:lightline = {
  \ 'colorscheme': 'solarized_dark',
  \ 'active': {
  \   'left': [
  \      ['mode', 'paste'],
  \      ['fugitive', 'readonly', 'filename', 'modified']
  \   ]
  \ },
  \ 'component': {
  \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
  \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
  \ },
  \ 'component_function': {
  \   'filename': 'CurrentFilename'
  \ },
  \ 'component_visible_condition': {
  \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
  \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
  \ }
\ }

" Toggle Paste-Mode Helper
function! TogglePasteMode()
  set paste!
  redraw!
endfunction

map <F2> :call TogglePasteMode()<CR>
set clipboard=unnamed


" ctags
set tags=./.tags;

" nerdtree
let NERDTreeIgnore = ['\.pyc$']
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
function! StartUp()
    if 0 == argc()
        NERDTree
    end
endfunction

autocmd VimEnter * call StartUp()

map <Leader>d :call InsertPDBLine()<CR>
function! InsertPDBLine()
  let trace = expand("import ipdb\nipdb.set_trace()")
  execute "normal o".trace
endfunction
