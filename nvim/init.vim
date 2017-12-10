" vim: fdm=marker
"
"     ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
"     ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
"     ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
"     ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
"     ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
"     ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
"
"      ██████╗ ██████╗ ███╗   ██╗███████╗██╗ ██████╗
"     ██╔════╝██╔═══██╗████╗  ██║██╔════╝██║██╔════╝
"     ██║     ██║   ██║██╔██╗ ██║█████╗  ██║██║  ███╗
"     ██║     ██║   ██║██║╚██╗██║██╔══╝  ██║██║   ██║
"     ╚██████╗╚██████╔╝██║ ╚████║██║     ██║╚██████╔╝
"      ╚═════╝ ╚═════╝ ╚═╝  ╚═══╝╚═╝     ╚═╝ ╚═════╝
"
" Author: José Luis Lafuente <jl@lafuente.me>
"
"
" ============================================================================
" Neovim default {{{1
" ============================================================================
" See https://github.com/neovim/neovim/issues/2676
"
" Defaults					            *nvim-defaults*
"
"  Syntax highlighting is enabled by default (syntax enable)
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
"
" END Neovim defaults


" ============================================================================
" Plugins (administrated by Plug) {{{1
" ============================================================================

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
Plug 'joshdick/onedark.vim'
Plug 'MaxSt/FlatColor'
Plug 'KabbAmine/yowish.vim'
Plug 'mhinz/vim-janah'
" Plug 'dracula/vim'
Plug 'liuchengxu/space-vim-dark'


"Plug 'ryanoasis/vim-devicons'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Navigation
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-vinegar'
Plug 'Shougo/vimfiler.vim' | Plug 'Shougo/unite.vim'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'dyng/ctrlsf.vim'
"Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
Plug 'takac/vim-hardtime'


" Text edition
"Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
"gorkunov/smartpairs.vim
"Plug 'cohama/lexima.vim'
Plug 'jiangmiao/auto-pairs'
"Plug 'Raimondi/delimitMate' ???
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-endwise'
Plug 'ntpeters/vim-better-whitespace'
Plug 'tpope/vim-speeddating'
Plug 'bfredl/nvim-miniyank'
Plug 'tweekmonster/headlines.vim'
Plug 'jlesquembre/rst-tables.nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'machakann/vim-swap'
Plug 'mattn/emmet-vim'


" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-halo'
"Plug 'haya14busa/vim-operator-flashy' | Plug 'kana/vim-operator-user'
Plug 'machakann/vim-highlightedyank'
Plug 'fszymanski/ListToggle.vim'
"Plug 'itchyny/vim-cursorword'

" TODO index search plugins will be natively supported by vim, see:
" https://github.com/vim/vim/issues/453
Plug 'henrik/vim-indexed-search'
" Plug 'google/vim-searchindex'


" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
Plug 'int3/vim-extradite'
"Plug 'lambdalisue/gina.vim'


" Syntax
Plug 'tpope/vim-markdown'
Plug 'aliva/vim-fish'
Plug 'stephpy/vim-yaml'
Plug 'mustache/vim-mustache-handlebars'
"Plug 'mitsuhiko/vim-python-combined'
"Plug 'elzr/vim-json'
"Plug 'evanmiller/nginx-vim-syntax'
Plug 'chr4/nginx.vim'
"PLug 'kurayama/systemd-vim-syntax'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'rust-lang/rust.vim'
"PLug 'wting/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'  " Typescript
"Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': 'tex'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'lifepillar/pgsql.vim'
Plug 'LnL7/vim-nix'
Plug 'cespare/vim-toml'
Plug 'purescript-contrib/purescript-vim'

Plug 'ap/vim-css-color'  " Needs to be loaded AFTER the syntax

" General utils
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'radenling/vim-dispatch-neovim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tpope/vim-projectionist'
"Plug 'neomake/neomake'
"Plug 'sbdchd/neoformat'
Plug 'w0rp/ale'
Plug 'kassio/neoterm'
Plug 'metakirby5/codi.vim'

" Autocompletion
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/nvim-cm-tern',  {'do': 'yarn install'}
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'othree/csscomplete.vim'

" Clojure
"Plug 'kovisoft/paredit',    { 'for': 'clojure' }
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-clojure-highlight' | Plug 'guns/vim-clojure-static'

"TODO pin to commit until node-host is merged into core neovim, see:
" https://github.com/neovim/node-host/pull/27#issuecomment-317672178
Plug 'neovim/node-host', { 'dir': '~/.config/nvim/plugged/node-host', 'do': 'yarn install', 'commit': '0c116cb3b48af7' }

Plug 'clojure-vim/nvim-parinfer.js', {'do': ':UpdateRemotePlugins'}
Plug 'clojure-vim/async-clj-omni'

Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
"Plug 'clojure-vim/neovim-client', { 'for': 'clojure' }
"Plug 'jebberjeb/clojure-socketrepl.nvim', { 'for': 'clojure' }

Plug 'guns/vim-slamhound'
"Plug 'venantius/vim-cljfmt'

"Plug 'hkupty/acid.nvim', {'do':':UpdateRemotePlugins'}
"Plug 'hkupty/iron.nvim', {'do':':UpdateRemotePlugins'}
"Plug 'tpope/vim-classpath'
"Plug 'tpope/vim-salve'

"Plug 'junegunn/vim-easy-align'

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


" END Plugins


" ============================================================================
" BASIC SETTINGS {{{1
" ============================================================================

set termguicolors
"let base16colorspace=256
"set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
"\,sm:block-blinkwait175-blinkoff150-blinkon175
"\,a:blinkwait700-blinkoff400-blinkon250-Cursor
"\,n-v-c:blinkwait700-blinkoff400-blinkon250

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=bash
  let $SHELL='bash'
