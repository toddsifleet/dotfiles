set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'


Plugin 'racer-rust/vim-racer'
Plugin 'rust-lang/rust.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'ervandew/supertab'
Plugin 'alfredodeza/pytest.vim'
Plugin 'itchyny/lightline.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'kien/ctrlp.vim'
Plugin 'nanotech/jellybeans.vim'
Plugin 'othree/html5.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'tComment'
Plugin 'tpope/vim-dispatch'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'digitaltoad/vim-jade'
Plugin 'fatih/vim-go'
Plugin 'tacahiroy/ctrlp-funky'
Plugin 'tpope/vim-unimpaired'
Plugin 'dense-analysis/ale'

call vundle#end()

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
set colorcolumn=81,101

let mapleader=","

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

autocmd BufWritePre *.page,*.yml,*sh,*.html,*.md,*.js,*.rb,*.js,*.hs,*.py,*.erb,*.coffee,*.styl,*.rst :%s/\s\+$//e
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" ctrlp stuff
let g:ctrlp_working_path_mode = 'rw'
let g:ctrlp_root_markers = ['.ctrlp']
let g:ctrlp_use_caching = 1

let g:ctrlp_extensions = ['funky']

nnoremap <Leader>fu :CtrlPFunky<Cr>
command! CtrlPSample call ctrlp#init(ctrlp#sample#id())

" Configure ctrlp for SPEED
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ tags
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
endif
let g:ctrlp_custom_ignore = 'git|datasets'

let g:ctrlp_custom_ignore = {
  \ 'dir':  '^__pycache__$|\.git$\|node_modules$\|env$\|dist$\|\.egg-info$\|build$',
  \ 'file': '\.pyc$\|\.swp$'
  \ }

" Find in Files
command -nargs=+ -complete=file -bar FindInFiles silent! grep! <args> * |cwindow|redraw!
map <C-S-F> :FindInFiles<SPACE>

map <Leader>gr :call FindInRepo()<CR>
function! FindInRepo()
  let wordUnderCursor = expand("<cword>")
  execute 'silent! Ggrep! ' . wordUnderCursor | cw | redraw!
endfunction

command -nargs=+ Ggr execute 'silent Ggrep!' <q-args> | cw | redraw!

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

" ctags
set tags=./.tags;

" nerdtree
let NERDTreeIgnore = ['__pycache__', '\.pyc$', 'build$', 'dist$', 'env$', '.*\.egg-info']
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


" go stuff
let g:go_fmt_command="goimports"

" Tor stuff
autocmd FileType yaml setlocal ts =2 sts=2 sw=2 expandtab indentkeys-=0# indentkeys-=<:>
" let b:ale_fixers=['autopep8', 'yapf']
let g:ale_fixers={'python': ['autopep8', 'yapf']}
let g:ale_fix_on_save=1


" rust stuff
set hidden
let g:racer_cmd = "/home/user/.cargo/bin/racer"
