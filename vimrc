set nocompatible              " be iMproved
filetype off                  " required!

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
Bundle 'gmarik/Vundle.vim'
Bundle 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'airblade/vim-gitgutter'
Bundle 'nsf/gocode', {'rtp': 'vim/'}
Bundle 'fsouza/go.vim'
"Bundle 'kien/ctrlp.vim'
" Tool for co-op vimm
"Bundle 'FredKSchott/CoVim'
Bundle 'kshenoy/vim-signature'
"Bundle 'yegappan/grep'

call vundle#end()
filetype plugin indent on

:filetype plugin on
:set spell spelllang=en_us

autocmd BufWritePre *.go Fmt

set backspace=2
set bg=dark
set encoding=utf-8
set expandtab
set fileencodings=utf-8
set hlsearch
set incsearch
set ls=2
set mouse=i
set number
set shiftwidth=2
set showmatch
set smartindent
set statusline=%F%m%r%h%w\ ascii=\%03.3b\ hex=\%02.2B\ pos=%04l,%04v(%04c)\ (%p%%)\ len=%L\
set tabpagemax=100
set tabstop=2
set tags=./tags;/
set termencoding=utf-8
set title
set viminfo='10,\"100,:20,%,n~/.viminfo
set wildmode=longest:list
set scrolloff=4

" Will make vim little more snappy
"set lazyredraw
"set ttyfast

:syntax on

map <F1> :tabp<CR>
map <F2> :w<CR>
map <F3> :tabn<CR>
map <F4> :%s/\s\+$//<CR>
:nnoremap <silent> <F5> :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>
map <F6> :NERDTree<CR>
map <F8> :Fmt<CR>
map <F10> :q<CR>
nnoremap <C-l> :tab sp<CR>:YcmCompleter GoToDeclaration<CR>
nnoremap <C-h> :tab sp<CR>:YcmCompleter GoToDefinition<CR>

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

func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

func GitGrepWord()
  normal! "zyiw
  call GitGrep('-w -e ', getreg('z'))
endf
nmap <C-g> :call GitGrepWord()<CR>

