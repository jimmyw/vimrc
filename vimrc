set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Plugin 'gmarik/Vundle.vim'
Plugin 'rust-lang/rust.vim'
"Plugin 'Valloric/YouCompleteMe'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'airblade/vim-gitgutter'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'fatih/vim-go'
"Plugin 'kien/ctrlp.vim'
Plugin 'kshenoy/vim-signature'
Plugin 'mileszs/ack.vim'
"Plugin 'yegappan/grep'
"Plugin 'bronson/vim-trailing-whitespace'

call vundle#end()
filetype plugin indent on

:filetype plugin on
:set spell spelllang=en_us

" https://dougblack.io/words/a-good-vimrc.html

" Colors
colorscheme default
set bg=dark
:syntax on

" Spaces & Tabs
set tabstop=2       " number of visual spaces per TAB
set softtabstop=2   " number of spaces in tab when editing
set expandtab       " tabs are spaces
set shiftwidth=2    " Steps for >> <<
set smartindent     " Indents smartly when programming c

" UI Config
set number          " show line numbers
set showcmd         " show command in bottom bar
filetype indent on  " load ~/.vim/indent/python.vim
set wildmode=longest:list " Defines how tab is working when opening files.
"set lazyredraw     " Will make vim little more snappy
"set ttyfast        " Will make vim little more snappy
set showmatch       " highlight matching [{()}]
set ls=2            " This makes Vim show a status line even when only one window is shown.
set statusline=%F%m%r%h%w\ ascii=\%03.3b\ hex=\%02.2B\ pos=%04l,%04v(%04c)\ (%p%%)\ len=%L\
set tabpagemax=100  " Maximum number of tabs
set mouse=i
set title           " Tells the terminalto set a correct title
set viminfo='10,\"100,:20,%,n~/.viminfo
set scrolloff=4     " number of context lines you would like to see above and below the cursor.
set history=1000    " Cmd history len
set guifont=Hasklig:h14
set backspace=2     " make backspace work like most other apps


" Searching
set hlsearch        " highlight matches
set incsearch       " search as characters are entered
set tags=./tags;/

" Encodings
set encoding=utf-8
set fileencodings=utf-8
set termencoding=utf-8


" Key bindings
let mapleader=","   " leader is comma
map <F1> :tabp<CR>
map <F2> :w<CR>
map <F3> :tabn<CR>
map <F4> :%s/\s\+$//<CR>
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
map <F6> :NERDTreeToggle<CR>
map <F8> :Fmt<CR>
map <F10> :q<CR>

"Ctrl - k, jump to tag in new tab
nmap <C-k> <C-w><C-]><C-w>T

nmap ,h :e %:p:s,.h$,.X123X,:s,.c$,.h,:s,.X123X$,.c,<CR>

"Git plugin
nmap ; <Plug>GitGutterNextHunk
nmap ' <Plug>GitGutterPrevHunk
nmap ö <Plug>GitGutterPrevHunk
nmap ä <Plug>GitGutterNextHunk

"Disable ex mode
map Q <Nop>


"Ctrl x and Ctrl c
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>
nmap <C-p> :set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
imap <C-p> <Esc>:set paste<CR>:r !pbpaste<CR>:set nopaste<CR>
nmap <C-f> :Ack <cword><CR>
nnoremap <C-l> :tab sp<CR>:YcmCompleter GoToDeclaration<CR>
nnoremap <C-h> :tab sp<CR>:YcmCompleter GoToDefinition<CR>


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

let g:ycm_confirm_extra_conf = 0
let g:go_fmt_fail_silently = 0
let g:go_auto_type_info = 1
set completeopt-=preview


let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

function! SetupEnvironment()
  let l:path = expand('%:p')
  if l:path =~ 'cleanflight'
    setlocal tabstop=4 softtabstop=0 expandtab shiftwidth=4
  endif
endfunction
autocmd! BufReadPost,BufNewFile * call SetupEnvironment()

if executable('ag')
  "let g:ackprg = 'ag --vimgrep'
  let g:ackprg = 'git grep'
endif

let CoVim_default_name = "jimmy"
let CoVim_default_port = "5555"

"map <C-K> :pyf /usr/local/Cellar/clang-format/2015-07-31/share/clang/clang-format.py<cr>
"imap <C-K> <c-o>:pyf /usr/local/Cellar/clang-format/2015-07-31/share/clang/clang-format.py<cr>

" Read vim settings from the git repo
"let git_settings = system("git config --get vim.settings")
"if strlen(git_settings)
"    exe "set" git_settings
" endif


