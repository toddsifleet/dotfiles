set nocompatible

" having some issues with this at home
" filetype plugin indent on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'kien/ctrlp.vim'
Bundle 'nanotech/jellybeans.vim'
Bundle 'ervandew/supertab'
Bundle 'tComment'
Bundle 'airblade/vim-gitgutter'
Bundle 'thoughtbot/vim-rspec'
Bundle 'othree/html5.vim'
Bundle 'stefanoverna/vim-i18n'
Bundle 'itchyny/lightline.vim'
Bundle 'tpope/vim-fugitive'

set backspace+=start,eol,indent
set rnu
set shiftwidth=2
set tabstop=2
set softtabstop=2
set expandtab
set smartindent
set laststatus=2

syntax enable
set hlsearch

colorscheme jellybeans
" Right rule
set colorcolumn=81

nmap <C-T>n :tabn<CR>
nmap <C-T>p :tabp<CR>

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

autocmd BufWritePre *.md,*.js,*.rb,*.js,*.hs,*.py,*.erb :%s/\s\+$//e
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" ctrlp stuff
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_root_markers = ['.ctrlp']

" Configure ctrlp for SPEED
if executable('ag')
  set grepprg=ag\ --nogroup\ --nocolor\ --ignore\ tags
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
  let g:ctrlp_use_caching = 0
endif

" Find in Files
command -nargs=+ -complete=file -bar FindInFiles silent! grep! <args>|cwindow|redraw!
map <C-S-F> :FindInFiles<SPACE>

" Find All References
map <C-K> :grep! "\b<C-R><C-W>\b"<CR>:cw<CR><CR>

" Rspec.vim mappings
let g:rspec_command = "!(hash zeus 2> /dev/null && \zeus rspec {spec}) || (hash zeus 2> /dev/null || bash -l -c 'rspec {spec}')"
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
vmap <Leader>t :call I18nTranslateString()<CR>

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