endif

set hidden
set relativenumber
set number
set tildeop
set ignorecase
set smartcase
set noshowmode
set showcmd                     " display incomplete commands
set cursorline
set clipboard+=unnamedplus  " Use "+ register
set inccommand=split

" Better folds
"set foldcolumn=1
set foldmethod=marker
set foldopen+=jump

"set splitbelow
"set splitright

let mapleader="\<SPACE>"
let maplocalleader="\<SPACE>"


" Backups

set backup
set swapfile

let tmpvim_dir = "/tmp/nvim/"
execute "set backupdir=".tmpvim_dir."backup/"
execute "set undodir=".tmpvim_dir."undo/"
execute "set directory=".tmpvim_dir."swap/"
set shada='1000,<500,s100,h " file saved at ~/.local/share/nvim
set viewdir=$HOME/.config/nvim/views

" make this dirs if no exists previously
function! MakeDirIfNoExists(path)
    if !isdirectory(expand(a:path))
        call mkdir(expand(a:path), "p")
    endif
endfunction
silent! call MakeDirIfNoExists(&backupdir)
silent! call MakeDirIfNoExists(&undodir)
silent! call MakeDirIfNoExists(&directory)
silent! call MakeDirIfNoExists(&viewdir)


" Make sure you dont change logfiles
augroup readonly_files
  autocmd!
  autocmd BufNewFile,BufRead /var/log/* set readonly
  autocmd BufNewFile,BufRead /var/log/* set nomodifiable
augroup END


" Set augroup
" See https://vi.stackexchange.com/a/9458/2660
augroup user_augroup
  autocmd!
augroup END

autocmd user_augroup FileType help wincmd K

" Help NeoVim check for modified files: https://github.com/neovim/neovim/issues/2127
autocmd user_augroup BufEnter,FocusGained * checktime

" The PC is fast enough, do syntax highlight syncing from start
autocmd user_augroup BufEnter * :syntax sync fromstart

" Only use cursorline for current window
autocmd user_augroup WinEnter,FocusGained * setlocal cursorline
autocmd user_augroup WinLeave,FocusLost   * setlocal nocursorline

" END BASIC SETTINGS

" ============================================================================
" COLORSCHEMA {{{1
" ============================================================================

function! s:rgb2color(r,g,b)
  " Convert 80% -> 204, 100% -> 255, etc.
  let rgb = map( [a:r,a:g,a:b], 'v:val =~ "%$" ? ( 255 * v:val ) / 100 : v:val' )
  return printf( '%02x%02x%02x', rgb[0], rgb[1], rgb[2] )
endfunction
function! s:hex2rgb(color)
  let color = tolower(a:color)
  let r = str2nr(printf( '0x%s', color[0:1] ), 16)
  let g = str2nr(printf( '0x%s', color[2:3] ), 16)
  let b = str2nr(printf( '0x%s', color[4:5] ), 16)
  return [r, g, b]
endfunction
function! s:mixcolors(colorA, colorB, ...)
  let colorA = s:hex2rgb(a:colorA)
  let colorB = s:hex2rgb(a:colorB)

  let factorA = a:0 > 0 ? a:1 : 0.6
  let factorB = 1 - factorA

  let r = float2nr((colorA[0] * factorA + colorB[0] * factorB) / 2)
  let g = float2nr((colorA[1] * factorA + colorB[1] * factorB) / 2)
  let b = float2nr((colorA[2] * factorA + colorB[2] * factorB) / 2)
  return s:rgb2color(r, g, b)
endfunction


function! g:Base16_customize() abort
  call Base16hi("MatchParen",    g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold,italic", "")
  call Base16hi("CursorLineNr",  g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold", "")
  call Base16hi("QuickFixLine",  g:base16_gui00, g:base16_gui09, g:base16_cterm00, g:base16_cterm09, "none", "")
  call Base16hi("PMenu",         g:base16_gui04, g:base16_gui01, g:base16_cterm04, g:base16_cterm01, "none", "")
  call Base16hi("PMenuSel",      g:base16_gui01, g:base16_gui04, g:base16_cterm01, g:base16_cterm04, "", "")

  " Diff
  let s:guiDiffAdd = s:mixcolors(g:base16_gui00, g:base16_gui0B, 0.3)
  let s:guiDiffDelete = s:mixcolors(g:base16_gui00, g:base16_gui08)
  let s:guiDiffChange = s:mixcolors(g:base16_gui00, g:base16_gui0D, 0.3)
  let s:guiDiffText = s:mixcolors(g:base16_gui00, g:base16_gui08, 0.2)
  call Base16hi("DiffAdd",      "none", s:guiDiffAdd,  "none", s:guiDiffAdd, "", "")
  call Base16hi("DiffChange",   "none", s:guiDiffChange,  "none", s:guiDiffChange, "", "")
  call Base16hi("DiffDelete",   g:base16_gui08, g:base16_gui00,  g:base16_cterm08, g:base16_cterm00, "", "")
  call Base16hi("DiffText",     "none", s:guiDiffText,  "none", s:guiDiffText, "", "")

  " Quickfix list window
  call Base16hi("qfFileName", g:base16_gui0B, "", g:base16_cterm0B, "", "", "")
  call Base16hi("qfLineNr", g:base16_gui03, g:base16_gui01, g:base16_cterm03, g:base16_cterm01, "", "")
  call Base16hi("qfSeparator", g:base16_gui05, g:base16_gui00, g:base16_cterm05, g:base16_cterm00, "", "")

  " Vim syntax
  call Base16hi("vimCommand",   g:base16_gui0E, "", g:base16_cterm0E, "", "", "")
  call Base16hi("vimUserCommand",   g:base16_gui0E, "", g:base16_cterm0E, "", "", "")
  call Base16hi("vimMap",   g:base16_gui0E, "", g:base16_cterm0E, "", "", "")
  call Base16hi("vimLet",   g:base16_gui0E, "", g:base16_cterm0E, "", "", "")
  call Base16hi("vimSet",   g:base16_gui0E, "", g:base16_cterm0E, "", "", "")

endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call g:Base16_customize()
augroup END

colorscheme base16-default-dark
"colorscheme onedark

" END COLORSCHEMA

" ============================================================================
" FUNCTIONS {{{1
" ============================================================================

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" Window chooser
function! ChooseWindow()
    let winnr = unite#helper#choose_window()
    call vimfiler#util#winmove(winnr)
endfunc


function! s:strip(str)
python3 << EOF
import vim
from html import unescape
# replace non-breaking space, see https://stackoverflow.com/a/38010708/799785
result = unescape(vim.eval("a:str")).strip(" \t\n\r\f\v'\"").replace("\xa0", " ")
vim.command('return "{}"'.format(result))
EOF
endfunction

function! FormatLink(format)
  let l:link = s:strip(getline('.'))

  let l:title = system('wget -qO- '. shellescape(l:link) . ' | gawk -v IGNORECASE=1 -v RS=''</title'' ''RT{gsub(/.*<title[^>]*>/,"");print;exit}'' ')
  let b:title = s:strip(l:title)
  let l:title = substitute(b:title, '\v\s+[\-\|]\s+\p+$', '', 'gi')

  if a:format == ''
    let l:format = expand('%:e')
  else
    let l:format = a:format
  endif

  if (index(['md'], l:format) >= 0)
    let l:newline = '[' . l:title . '](' . l:link . ')'
  else
    let l:newline = '`' . l:title . ' <' . l:link . '>`_'
  endif

  call setline('.', l:newline)
  normal 0

  echomsg 'Original title (saved on b:title): ' . b:title

endfunction


" END FUNCTIONS

" ============================================================================
" SYNTAX {{{1
" ============================================================================

let g:sql_type_default = 'pgsql'

" END SYNTAX

" ============================================================================
" COMMANDS {{{1
" ============================================================================

cnoreabbrev Q q
cnoreabbrev Qa qa

" I never remember the StripWhitespace command
command! RemoveWhitespace execute "StripWhitespace"
command! DeleteWhitespace execute "StripWhitespace"


" Save as root
"cnoremap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>
cnoreabbrev w!! silent execute "w !sudo tee % > /dev/null" \| e!
"command! Sudow execute "w !sudo tee > /dev/null %"


" END COMMANDS


" ============================================================================
" MAPPINGS {{{1
" ============================================================================

"noremap <Leader><Space> :noh<CR>

" Neovim terminal mapping
" terminal 'normal mode'
tmap <esc> <c-\><c-n>

" give it a try and you will like it
" nnoremap ; :
" nnoremap : ;

" Make yank more logical
map Y y$

"nmap <leader>w <C-w>
nnoremap <leader>w <C-w>

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Fast quit
nnoremap <leader>qq :q<cr>
nnoremap <leader>qa :qa<cr>
nnoremap <leader>qw :x<cr>

" Fast window moves
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <leader>wt <C-w>T

" Not needed, provided by vim-indexed-search plugin
" Saner behavior of n and N
" nnoremap <silent><expr> n 'Nn'[v:searchforward]
" nnoremap <silent><expr> N 'nN'[v:searchforward]
" nnoremap <silent><expr> n 'Nn'[v:searchforward] . 'zv:call halo#run()<cr>'
" nnoremap <silent><expr> N 'nN'[v:searchforward] . 'zv:call halo#run()<cr>'
let g:indexed_search_mappings = 0
nmap / <Plug>(indexed-search-/)
nmap ? <Plug>(indexed-search-?)
nmap * <Plug>(indexed-search-*)
nmap # <Plug>(indexed-search-#)
noremap <silent><expr> n 'Nn'[v:searchforward] . ':ShowSearchIndex<CR>zv:call halo#run()<cr>'
noremap <silent><expr> N 'nN'[v:searchforward] . ':ShowSearchIndex<CR>zv:call halo#run()<cr>'

" Saner command-line history
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Saner CTRL-L
nnoremap <leader>l :nohlsearch<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Quick saving
nnoremap <silent> <Leader>s :update<CR>

" Show syntax highlighting groups for word under cursor
nnoremap <F10> :call <SID>SynStack()<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" move to beginning/end of line
nnoremap <silent> <Leader>b ^
nnoremap <silent> <Leader>e $

" Quick breakpoints
augroup AutoBreakpoint
  autocmd!
  autocmd FileType python map <silent> <leader><leader>b oimport ipdb; ipdb.set_trace()<esc>
  autocmd FileType python map <silent> <leader><leader>B Oimport ipdb; ipdb.set_trace()<esc>
  autocmd FileType javascript map <silent> <leader><leader>b odebugger;<esc>
  autocmd FileType javascript map <silent> <leader><leader>B Odebugger;<esc>
augroup END

" highlight last inserted text
nnoremap gV `[v`]

" open file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<cr>

" Faster esc
inoremap <c-space> <esc>
vnoremap <c-space> <esc>
onoremap <c-space> <esc>
cnoremap <c-space> <c-c>
nnoremap <c-space> <esc>
"inoremap <c-j> <esc>

" Search and replace
nnoremap <Leader>rr :%s//g<Left><Left>
nnoremap <Leader>rw :%s/\<<C-r><C-w>\>//g<Left><Left>
vnoremap <Leader>rr :s//g<Left><Left>
"vnoremap <Leader>rw :s/\<<C-r><C-w>\>//g<Left><Left>

" Search and replace in all files in the quicklist
nnoremap <Leader>rq :cfdo %s/\<<C-r><C-w>\>//g \| update<C-Left><C-Left><Left><Left><Left>
" Undo previous action
nnoremap <Leader>ru :cfdo undo \| update

nnoremap <silent> <Leader>u :call FormatLink('')<cr>
" nnoremap <Leader>um :call FormatLink('md')<cr>
" nnoremap <Leader>ur :call FormatLink('rst')<cr>


" END MAPPINGS

" ============================================================================
" VIM STARTIFY {{{1
" ============================================================================

let g:startify_change_to_vcs_root = 1
let g:startify_session_dir = '~/.config/nvim/session'

" END STARTIFY

" ============================================================================
" VIM ROOTER {{{1
" ============================================================================

let g:rooter_silent_chdir = 1

" END ROOTER

" ============================================================================
" VIM SANDWICH {{{1
" ============================================================================


nmap s <Nop>
xmap s <Nop>

"let g:sandwich_no_default_key_mappings = 1
"
onoremap <SID>line :normal! ^vg_<CR>
nmap sa <Plug>(operator-sandwich-add)
nmap sal <Plug>(operator-sandwich-add)<SID>line

nmap sdd <Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)
nmap srr <Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)

" select the nearest surrounded text automatically
xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)

" END SANDWICH


" ============================================================================
" VIM EASYMOTION {{{1
" ============================================================================

let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
let g:EasyMotion_use_smartsign_us = 1
let g:EasyMotion_move_highlight = 0
let g:EasyMotion_startofline = 0
"let g:EasyMotion_use_upper = 1
"let g:EasyMotion_keys = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ;'

nmap s; <Plug>(easymotion-next)
nmap s, <Plug>(easymotion-prev)

"s
nmap s <Nop>
nmap ss <Plug>(easymotion-overwin-f)
xmap ss <Plug>(easymotion-bd-f)
omap ss <Plug>(easymotion-bd-f)

" f
nmap sf <Plug>(easymotion-f)
xmap sf <Plug>(easymotion-f)
omap sf <Plug>(easymotion-f)

" F
nmap sF <Plug>(easymotion-F)
xmap sF <Plug>(easymotion-F)
omap sF <Plug>(easymotion-F)

" t
nmap st <Plug>(easymotion-t)
xmap st <Plug>(easymotion-t)
omap st <Plug>(easymotion-t)

" T
nmap sT <Plug>(easymotion-T)
xmap sT <Plug>(easymotion-T)
omap sT <Plug>(easymotion-T)

" w
nmap sw <Plug>(easymotion-w)
xmap sw <Plug>(easymotion-w)
omap sw <Plug>(easymotion-w)

" W
nmap sW <Plug>(easymotion-W)
xmap sW <Plug>(easymotion-W)
omap sW <Plug>(easymotion-W)

" b
nmap sb <Plug>(easymotion-b)
xmap sb <Plug>(easymotion-b)
omap sb <Plug>(easymotion-b)

" B
nmap sB <Plug>(easymotion-B)
xmap sB <Plug>(easymotion-B)
omap sB <Plug>(easymotion-B)

" e
nmap se <Plug>(easymotion-e)
xmap se <Plug>(easymotion-e)
omap se <Plug>(easymotion-e)

" E
nmap sE <Plug>(easymotion-E)
xmap sE <Plug>(easymotion-E)
omap sE <Plug>(easymotion-E)

" ge
nmap sge <Plug>(easymotion-ge)
xmap sge <Plug>(easymotion-ge)
omap sge <Plug>(easymotion-ge)

" gE
nmap sgE <Plug>(easymotion-gE)
xmap sgE <Plug>(easymotion-gE)
omap sgE <Plug>(easymotion-gE)

" j
nmap sj <Plug>(easymotion-j)
xmap sj <Plug>(easymotion-j)
omap sj <Plug>(easymotion-j)

" k
nmap sk <Plug>(easymotion-k)
xmap sk <Plug>(easymotion-k)
omap sk <Plug>(easymotion-k)

" n
nmap sn <Plug>(easymotion-n)
xmap sn <Plug>(easymotion-n)
omap sn <Plug>(easymotion-n)

" N
nmap sN <Plug>(easymotion-N)
xmap sN <Plug>(easymotion-N)
omap sN <Plug>(easymotion-N)

map  s/ <Plug>(easymotion-sn)
omap s/ <Plug>(easymotion-tn)

nmap <leader>j <Plug>(easymotion-overwin-line)
xmap <leader>j <Plug>(easymotion-bd-jk)
omap <leader>j <Plug>(easymotion-bd-jk)


" END EASYMOTION


" ============================================================================
" VIM MARKDOWN {{{1
" ============================================================================

let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
"let g:markdown_syntax_conceal = 0

" END VIM MARKDOWN


" ============================================================================
" GIT GUTTER {{{1
" ============================================================================

nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hd <Plug>GitGutterUndoHunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk
omap ih <Plug>GitGutterTextObjectInnerPending
omap ah <Plug>GitGutterTextObjectOuterPending
xmap ih <Plug>GitGutterTextObjectInnerVisual
xmap ah <Plug>GitGutterTextObjectOuterVisual

" END GIT GUTTER


" ============================================================================
" FUGITIVE {{{1
" ============================================================================

nnoremap <leader>gww :Gwrite<CR>
" <Bar> is the pipe (|) char. Gwrite output is shown, and Gcommit is not
" executed if there is an error with Gwrite, and alternative map is:
" nnoremap <leader>gwc :Gwrite<CR>:Gcommit<CR>
" but in that case we lose the Gwrite output (unless there is an error)
nnoremap <leader>gwc :Gwrite<Bar>:Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gs :Gstatus<CR>
nnoremap <leader>gcc :Gcommit<CR>
nnoremap <leader>gp :Gpush<CR>
"nnoremap <leader>gr :Git reset -q -- %<CR>

" END FUGITIVE

" ============================================================================
" VIMAGIT (MAGIT) {{{1
" ============================================================================

let g:magit_show_magit_mapping='<leader>gm'
let g:magit_default_fold_level=2

" END

" ============================================================================
" GREPPER {{{1
" ============================================================================

let g:grepper = {
    \ 'tools': ['rgextra', 'rg', 'git', 'grep'],
    \ 'highlight': 0,
    \ 'rgextra':
    \   { 'grepprg':    "rg --no-heading --vimgrep --hidden -g '!.git/' -S",
    \     'grepformat': '%f:%l:%c:%m',
    \     'escape':     '\^$.*+?()[]{}|' },
    \ }

nnoremap gss  :Grepper<cr>
nmap gs  <plug>(GrepperOperator)
xmap gs  <plug>(GrepperOperator)

" END GREPPER


" ============================================================================
" FZF {{{1
" ============================================================================

" File preview using Highlight (http://www.andre-simon.de/doku/highlight/en/highlight.php)
let g:fzf_files_options = '--preview "(file -ib {} | rg binary || highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

nnoremap <silent> <Leader>f       :FilesRg<CR>
nnoremap <silent> <Leader>ff      :FilesRg<CR>
nnoremap <silent> <Leader>fg      :GFiles<CR>
nnoremap <silent> <Leader>fc      :Colors<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>fr     :Find <C-R><C-W>
xnoremap <silent> <Leader>fr     y:Find <C-R>"<CR>
" nnoremap <silent> <Leader>ag      :Ag <C-R><C-W><CR>
" nnoremap <silent> <Leader>AG      :Ag <C-R><C-A><CR>
" xnoremap <silent> <Leader>ag      y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`       :Marks<CR>
" nnoremap <silent> q: :History:<CR>
" nnoremap <silent> q/ :History/<CR>

"inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)


command! -bang -nargs=? -complete=dir FilesRg  call fzf#vim#files(<q-args>, {
  \ 'source': 'rg --files --hidden -g "!.git/"'
  \ },
  \ <bang>0)


command! -bang -nargs=* Find
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)


command! Plugs call fzf#run({
  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
  \ 'options': '--delimiter / --nth -1',
  \ 'down':    '~30%',
  \ 'sink':    'VimFiler'})

" END FZF


" ============================================================================
" BETTER WHITESPACE {{{1
" ============================================================================

let g:better_whitespace_filetypes_blacklist = [
\ 'magit',
\ 'diff', 'gitcommit', 'unite', 'qf', 'help'
\ ]

" END BETTER WHITESPACE

" ============================================================================
" AIRLINE {{{1
" ============================================================================

" set laststatus=2  " Neovim default
"let g:airline_theme='powerlineish'
let g:airline_theme='oceanicnext'
"let g:airline_theme='onedark'
" let g:airline_theme='base16_default' " same as base16-default-dark
let g:airline_powerline_fonts = 1

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
let g:airline#extensions#ale#enabled = 1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

let g:airline_symbols.maxlinenr = ''


"let g:tablabel = "%N%{flagship#tabmodified()} %{flagship#tabcwds('shorten',',')}"
"set laststatus=2
"set showtabline=2
"set guioptions-=e

let g:airline_mode_map = {
      \ '__' : '-',
      \ 'n'  : 'N',
      \ 'i'  : 'I',
      \ 'R'  : 'R',
      \ 'c'  : 'C',
      \ 'v'  : 'V',
      \ 'V'  : 'V',
      \ '' : 'V',
      \ 's'  : 'S',
      \ 'S'  : 'S',
      \ '' : 'S',
      \ }


" END AIRLINE


" ============================================================================
" VIMFILER {{{1
" ============================================================================
"nmap <buffer> - :VimFilerBufferDir<CR>
nnoremap - :VimFilerBufferDir<CR>
nnoremap <Leader>- :VimFilerExplorer<CR>

let g:vimfiler_as_default_explorer = 1
let g:loaded_netrwPlugin = 1 " Disable netrw.vim

call vimfiler#custom#profile('default', 'context', {
      \ 'safe' : 0,
      \ 'auto_expand' : 1,
      \ 'parent' : 0,
      \ })
let g:vimfiler_tree_leaf_icon = ' '
let g:vimfiler_tree_opened_icon = '▾'
let g:vimfiler_tree_closed_icon = '▸'
let g:vimfiler_file_icon = ' '
let g:vimfiler_readonly_file_icon = '✗'
let g:vimfiler_marked_file_icon = '✓'

let g:vimfiler_force_overwrite_statusline = 0
let g:vimfiler_time_format= "%Y/%m/%d %H:%M"

autocmd user_augroup FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() abort

  nnoremap <silent><buffer><expr> gt vimfiler#do_action('tabopen')
  nnoremap <silent><buffer><expr> v vimfiler#do_switch_action('vsplit')
  nnoremap <silent><buffer><expr> s vimfiler#do_switch_action('split')
  "nmap <buffer> p <Plug>(vimfiler_quick_look)
  nmap <buffer> <Tab> <Plug>(vimfiler_switch_to_other_window)

  " move/copy/delete cursor file in one key
  nmap <buffer> c <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_copy_file)
  nmap <buffer> m <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_move_file)
  nmap <buffer> d <Plug>(vimfiler_mark_current_line)<Plug>(vimfiler_delete_file)

  nmap <buffer> - <Plug>(vimfiler_switch_to_parent_directory)

endfunction


" Title string.
"let &g:titlestring="
"      \ %{expand('%:p:~:.')}%(%m%r%w%)
"      \ %<\(%{WidthPart(
"      \ fnamemodify(&filetype ==# 'vimfiler' ?
"      \ substitute(b:vimfiler.current_dir, '.\\zs/$', '', '') : getcwd(), ':~'),
"      \ &columns-len(expand('%:p:.:~')))}\) - VIM"
"nmap <buffer> - <Plug>VinegarUp

let g:vimfiler_ignore_pattern = ['^\.git$', '^\.DS_Store$']
" Default value is ['^\.'] (dot files pattern).


" END VIMFILER


" ============================================================================
" VIMTEX {{{1
" ============================================================================

let g:vimtex_latexmk_progname = '$HOME/.local/share/virtualenvs/nvr/bin/nvr'

let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
let g:vimtex_view_general_options_latexmk = '--unique'
"let g:vimtex_view_method = 'zathura'
let g:vimtex_view_automatic = 1
let g:vimtex_latexmk_build_dir = '/tmp/vimtext_output'

let g:vimtex_quickfix_open_on_warning = 1
"let g:vimtex_index_split_pos = 'below'
let g:vimtex_fold_enabled = 0
let g:vimtex_format_enabled = 1
"let g:vimtex_imaps_leader = ';'
"let g:vimtex_complete_img_use_tail = 1

" END VIMTEX


" ============================================================================
" VIM HARDMODE {{{1
" ============================================================================

let g:hardtime_default_on = 0
let g:hardtime_showmsg = 0
let g:hardtime_ignore_quickfix = 1

" END HARDMODE


" ============================================================================
" AUTOPAIRS {{{1
" ============================================================================

let g:AutoPairsMapSpace=0

" END AUTOPAIRS


" ============================================================================
" HIGHLIGHTED YANK (OPERATOR FLASHY) {{{1
" ============================================================================

"let g:operator#flashy#flash_time = 600
"map y <Plug>(operator-flashy)
"nmap Y <Plug>(operator-flashy)$

let g:highlightedyank_highlight_duration = 500
" Not required on neovim
" map y <Plug>(highlightedyank)
" map Y <Plug>(highlightedyank)$

hi HighlightedyankRegion cterm=reverse gui=reverse

" END OPERATOR FLASHY



" ============================================================================
" MINIYANK  {{{1
" ============================================================================

" Use normal and visual remap, see:
" https://github.com/bfredl/nvim-miniyank/issues/8
nmap p <Plug>(miniyank-autoput)
xmap p <Plug>(miniyank-autoput)

nmap P <Plug>(miniyank-autoPut)
xmap P <Plug>(miniyank-autoPut)

nmap <leader>p <Plug>(miniyank-cycle)
xmap <leader>p <Plug>(miniyank-cycle)

"map <Leader>pc <Plug>(miniyank-tochar)
"map <Leader>pl <Plug>(miniyank-toline)
"map <Leader>pb <Plug>(miniyank-toblock)

" END MINIYANK

" ============================================================================
" CLOJURE {{{1
" ============================================================================

" Disable predefined sexp mappings {{{2

let g:sexp_mappings = {
    \ 'sexp_outer_list':                '',
    \ 'sexp_inner_list':                '',
    \ 'sexp_outer_top_list':            '',
    \ 'sexp_inner_top_list':            '',
    \ 'sexp_outer_string':              '',
    \ 'sexp_inner_string':              '',
    \ 'sexp_outer_element':             '',
    \ 'sexp_inner_element':             '',
    \ 'sexp_move_to_prev_bracket':      '',
    \ 'sexp_move_to_next_bracket':      '',
    \ 'sexp_move_to_prev_element_head': '',
    \ 'sexp_move_to_next_element_head': '',
    \ 'sexp_move_to_prev_element_tail': '',
    \ 'sexp_move_to_next_element_tail': '',
    \ 'sexp_flow_to_prev_close':        '',
    \ 'sexp_flow_to_next_open':         '',
    \ 'sexp_flow_to_prev_open':         '',
    \ 'sexp_flow_to_next_close':        '',
    \ 'sexp_flow_to_prev_leaf_head':    '',
    \ 'sexp_flow_to_next_leaf_head':    '',
    \ 'sexp_flow_to_prev_leaf_tail':    '',
    \ 'sexp_flow_to_next_leaf_tail':    '',
    \ 'sexp_move_to_prev_top_element':  '',
    \ 'sexp_move_to_next_top_element':  '',
    \ 'sexp_select_prev_element':       '',
    \ 'sexp_select_next_element':       '',
    \ 'sexp_indent':                    '',
    \ 'sexp_indent_top':                '',
    \ 'sexp_round_head_wrap_list':      '',
    \ 'sexp_round_tail_wrap_list':      '',
    \ 'sexp_square_head_wrap_list':     '',
    \ 'sexp_square_tail_wrap_list':     '',
    \ 'sexp_curly_head_wrap_list':      '',
    \ 'sexp_curly_tail_wrap_list':      '',
    \ 'sexp_round_head_wrap_element':   '',
    \ 'sexp_round_tail_wrap_element':   '',
    \ 'sexp_square_head_wrap_element':  '',
    \ 'sexp_square_tail_wrap_element':  '',
    \ 'sexp_curly_head_wrap_element':   '',
    \ 'sexp_curly_tail_wrap_element':   '',
    \ 'sexp_insert_at_list_head':       '',
    \ 'sexp_insert_at_list_tail':       '',
    \ 'sexp_splice_list':               '',
    \ 'sexp_convolute':                 '',
    \ 'sexp_raise_list':                '',
    \ 'sexp_raise_element':             '',
    \ 'sexp_swap_list_backward':        '',
    \ 'sexp_swap_list_forward':         '',
    \ 'sexp_swap_element_backward':     '',
    \ 'sexp_swap_element_forward':      '',
    \ 'sexp_emit_head_element':         '',
    \ 'sexp_emit_tail_element':         '',
    \ 'sexp_capture_prev_element':      '',
    \ 'sexp_capture_next_element':      '',
    \ }
" }}}

let g:sexp_enable_insert_mode_mappings = 0
let g:sexp_insert_after_wrap = 0

let g:clojure_align_multiline_strings = 1

fun! DisableAutopairs()
    " If variable autopairs_loaded doesn't exit, the plugin will be loaded
    " let b:autopairs_loaded = 0
    " let b:autopairs_enabled = 0
    let b:AutoPairs = {'"':'"'}
endfun

augroup clojure
  autocmd!
  autocmd FileType lisp,clojure,scheme RainbowParentheses
  autocmd FileType lisp,clojure,scheme call DisableAutopairs()
"  autocmd FileType lisp,clojure,scheme
"        \ nnoremap <buffer> <leader>a[ vi[<c-v>$:EasyAlign\ g/^\S/<cr>gv=
"  autocmd FileType lisp,clojure,scheme
"        \ nnoremap <buffer> <leader>a{ vi{<c-v>$:EasyAlign\ g/^\S/<cr>gv=
"  autocmd FileType lisp,clojure,scheme
"        \ nnoremap <buffer> <leader>a( vi(<c-v>$:EasyAlign\ g/^\S/<cr>gv=
"  autocmd FileType lisp,clojure,scheme
"        \ nnoremap <buffer> <leader>rq :silent update<bar>Require!<cr>
"  autocmd FileType lisp,clojure,scheme
"        \ nnoremap <buffer> <leader>rt :silent update<bar>RunTests<cr>
augroup END


"let g:clojure_maxlines = 60

"let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let', '^match$']

"" let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

"au FileType clojure xnoremap <buffer> <Enter> :Eval<CR>
"au FileType clojure nmap <buffer> <Enter> cpp

nnoremap <leader>cn :Slamhound<cr>
nnoremap <silent> <leader>cm :ParinferToggleMode<cr>

" It's not possible to remap CTRL-M in insert mode, see
" :h index -> see list of vim mappings
" :h key-notation
nnoremap <silent> <c-j> :ParinferToggleMode<cr>
vnoremap <silent> <c-j> <esc>:ParinferToggleMode<cr>gv
inoremap <silent> <c-j> <c-o>:ParinferToggleMode<cr>


" if socketrepl is active
if exists('g:socket_repl_plugin_ready')
    command StartREPL :call jobstart("boot -i \"(do (require 'clojure.core.server) ((resolve 'clojure.core.server/start-server) {:port 5555 :name :repl :accept 'clojure.core.server/repl}))\" wait")

    function! s:clojure_socketrepl_settings() abort
      nnoremap <silent><buffer> K :Doc<cr>
      nnoremap <silent><buffer> <leader>cs :StartREPL<cr>
      nnoremap <silent><buffer> <leader>ca :Connect<cr>
      nnoremap <silent><buffer> <leader>ce :EvalCode<cr>
      nnoremap <silent><buffer> <leader>cc :EvalCode<cr>
      nnoremap <silent><buffer> <leader>cb :EvalBuffer<cr>
    endfunction
    autocmd user_augroup FileType clojure call s:clojure_socketrepl_settings()
else
    function! s:clojure_fireplace_settings() abort
      nmap <silent><buffer> <leader>cc cpp
      nnoremap <buffer> crr :Require<cr>
      nnoremap <buffer> cra :Require!<cr>
      nnoremap <buffer> <leader>cr :T boot cider
      " nnoremap <buffer> <leader>crr :T boot cider-extra
    endfunction
    autocmd user_augroup FileType clojure call s:clojure_fireplace_settings()

endif

" https://github.com/adzerk-oss/boot-cljs-repl#vim-fireplace
command! PiggieBoot :Piggieback (adzerk.boot-cljs-repl/repl-env)

"let g:is_piggieboot_running == 1
"function! StartPiggieBootIfNotRunning()
"    let l:p_dir = expand('<sfile>:p:h')
"    if g:is_piggieboot_running == 0 && exists(l:p_dir . '/build.boot')
"        echo 'Starting PiggieBoot...'
"        execute 'PiggieBoot'
"        let g:is_piggieboot_running == 1
"    endif
"endfunction

" END CLOJURE


" ============================================================================
" NEOMAKE / NEOFORMAT {{{1
" ============================================================================


"function! GetEslintrc()
"    if filereadable(getcwd() . '/.eslintrc.js')
"        return (getcwd() . '/.eslintrc.js')
"    elseif filereadable(getcwd() . '/.eslintrc.json')
"        return (getcwd() . '/.eslintrc.json')
"    else
"        return expand('~/dotfiles/eslintrc.js')
"    endif
"endfunction
"
"function! EslintMaker()
"    let maker = neomake#makers#ft#javascript#eslint_d()
"    let maker.args = ['-f', 'compact', '-c', GetEslintrc()]
"    return maker
"endfunction
"
"
"let g:neomake_sphinx_maker = {
"    \ 'exe': 'make',
"    \ 'args': ['html'],
"    \ 'errorformat': '%f:%l:%c: %m',
"    \ }
"
"let g:neomake_javascript_enabled_makers = ['eslint_d']
"let g:neomake_echo_current_error = 0
"let g:neomake_open_list = 2
"
"if executable('prettier')
"    autocmd FileType javascript setlocal formatprg=prettier\ --stdin\ --single-quote\ --trailing-comma\ es5
"endif
"
"let g:neoformat_try_formatprg = 1
"
"augroup on_vim_enter
"  autocmd!
"  autocmd VimEnter * call OnVimEnter()
"augroup END
"
"" Called after plugins have loaded
"function! g:OnVimEnter()
"  augroup neoformat_autosave
"    autocmd!
"    if exists(':Neoformat')
"      " Run automatically before saving for supported filetypes
"      echom 'Setting up neoformat'
"      autocmd BufWritePre *.js Neoformat
"    endif
"  augroup END
"
"  augroup neomake_automake
"    autocmd!
"    if exists(':Neomake')
"      " Check for lint errors on open & write for supported filetypes
"      autocmd BufReadPost,BufWritePost *.js,*.sh Neomake
"    endif
"  augroup END
"endfunction
"
"autocmd! BufWritePost *.rst Neomake
"autocmd! BufWritePost *.rst Neomake! sphinx

" END NEOMAKE / NEOFORMAT

" ============================================================================
" HEADLINES {{{1
" ============================================================================

let g:headlines_key= '<leader><leader>h'
let g:headlines_height= 22

" HEADLINES


" ============================================================================
" ALE {{{1
" ============================================================================


let g:ale_javascript_prettier_executable = 'prettier_d'
let g:ale_javascript_prettier_options = '--trailing-comma es5'
let g:ale_javascript_eslint_executable = 'eslint_d'

let g:ale_virtualenv_dir_names = ['venv', '.env', 'env', 've', 'virtualenv']

"let g:ale_linters = {
"\   'javascript': ['eslint_d'],
"\}

let g:ale_pattern_options = {
\   '\.min.js$': {'ale_enabled': 0},
\   '\.js$'    : {'ale_fix_on_save': 1},
\   '\.json$'  : {'ale_fix_on_save': 1},
\   '\.css$'   : {'ale_fix_on_save': 1},
\}

let g:ale_fixers = {
\   'python': [
\       'remove_trailing_lines',
\       'isort',
\       'yapf',
\   ],
\   'javascript':[ 'prettier' ],
\   'json'      :[ 'prettier' ],
\   'css'       :[ 'prettier' ],
\
\}


map <silent> <leader>af :ALEFix<cr>
nmap <silent> <leader>ak <Plug>(ale_previous_wrap)
nmap <silent> <leader>aj <Plug>(ale_next_wrap)

" ALE


" ============================================================================
" NVIM COMPLETION MANAGER {{{1
" ============================================================================


" Disable it
"let g:cm_smart_enable = 0

"set shortmess+=c

" hide the menu and also start a new line
"inoremap <expr> <CR> (pumvisible() ? "\<c-y>\<cr>" : "\<CR>")

" Use tab to select the popup menu
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" NVIM COMPLETION MANAGER


" ============================================================================
" NEOTERM / CODI {{{1
" ============================================================================

" See :h :map-operator
function! SendToNeoterm(type, ...)
  let sel_save = &selection
  let &selection = "inclusive"
  let reg_save = @@

  if a:0  " Invoked from Visual mode, use '< and '> marks.
    silent exe "normal! `<" . a:type . "`>y"
  elseif a:type == 'line'
    silent exe "normal! '[V']y"
  elseif a:type == 'block'
    silent exe "normal! `[\<C-V>`]y"
  else
    silent exe "normal! `[v`]y"
  endif

  " echomsg strlen(substitute(@@, '[^ ]', '', 'g'))
  call neoterm#do(@@)

  let &selection = sel_save
  let @@ = reg_save
endfunction


let g:neoterm_position = 'vertical'
let g:neoterm_autoscroll = 1
"let g:neoterm_shell = 'fish'

let g:codi#rightsplit = 0
let g:codi#rightalign = 1

nnoremap <silent> <Leader>tt :Ttoggle<cr>
nnoremap <silent> <Leader>tl :call neoterm#clear()<cr>
nnoremap <Leader>tk :Tclose!
nnoremap <Leader>tn :T nix-shell<cr>

" REPL maps
nnoremap <silent> <Leader>tff :TREPLSendFile<cr>
nnoremap <silent> <Leader>tss :TREPLSendLine<cr>
nnoremap <silent> <Leader>ts :set opfunc=SendToNeoterm<CR>g@
vnoremap <silent> <Leader>ts :TREPLSendSelection<cr>

function! s:neoterm_extra_maps() abort
  " Don't add on these filetypes
  if &ft =~ 'clojure\|clojurescript'
    return
  endif
  nnoremap <buffer><silent> cpp :TREPLSendLine<cr>
  vnoremap <buffer><silent> cp  :TREPLSendSelection<cr>

  " Toggle codi
  nnoremap <buffer> cpi :Codi!!<cr>
endfunction

augroup neoterm_add_extra_maps
  autocmd!
  autocmd BufNewFile,BufReadPost * call s:neoterm_extra_maps()
augroup END

" NEOTERM / CODI


" ============================================================================
" LISTTOGGLE {{{1
" ============================================================================

let g:listtoggle_no_maps = 1

nmap <Leader>x <Plug>ListToggleQuickfixListToggle
" nmap <Leader>l <Plug>ListToggleLocationListToggle


" LISTTOGGLE


" ============================================================================
" EMMET {{{1
" ============================================================================

let g:user_emmet_install_global = 0

augroup AutoEmmet
  autocmd!
  autocmd FileType html,css EmmetInstall
  " https://github.com/mattn/emmet-vim/issues/168#issuecomment-35853346
  autocmd FileType html,css imap <expr> <tab>
    \ pumvisible() ? "\<C-n>" :
    \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
    \ "\<tab>"
augroup END

" EMMET
