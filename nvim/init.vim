
set termguicolors
"let base16colorspace = 256

let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

syntax enable
set showcmd                     " display incomplete commands
" filetype plugin indent on " Neovim default

" Defaults					            *nvim-defaults*
"
"  Syntax highlighting is enabled by default
"  :filetype plugin indent on is enabled by default
"
"  autoindent is set by default
"  autoread is set by default
"  backspace defaults to "indent,eol,start"
"  complete doesn't include "i"
"  display defaults to "lastline"
"  encoding defaults to "utf-8"
"  formatoptions defaults to "tcqj"
"  history defaults to 10000 (the maximum)
"  hlsearch is set by default
"  incsearch is set by default
"  langnoremap is set by default
"  laststatus defaults to 2 (statusline is always shown)
"  listchars defaults to "tab:> ,trail:-,nbsp:+"
"  mouse defaults to "a"
"  nocompatible is always set
"  nrformats defaults to "bin,hex"
"  sessionoptions doesn't include "options"
"  smarttab is set by default
"  tabpagemax defaults to 50
"  tags defaults to "./tags;,tags"
"  ttyfast is always set
"  viminfo includes "!"
"  wildmenu is set by default


" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" Color schemas
Plug 'chriskempson/base16-vim'
Plug 'mhartington/oceanic-next'
Plug 'junegunn/seoul256.vim'
Plug 'rakr/vim-one'

"Plug 'ryanoasis/vim-devicons'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Navigation
Plug 'tpope/vim-vinegar'


" Text edition
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
"gorkunov/smartpairs.vim
"gorkunov/smartpairs.vim
"gorkunov/smartpairs.vim
Plug 'cohama/lexima.vim'
" https://github.com/Raimondi/delimitMate ???


" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-startify'


"Plug 'bling/vim-bufferline'
" fzf, grepper, command-t

" Git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'
Plug 'int3/vim-extradite'


" Syntax
Plug 'aliva/vim-fish'
Plug 'stephpy/vim-yaml'
Plug 'mustache/vim-mustache-handlebars'
"Plug 'elzr/vim-json'
"PLug 'evanmiller/nginx-vim-syntax'
"PLug 'kurayama/systemd-vim-syntax'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'rust-lang/rust.vim'
"PLug 'wting/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'  " Typescript



Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-jdaddy'

Plug 'editorconfig/editorconfig-vim'
"Plug 'neomake/neomake' ????
" or tcomment???


"Plug 'tpope/vim-flagship'????
"https://github.com/Valloric/MatchTagAlways ???
"https://github.com/Chiel92/vim-autoformat  ???
" multiple cursors??


"Plug 'francoiscabrol/ranger.vim'
"Plug 'rbgrouleff/bclose.vim'


" Add plugins to &runtimepath
call plug#end()


" Automatically install missing plugins on startup
if !empty(filter(copy(g:plugs), '!isdirectory(v:val.dir)'))
  PlugInstall
endif


colorscheme base16-default-dark


" Airline {{{

" set laststatus=2  " Neovim default
set noshowmode
"let g:airline_theme='powerlineish'
let g:airline_theme='oceanicnext'
" let g:airline_theme='base16_default' " same as base16-default-dark
let g:airline_powerline_fonts=1

let g:airline#extensions#hunks#non_zero_only = 1
let g:airline#extensions#whitespace#enabled = 1
let g:airline#extensions#whitespace#checks = [ 'indent', 'trailing' ]
let g:airline#extensions#branch#enabled = 1

"let g:airline#extensions#tabline#show_buffers=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#show_close_button = 0
"let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#tabs_label = 't'

"let g:tablabel = "%N%{flagship#tabmodified()} %{flagship#tabcwds('shorten',',')}"
"set laststatus=2
"set showtabline=2
"set guioptions-=e

"let g:airline_mode_map = {
"      \ '__' : '-',
"      \ 'n'  : 'N',
"      \ 'i'  : 'I',
"      \ 'R'  : 'R',
"      \ 'c'  : 'C',
"      \ 'v'  : 'V',
"      \ 'V'  : 'V',
"      \ '' : 'V',
"      \ 's'  : 'S',
"      \ 'S'  : 'S',
"      \ '' : 'S',
"      \ }


" }}}


set relativenumber
set number

" Neovim terminal mapping
" terminal 'normal mode'
tmap <esc> <c-\><c-n><esc><cr>

" give it a try and you will like it
" nnoremap ; :
" nnoremap : ;


nnoremap <leader>d "_d
vnoremap <leader>d "_d
"map <esc> :noh<cr>
