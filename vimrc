set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'
"Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
"Bundle 'scrooloose/nerdtree'
Bundle 'airblade/vim-gitgutter'
"Bundle 'yegappan/grep'

filetype plugin indent on
:filetype plugin on 
:set spell spelllang=en_us

set tags=./tags;/
autocmd BufWritePre *.go Fmt

set expandtab
set tabstop=2
set shiftwidth=2

set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8
set title
set smartindent
set showmatch
set number
set mouse=i
set ls=2
set statusline=%F%m%r%h%w\ ascii=\%03.3b\ hex=\%02.2B\ pos=%04l,%04v(%04c)\ (%p%%)\ len=%L\
set wildmode=longest:list
set hlsearch
set incsearch
set viminfo='10,\"100,:20,%,n~/.viminfo
set bg=dark
:syntax on

map <F1> :tabp<CR>
map <F2> :w<CR>
map <F3> :tabn<CR>
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
map <F6> :NERDTree<CR>
map <F10> :q<CR>

"Ctrl - k, jump to tag in new tab
nmap <C-k> <C-w><C-]><C-w>T

nmap ö <Plug>GitGutterPrevHunk
nmap ä <Plug>GitGutterNextHunk

"Disable ex mode
map Q <Nop>

"Enable mouse scrolling
"set mouse=a
set tabpagemax=100

"Ctrl x and Ctrl c
vmap <C-x> :!pbcopy<CR>  
vmap <C-c> :w !pbcopy<CR><CR>

filetype indent on

"autocmd Filetype html setlocal ts=2 sts=2 sw=2
"autocmd Filetype css setlocal ts=2 sts=2 sw=2
"autocmd Filetype javascript setlocal ts=2 sts=2 sw=2

" Make ending space on files glow red
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$\| \+\ze\t/

" These functions make you return to the last place you edited the file after
" loading the file.
function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

:let Grep_Default_Filelist = '*.c *.h *.go' 
