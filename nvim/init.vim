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
" Defaults                      *nvim-defaults*
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

let g:use_conjure = 1
let g:use_coc = 1

call plug#begin('~/.config/nvim/plugged')

" Color schemas
Plug 'chriskempson/base16-vim'
Plug 'mhartington/oceanic-next'
Plug 'junegunn/seoul256.vim'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep-theme'}
Plug 'KabbAmine/yowish.vim'
Plug 'mhinz/vim-janah'
" Plug 'dracula/vim', {'as': 'dracula-colorscheme'}
Plug 'liuchengxu/space-vim-dark'


Plug 'ryanoasis/vim-devicons'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Navigation
" Plug 'andymass/vim-matchup'
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-vinegar'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
Plug 'dyng/ctrlsf.vim'
"Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
" Plug 'unblevable/quick-scope'
Plug 'takac/vim-hardtime'
Plug 'nelstrom/vim-visual-star-search'
Plug 'michaeljsmith/vim-indent-object'


" Text edition
"Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
"gorkunov/smartpairs.vim
"Plug 'cohama/lexima.vim'
" Plug 'jiangmiao/auto-pairs'
"Plug 'Raimondi/delimitMate' ???
" Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-jdaddy'
" Plug 'tpope/vim-endwise'
Plug 'tpope/vim-speeddating'
Plug 'bfredl/nvim-miniyank'
Plug 'tweekmonster/headlines.vim'
" Plug 'jlesquembre/rst-tables.nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'machakann/vim-swap'
" Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'


" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'mhinz/vim-halo'
"Plug 'haya14busa/vim-operator-flashy' | Plug 'kana/vim-operator-user'
Plug 'machakann/vim-highlightedyank'
" Plug 'fszymanski/ListToggle.vim'
Plug 'milkypostman/vim-togglelist'
"Plug 'itchyny/vim-cursorword'

" TODO index search plugins will be natively supported by vim, see:
" https://github.com/vim/vim/issues/453
Plug 'henrik/vim-indexed-search'
" Plug 'google/vim-searchindex'


" Git
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
" Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'
Plug 'airblade/vim-rooter'
" Plug 'junegunn/gv.vim'
Plug 'rbong/vim-flog'
Plug 'idanarye/vim-merginal'
" Plug 'gregsexton/gitv', {'on': ['Gitv']}
" Plug 'lambdalisue/gina.vim'

" DB
Plug 'lifepillar/pgsql.vim'
Plug 'tpope/vim-dadbod'

" Syntax
Plug 'tpope/vim-git'
Plug 'tpope/vim-markdown'
Plug 'dag/vim-fish'
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
Plug 'jxnblk/vim-mdx-js'
" Plug 'mxw/vim-jsx'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'HerringtonDarkholme/yats.vim'  " Typescript
"Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': 'tex'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'LnL7/vim-nix'
Plug 'cespare/vim-toml'
Plug 'purescript-contrib/purescript-vim'
Plug 'google/vim-jsonnet'

" Plug 'ap/vim-css-color'  " Needs to be loaded AFTER the syntax
Plug 'RRethy/vim-hexokinase'

" General utils
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dotenv'
Plug 'radenling/vim-dispatch-neovim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tpope/vim-projectionist'
"Plug 'neomake/neomake'
"Plug 'sbdchd/neoformat'
" Plug 'w0rp/ale'
Plug 'kassio/neoterm'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-sayonara'
Plug 'semanser/vim-outdated-plugins'
Plug 'yssl/QFEnter'
Plug 'junegunn/vim-peekaboo'
Plug 'embear/vim-localvimrc'

" Autocompletion
" Plug 'roxma/nvim-completion-manager'
" Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
" " Plug 'Shougo/neopairs.vim'

" Plug 'ponko2/deoplete-fish'
" Plug 'carlitux/deoplete-ternjs'

if exists("g:use_coc") && exists("g:use_conjure")
  Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
else
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  Plug 'Shougo/context_filetype.vim'
  Plug 'Shougo/echodoc.vim'
  Plug 'Shougo/neoinclude.vim'
  Plug 'Shougo/neco-vim'
  Plug 'clojure-vim/async-clj-omni'
endif

" Plug 'autozimu/LanguageClient-neovim', {
"     \ 'branch': 'next',
"     \ 'do': 'bash install.sh',
"     \ }
" Plug 'othree/csscomplete.vim'

" Clojure
"Plug 'kovisoft/paredit',    { 'for': 'clojure' }
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'guns/vim-clojure-highlight' | Plug 'guns/vim-clojure-static'


" Plug 'clojure-vim/nvim-parinfer.js', {'do': 'lein do npm install'}
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
Plug 'humorless/vim-kibit'

if exists("g:use_conjure")
  Plug 'Olical/conjure', { 'branch': 'master', 'do': 'bin/compile', 'for': 'clojure', 'on': 'ConjureAdd'  }
  " Plug '~/projects/conjure', { 'for': 'clojure', 'on': 'ConjureAdd'  }
else
  Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
endif

Plug 'guns/vim-slamhound'
"Plug 'venantius/vim-cljfmt'

"Plug 'hkupty/acid.nvim', {'do':':UpdateRemotePlugins'}
"Plug 'hkupty/iron.nvim', {'do':':UpdateRemotePlugins'}
"Plug 'tpope/vim-classpath'
"Plug 'tpope/vim-salve'

Plug 'junegunn/vim-easy-align'

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
set updatetime=100 " Also used for the CursorHold autocommand
set previewheight=15
set undofile
set lazyredraw

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
" PERSONAL DOC {{{1
" ============================================================================

augroup user_augroup
  autocmd!
  " autocmd BufWritePost ~/.config/nvim/doc/personal.txt :helptags ~/.config/nvim/doc
  autocmd BufWritePost ~/dotfiles/nvim/doc/personal.txt :helptags ~/.config/nvim/doc
augroup END


" END PERSONAL DOC


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

  " vimagit / diff colors
  call Base16hi("titleEntry", g:base16_gui0D, "", g:base16_cterm0D, "", "bold", "")
  call Base16hi("fileEntry",  g:base16_gui0E, "", g:base16_cterm0E, "", "bold", "")
  call Base16hi("DiffLine",   g:base16_gui03, "", g:base16_cterm03, "", "", "")
  " call Base16hi("jsxTag",      g:base16_gui09, "", g:base16_cterm09, "", "", "")

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

  call Base16hi("ALEErrorSign",   g:base16_gui08, g:base16_gui01, "", "", "", "")
  call Base16hi("ALEWarningSign",   g:base16_gui09, g:base16_gui01, "", "", "", "")
  call Base16hi("ALEError",     "", "", "", "", "underline", g:base16_gui08)
  call Base16hi("ALEWarning",     "", "", "", "", "underline", g:base16_gui09)

  call Base16hi("CocErrorSign",   g:base16_gui08, g:base16_gui01, "", "", "", "")
  call Base16hi("CocWarningSign",   g:base16_gui09, g:base16_gui01, "", "", "", "")
  call Base16hi("CocInfoSign",   g:base16_gui0D, g:base16_gui01, "", "", "", "")
  call Base16hi("CocHintSign",   g:base16_gui0B, g:base16_gui01, "", "", "", "")

  call Base16hi("CocError",     "", "", "", "", "underline", g:base16_gui08)
  call Base16hi("CocWarning",     "", "", "", "", "underline", g:base16_gui09)

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
" function! ChooseWindow()
"     let winnr = unite#helper#choose_window()
"     call vimfiler#util#winmove(winnr)
" endfunc


function! s:strip(str)
python3 << EOF
import vim
from html import unescape
# replace non-breaking space, see https://stackoverflow.com/a/38010708/799785
result = unescape(vim.eval("a:str")).strip().replace("\xa0", " ")
if (result.startswith('"') and result.endswith('"')) or (result.startswith("'") and result.endswith("'")):
    result = result[1:-1]
vim.command('return "{}"'.format(result.replace('"', '\\"')))
EOF
endfunction

function! s:gethost(str)
python3 << EOF
import vim
from urllib.parse import urlparse
url = vim.eval("a:str")
host = urlparse(url).hostname
if host.startswith('www.'):
    host = host[4:]
vim.command('return "{}"'.format(host))
EOF
endfunction

function! FormatLink(format)
  let l:link = s:strip(getline('.'))

  " let l:title = system('wget -qO- '. shellescape(l:link) . ' | gawk -v IGNORECASE=1 -v RS=''</title'' ''RT{gsub(/.*<title[^>]*>/,"");print;exit}'' ')
  let l:title = system('curl -L --compressed --silent '. shellescape(l:link) . ' | gawk -v IGNORECASE=1 -v RS=''</title'' ''RT{gsub(/.*<title[^>]*>/,"");print;exit}'' ')
  let l:host = s:gethost(l:link)
  let b:title = s:strip(l:title)

  " \v -> very magig
  " {-} non-greedy match
  if l:host ==# 'github.com'
    let l:title = substitute(b:title, '\v^\p+[\-\|]\s+', '', 'gi')
  elseif l:host ==# 'stackoverflow.com' || l:host =~# '.\+\.stackexchange\.com'
    let l:title = substitute(b:title, '\v^\p{-}\-\s+', '', 'gi')
    let l:title = substitute(l:title, '\v\s+\-\p{-}$', '', 'gi')
  elseif l:host ==# 'manning.com'
    let l:title = substitute(b:title, '\v^\p+[\-\|]\s+', '', 'gi')
  else
    let l:title = substitute(b:title, '\v\s+[\-\|]\s+\p+$', '', 'gi')
  endif

  if a:format == ''
    let l:format = expand('%:e')
  else
    let l:format = a:format
  endif

  if (index(['rst'], l:format) >= 0)
    let l:newline = '`' . l:title . ' <' . l:link . '>`_'
  else
    let l:newline = '[' . l:title . '](' . l:link . ')'
  endif

  call setline('.', l:newline)
  normal 0

  echomsg 'Original title (saved on b:title, `<C-R>=` to insert it): ' . b:title

endfunction


" END FUNCTIONS


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
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

" give it a try and you will like it
" nnoremap ; :
" nnoremap : ;

" Make yank more logical
map Y y$

"nmap <leader>w <C-w>
nnoremap <leader>w <C-w>

nnoremap <leader>d "_d
vnoremap <leader>d "_d

" Used to write digraph (acentos)
inoremap <M-k> <C-k>

" Fast window moves
" Terminal mode:
tnoremap <C-h> <c-\><c-n><c-w>h
tnoremap <C-j> <c-\><c-n><c-w>j
tnoremap <C-k> <c-\><c-n><c-w>k
tnoremap <C-l> <c-\><c-n><c-w>l
tnoremap <C-w> <c-\><c-n><c-w>
" Insert mode:
inoremap <C-h> <Esc><c-w>h
inoremap <C-j> <Esc><c-w>j
inoremap <C-k> <Esc><c-w>k
inoremap <C-l> <Esc><c-w>l
" Visual mode:
vnoremap <C-h> <Esc><c-w>h
vnoremap <C-j> <Esc><c-w>j
vnoremap <C-k> <Esc><c-w>k
vnoremap <C-l> <Esc><c-w>l
" Normal mode:
nnoremap <C-h> <c-w>h
nnoremap <C-j> <c-w>j
nnoremap <C-k> <c-w>k
nnoremap <C-l> <c-w>l

nnoremap <leader>wt <C-w>T
nnoremap <leader>wh <C-w>H
nnoremap <leader>wj <C-w>J
nnoremap <leader>wk <C-w>K
nnoremap <leader>wl <C-w>L

" Not needed, provided by vim-indexed-search plugin
" Saner behavior of n and N
" nnoremap <silent><expr> n 'Nn'[v:searchforward]
" nnoremap <silent><expr> N 'nN'[v:searchforward]
" nnoremap <silent><expr> n 'Nn'[v:searchforward] . 'zv:call halo#run()<cr>'
" nnoremap <silent><expr> N 'nN'[v:searchforward] . 'zv:call halo#run()<cr>'
let g:indexed_search_mappings = 0
" nmap / <Plug>(indexed-search-/)
" nmap ? <Plug>(indexed-search-?)
" nmap * <Plug>(indexed-search-*)
" nmap # <Plug>(indexed-search-#)
noremap <silent><expr> n 'Nn'[v:searchforward] . ':ShowSearchIndex<CR>zv:call halo#run()<cr>'
noremap <silent><expr> N 'nN'[v:searchforward] . ':ShowSearchIndex<CR>zv:call halo#run()<cr>'

" Saner command-line history
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Saner CTRL-L
nnoremap <leader>l :nohlsearch<cr>:GitGutter<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Quick saving
nnoremap <silent> <Leader>s :update<CR>

" Show syntax highlighting groups for word under cursor
nnoremap <F10> :call <SID>SynStack()<CR>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" tab map
nnoremap <leader>gn :tabnew<cr>

" move to beginning/end of line
nnoremap <silent> <Leader>b ^
nnoremap <silent> <Leader>e $

" Quick breakpoints
augroup AutoBreakpoint
  autocmd!
  autocmd FileType python map <silent><buffer> <leader><leader>b oimport ipdb; ipdb.set_trace()<esc>
  autocmd FileType python map <silent><buffer> <leader><leader>B Oimport ipdb; ipdb.set_trace()<esc>
  autocmd FileType javascript map <silent><buffer> <leader><leader>b odebugger;<esc>
  autocmd FileType javascript map <silent><buffer> <leader><leader>B Odebugger;<esc>

  " autocmd FileType clojure map <silent><buffer> <leader><leader>b o(require '[hugin.dbg :as dbg])<cr>(comment)<esc>
  " autocmd FileType clojure map <silent><buffer> <leader><leader>B O(require '[hugin.dbg :as dbg])<cr>(comment)<esc>
  autocmd FileType clojure map <silent><expr><buffer> <leader><leader>b 'saa((i./spy <esc>'
  " autocmd FileType clojure map <silent><buffer> <leader><leader>B O(require '[hugin.dbg :as dbg])<cr>(comment)<esc>
augroup END

augroup QfLists
  autocmd!
  autocmd FileType qf nnoremap <silent> <buffer> <Left> :call quickfixed#older()<CR>
  autocmd FileType qf nnoremap <silent> <buffer> <Right> :call quickfixed#newer()<CR>
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

nnoremap <leader>cl :r !conventional-changelog -u<cr>

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

" From
" https://github.com/machakann/vim-sandwich/issues/48#issuecomment-338172430
let s:sandwich_highlight_on = 1
function! s:sandwich_highlight_toggle() abort
  if s:sandwich_highlight_on
    call operator#sandwich#set('all', 'all', 'highlight', 0)
    let s:sandwich_highlight_on = 0
    echo 'sandwich: highlight OFF'
  else
    call operator#sandwich#set('all', 'all', 'highlight', 3)
    let s:sandwich_highlight_on = 1
    echo 'sandwich: highlight ON'
  endif
endfunction
command! -nargs=0 SandwichHighlightToggle call s:sandwich_highlight_toggle()

nnoremap sh :SandwichHighlightToggle<CR>

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
" nnoremap <leader>gll :GV!<CR>
" nnoremap <leader>glr :GV?<CR>
" nnoremap <leader>gla :GV<CR>
nnoremap <leader>gll :Flog -path=%<CR>
nnoremap <leader>gla :Flog -all<CR>

nnoremap <leader>gb :MerginalToggle<CR>


function! Flogdiff(mods) abort
  let l:path = fnameescape(flog#get_state().path[0])
  let l:commit = flog#get_commit_data(line('.')).short_commit_hash
  call flog#preview(a:mods . ' split ' . l:path . ' | Gvdiff ' . l:commit)
endfunction

augroup flog
  autocmd!
  autocmd FileType floggraph command! -buffer -nargs=0 Flogdiff call Flogdiff('<mods>')
  autocmd FileType floggraph nnoremap <buffer> gd :Flogdiff<CR>

  autocmd FileType floggraph map <buffer> o :call myflog#close_term_preview()<CR>:vertical belowright Flogsplitcommit<CR>
  autocmd FileType floggraph nmap <buffer> <leader>q :call myflog#quit()<CR>

  autocmd FileType floggraph command! -buffer -nargs=0 Myflogsplitcommit call myflog#diff_fancy()
  autocmd FileType floggraph nnoremap <buffer> <silent> <CR> :Myflogsplitcommit<CR>
  autocmd FileType floggraph nnoremap <buffer> <silent> J :call myflog#scroll_down()<CR>
  autocmd FileType floggraph nnoremap <buffer> <silent> K :call myflog#scroll_up()<CR>

  autocmd FileType floggraph nnoremap <buffer> <silent> <c-n> :call myflog#preview_next_commit()<CR>
  autocmd FileType floggraph nnoremap <buffer> <silent> <c-p> :call myflog#preview_prev_commit()<CR>
augroup END

augroup open_folds_gitlog
  autocmd!
  autocmd Syntax git setlocal foldmethod=syntax
  autocmd Syntax git normal zR
augroup END

" start insert mode when entering the commit buffer. See https://stackoverflow.com/a/50537836/
augroup turbo_commit
  autocmd!
  autocmd BufEnter COMMIT_EDITMSG startinsert
augroup END


" END FUGITIVE

" ============================================================================
" VIMAGIT (MAGIT) {{{1
" ============================================================================

let g:magit_show_magit_mapping='<leader>gm'
let g:magit_default_fold_level=2

augroup vimagit_custom
  autocmd!
  autocmd User VimagitEnterCommit startinsert
augroup END

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
" let g:fzf_files_options = '--preview "(file -ib {} | rg binary || highlight -O ansi {} || cat {}) 2> /dev/null | head -'.&lines.'"'

let g:fzf_files_options = '--preview "(file -ib {} | rg binary || bat --color always --paging never --style plain --line-range :'. &lines . ' {} || cat {}) 2> /dev/null"'

nnoremap <silent> <Leader>f       :FilesFd<CR>
nnoremap <silent> <Leader>ff      :FilesFd<CR>
nnoremap <silent> <Leader>fa      :FilesFdAll<CR>
nnoremap <silent> <Leader>fg      :GFiles<CR>
nnoremap <silent> <Leader>fc      :Colors<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>fr     :Find <C-R><C-W><CR>
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


command! -bang -nargs=? -complete=dir FilesFd call fzf#vim#files(<q-args>, {
  \ 'source': 'fd --hidden --follow --exclude ".git" --type file --type symlink'
  \ },
  \ <bang>0)

command! -bang -nargs=? -complete=dir FilesFdAll call fzf#vim#files(<q-args>, {
  \ 'source': 'fd --hidden --follow --no-ignore'
  \ },
  \ <bang>0)

command! -bang -nargs=* Find
  \ call fzf#vim#grep('rg --column --line-number --no-heading --color=always '.shellescape(<q-args>).'| tr -d "\017"', 1, <bang>0)


command! Plugs call fzf#run({
  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
  \ 'options': '--delimiter / --nth -1',
  \ 'down':    '~30%',
  \ 'sink':    'Defx'})

augroup fzf_custom
  autocmd!
  autocmd FileType fzf tnoremap <buffer> <C-j> <C-n>
  autocmd FileType fzf tnoremap <buffer> <C-k> <C-p>
augroup END


" END FZF


" ============================================================================
" AIRLINE {{{1
" ============================================================================

let g:whitespace_filetypes_blacklist = [
\ 'git', 'fugitive', 'magit',
\ 'diff', 'gitcommit', 'unite', 'qf', 'help'
\ ]

augroup disable_whitespace_check
  autocmd!
  execute 'autocmd FileType '.join(g:whitespace_filetypes_blacklist, ','). ' let b:airline_whitespace_disabled = 1'
augroup END

let g:airline_theme='oceanicnext'
"let g:airline_theme='onedark'
" let g:airline_theme='base16_default' " same as base16-default-dark
let g:airline_powerline_fonts = 1

let g:airline#extensions#hunks#non_zero_only = 1

"let g:airline#extensions#tabline#show_buffers=2
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#tab_nr_type = 1 " tab number
let g:airline#extensions#tabline#tab_min_count = 0
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tabs_label = ''
"let g:airline#extensions#tabline#show_tab_nr = 1
"let g:airline#extensions#tabline#buffer_idx_mode = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

let g:airline_symbols.maxlinenr = ''

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


function! AirlineTermName()
  if exists('b:term_title')
    return '['. b:term_title .'] '
  endif
  return ''
endfunction

function! AirlineTerm(...)
  if &filetype == 'custom_term'
    let w:airline_section_c = '%{AirlineTermName()}' . g:airline_section_c
  endif
endfunction
call airline#add_statusline_func('AirlineTerm')


" END AIRLINE


" ============================================================================
" DEFX.NVIM {{{1
" ============================================================================

let g:loaded_netrwPlugin = 1 " Disable netrw.vim

" autocmd FileType defx call s:defx_my_settings()

augroup defxConfig
  autocmd!
  autocmd FileType defx call s:defx_my_settings()
augroup END


function! s:defx_my_settings() abort

  " Open commands
  " nnoremap <silent><buffer><expr> <CR> defx#do_action('open')
  nnoremap <silent><buffer><expr> <CR> defx#do_action('open', 'wincmd w \| drop')
  nnoremap <silent><buffer><expr> l defx#do_action('open')
  nnoremap <silent><buffer><expr> v defx#do_action('open', 'vsplit')
  " Preview current file
  " nnoremap <silent><buffer><expr> s defx#do_action('open', 'pedit')

  " File manipulation
  nnoremap <silent><buffer><expr> K defx#do_action('new_directory')
  nnoremap <silent><buffer><expr> N defx#do_action('new_file')
  nnoremap <silent><buffer><expr> M defx#do_action('new_multiple_files')
  nnoremap <silent><buffer><expr> <Del> defx#do_action('remove')
  nnoremap <silent><buffer><expr> r defx#do_action('rename')
  nnoremap <silent><buffer><expr> yy defx#do_action('copy')
  nnoremap <silent><buffer><expr> dd defx#do_action('move')
  nnoremap <silent><buffer><expr> pp defx#do_action('paste')

  "Navigation
  nnoremap <silent><buffer><expr> - defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> h defx#do_action('cd', ['..'])
  nnoremap <silent><buffer><expr> j line('.') == line('$') ? 'gg' : 'j'
  nnoremap <silent><buffer><expr> k line('.') == 1 ? 'G' : 'k'
  nnoremap <silent><buffer><expr> ~ defx#do_action('cd', [getcwd()])
  nnoremap <silent><buffer><expr> o defx#do_action('open_or_close_tree')

  " Miscellaneous actions
  nnoremap <silent><buffer><expr> . defx#do_action('toggle_ignored_files')
  nnoremap <silent><buffer><expr> q defx#do_action('quit')
  nnoremap <silent><buffer><expr> x defx#do_action('execute_system')
  nnoremap <silent><buffer><expr> yp defx#do_action('yank_path')
  nnoremap <silent><buffer><expr> <C-g> defx#do_action('print')
  nnoremap <silent><buffer><expr> <C-l> defx#do_action('redraw') . ':nohlsearch<cr>:syntax sync fromstart<cr><c-l>'

  nnoremap <silent><buffer><expr><nowait> <Space> defx#do_action('toggle_select') . 'j'
  nnoremap <silent><buffer><expr> * defx#do_action('toggle_select_all')

  nnoremap <silent><buffer><expr> C defx#do_action('toggle_columns', 'mark:filename:type:size:time')
  nnoremap <silent><buffer><expr> S defx#do_action('toggle_sort', 'time')

  " nnoremap <silent><buffer><expr>e defx#do_action('call', 'DefxExternalExplorer')
  nnoremap <silent><buffer><expr> e defx#do_action('call', 'OpenRanger')
endfunction

" nnoremap <silent> <leader>o :call OpenRanger()<cr>
nnoremap <silent>- :Defx `expand('%:p:h')` -columns=icons:filename:type -show-ignored-files -search=`expand('%:p')`<CR>
nnoremap <Leader>- :Defx -split=vertical -columns=icons:filename:type -winwidth=50 -direction=topleft<CR>


function! s:defx_directory_from_context(context) abort
  let l:target = a:context['targets'][0]
  if a:context['cursor'] == 1
    return l:target
  endif
  return fnamemodify(l:target, ':h')
endfunction

" Open file-explorer
function! g:DefxExternalExplorer(context) abort
  if executable('ranger')
    let l:explorer = 'ranger'
  endif
  if empty('$KITTY_WINDOW_ID') || empty(l:explorer)
    return
  endif
  let l:dir = s:defx_directory_from_context(context)
  silent execute '!kitty @ new-window --new-tab --title ranger ranger ' . shellescape(l:dir)
endfunction

function! g:OpenRanger(context) abort
  let l:dir = s:defx_directory_from_context(a:context)
  execute '-tabnew +set\ filetype=custom_term'
  setlocal nonumber norelativenumber
  call termopen('ranger ' . l:dir)
  execute 'let b:term_title="ranger"'
  execute 'startinsert'
  execute 'autocmd TermClose <buffer> Sayonara'
endfunction


" END DEFX.NVIM


" ============================================================================
" VIMTEX {{{1
" ============================================================================

" <Leader>ll to start compilation

let g:vimtex_latexmk_progname = 'nvr'
" let g:vimtex_compiler_progname = '/run/current-system/sw/bin/nvr'

let g:vimtex_view_general_viewer = 'zathura'
" let g:vimtex_view_general_options = '--unique @pdf\#src:@line@tex'
" let g:vimtex_view_general_options_latexmk = '--unique'
let g:vimtex_view_automatic = 1

let g:vimtex_quickfix_open_on_warning = 1
"let g:vimtex_index_split_pos = 'below'
let g:vimtex_fold_enabled = 0
let g:vimtex_format_enabled = 1
"let g:vimtex_imaps_leader = ';'
"let g:vimtex_complete_img_use_tail = 1
let g:vimtex_compiler_latexmk = {
      \ 'build_dir' : '/tmp/vimtex_output',
      \}

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

" let g:AutoPairsMapSpace=0
let g:pear_tree_smart_openers = 1
let g:pear_tree_smart_closers = 1
let g:pear_tree_smart_backspace = 1
let g:pear_tree_repeatable_expand = 0

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

function! LispCustomSettings()
  execute 'RainbowParentheses'
  let b:coc_pairs = [['"', '"']]

  " It's not possible to remap CTRL-M in insert mode, see
  " :h index -> see list of vim mappings
  " :h key-notation
  nnoremap <silent><buffer> <c-n> :ParinferToggleMode<cr>
  vnoremap <silent><buffer> <c-n> <esc>:ParinferToggleMode<cr>gv
  inoremap <silent><buffer> <c-n> <c-o>:ParinferToggleMode<cr>
  nnoremap <silent><buffer> <leader>cm :ParinferToggleMode<cr>

  nnoremap <buffer> <leader>cn :Slamhound<cr>
endfunction

let g:conjure_default_mappings = 0
let g:conjure_log_direction = "horizontal"
" let g:conjure_log_auto_open = ['eval', 'ret', 'ret-multiline', 'out', 'err', 'tap', 'doc', 'load-file', 'test']
let g:conjure_log_auto_open = ["out", "err", "tap", "doc", "test"]

function! ClojureCustomSettings()
  if exists("g:use_conjure")
    nnoremap <buffer> cpp :ConjureEvalCurrentForm<cr>
    nnoremap <buffer> cpr :ConjureEvalRootForm<cr>
    vnoremap <buffer> cpp :ConjureEvalSelection<cr>
    nnoremap <buffer> cpb :ConjureEvalBuffer<cr>
    nnoremap <buffer> cpf :ConjureLoadFile <c-r>=expand('%:p')<cr><cr>
    nnoremap <buffer> cps :ConjureStatus<cr>
    nnoremap <buffer> cll :ConjureToggleLog<cr>
    nnoremap <buffer> cu :ConjureUp<cr>
    nnoremap <buffer> crr :ConjureEval (clojure.tools.namespace.repl/refresh)<cr>
    nnoremap <buffer> cri :ConjureEval (integrant.repl/reset)<cr>
    " nnoremap <buffer> <leader>q :ConjureCloseLog<cr>
    nnoremap <buffer> cpt :ConjureRunTests<cr>
    nnoremap <buffer> cptt :ConjureRunAllTests<cr>
    nnoremap <buffer> K :ConjureDoc <c-r><c-w><cr>
    nnoremap <buffer> gd :ConjureDefinition <c-r><c-w><cr>
    setlocal omnifunc=conjure#omnicomplete
  else
    nmap <silent><buffer> <leader>cc cqp<Up>
    nnoremap <buffer> crr :Require<cr>
    nnoremap <buffer> cra :Require!<cr>
  endif

endfunction


augroup clojure
  autocmd!
  autocmd FileType lisp,clojure,scheme call LispCustomSettings()
  autocmd FileType clojure call ClojureCustomSettings()
  if exists("g:use_conjure")
    autocmd InsertEnter *.edn,*.clj,*.clj[cs] :call conjure#close_unused_log()
    autocmd CursorMoved *.edn,*.clj,*.clj[cs] :call conjure#quick_doc()
    autocmd CursorMovedI *.edn,*.clj,*.clj[cs] :call conjure#quick_doc()
    autocmd BufLeave *.edn,*.clj,*.clj[cs] :call conjure#quick_doc_cancel()
  endif
augroup END


"let g:clojure_maxlines = 60

"let g:clojure_fuzzy_indent_patterns = ['^with', '^def', '^let', '^match$']

let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]
let g:rainbow#blacklist = ['#'.g:base16_gui04, '#'.g:base16_gui05, '#'.g:base16_gui06, '#'.g:base16_gui07, '#'.g:base16_gui0E]
" let g:rainbow#max_level = 16

" let g:rainbow#colors = {
" \   'dark': [
" \     ['yellow',  'orange1'     ],
" \     ['green',   'yellow1'     ],
" \     ['cyan',    'greenyellow' ],
" \     ['magenta', 'green1'      ],
" \     ['red',     'springgreen1'],
" \     ['yellow',  'cyan1'       ],
" \     ['green',   'slateblue1'  ],
" \     ['cyan',    'magenta1'    ],
" \     ['magenta', 'purple1'     ]
" \   ],
" \   'light': [
" \     ['darkyellow',  'orangered3'    ],
" \     ['darkgreen',   'orange2'       ],
" \     ['blue',        'yellow3'       ],
" \     ['darkmagenta', 'olivedrab4'    ],
" \     ['red',         'green4'        ],
" \     ['darkyellow',  'paleturquoise3'],
" \     ['darkgreen',   'deepskyblue4'  ],
" \     ['blue',        'darkslateblue' ],
" \     ['darkmagenta', 'darkviolet'    ]
" \   ]
" \ }

"au FileType clojure xnoremap <buffer> <Enter> :Eval<CR>
"au FileType clojure nmap <buffer> <Enter> cpp


" https://github.com/adzerk-oss/boot-cljs-repl#vim-fireplace
command! PiggieBoot :Piggieback (adzerk.boot-cljs-repl/repl-env)
" (shadow.cljs.devtools.api/nrepl-select :app)
command! PiggieShadow :Piggieback :app
command! PiggieMain :Piggieback (figwheel.main.api/repl-env "dev")

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

" let g:ale_sign_error = '⬥'
" let g:ale_sign_warning = '⬥'

" " let g:ale_javascript_prettier_executable = 'prettier_d'
" " let g:ale_javascript_prettier_options = '--trailing-comma es5'
" " let g:ale_javascript_eslint_executable = 'eslint_d'

" let g:ale_virtualenv_dir_names = ['venv', '.env', 'env', 've', 'virtualenv']

" let g:ale_linters = {
" \   'javascript': ['eslint'],
" \   'typescript': ['tsserver'],
" \}

" let g:ale_pattern_options = {
" \   '\.min\.js$' : {'ale_enabled': 0},
" \   '\.js$'      : {'ale_fix_on_save': 1},
" \   '\.ts$'      : {'ale_fix_on_save': 1},
" \   '\.json$'    : {'ale_fix_on_save': 1},
" \   '\.css$'     : {'ale_fix_on_save': 1},
" \   '\.html$'    : {'ale_fix_on_save': 1},
" \   '\.mdx\?$'   : {'ale_fix_on_save': 1},
" \   '\.rs$'      : {'ale_fix_on_save': 1},
" \   '\.joker$'   : {'ale_linters': []},
" \}

" let g:ale_fixers = {
" \   'python': [
" \       'remove_trailing_lines',
" \       'isort',
" \       'yapf',
" \   ],
" \   'javascript'   : [ 'prettier' ],
" \   'typescript'   : [ 'prettier' ],
" \   'json'         : [ 'prettier' ],
" \   'css'          : [ 'prettier' ],
" \   'html'         : [ 'prettier' ],
" \   'markdown'     : [ 'prettier' ],
" \   'markdown.mdx' : [ 'prettier' ],
" \   'rust'         : [ 'rustfmt' ],
" \}


" map <silent> <leader>af :ALEFix<cr>
" nmap <silent> <leader>ak <Plug>(ale_previous_wrap)
" nmap <silent> <leader>aj <Plug>(ale_next_wrap)
" nmap <silent> [w <Plug>(ale_previous_wrap)
" nmap <silent> ]w <Plug>(ale_next_wrap)

" ALE


" ============================================================================
" COC.NVIM {{{1
" ============================================================================

if exists("g:use_coc") && exists("g:use_conjure")

  let g:coc_global_extensions = [
        \'coc-word',
        \'coc-pairs',
        \'coc-lists',
        \'coc-prettier',
        \'coc-json',
        \'coc-css',
        \'coc-html',
        \'coc-tsserver',
        \'coc-tslint',
        \'coc-yaml',
        \'coc-conjure',
        \'coc-snippets',
        \'coc-emmet'
        \]

  let g:coc_filetype_map = {
    \ 'markdown.mdx': 'markdown',
    \ }

  " let g:coc_node_args = ['--nolazy', '--inspect-brk=6045']
  " let g:coc_watch_extensions = ['coc-conjure']

  inoremap <silent><expr> <TAB>
        \ pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" :
        \ coc#refresh()
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

  function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
  endfunction

  " Use <c-space> for trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

  " Use K to show documentation in preview window
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
  nnoremap <silent> K :call <SID>show_documentation()<CR>


  " Use `[c` and `]c` for navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)


else " Use deoplete

  " Use tab to select the popup menu
  inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
  inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

  let g:deoplete#enable_at_startup = 1
  let g:deoplete#enable_smart_case = 1

  call deoplete#custom#var('file', 'force_completion_length', 1)
  call deoplete#custom#var('file', 'enable_buffer_path', v:true)

  call deoplete#custom#option('keyword_patterns', {
      \ 'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'
      \})

  call deoplete#custom#source('async_clj', 'rank', 500)

  let g:deoplete#sources#ternjs#docs = 1
  let g:deoplete#sources#ternjs#types = 1

  let g:echodoc#enable_at_startup = 1
  let g:echodoc#enable_force_overwrite = 1

  " disable the preview window feature.
  set completeopt-=preview
  " set splitbelow
  " autocmd CompleteDone * silent! pclose!
  " autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

endif

" COC.NVIM


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


let g:neoterm_autoscroll = 1
let g:neoterm_default_mod ='vertical botright'
" let g:neoterm_size = 'v'
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
  if &ft =~ 'clojure\|clojurescript\|sql'
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
" TOGGLELIST (prev: LISTTOGGLE) {{{1
" ============================================================================

let g:toggle_list_no_mappings = 1
nnoremap <script> <silent> <leader>x :call ToggleQuickfixList()<CR>

" let g:listtoggle_no_maps = 1
" nmap <Leader>x <Plug>ListToggleQuickfixListToggle
" nmap <Leader>l <Plug>ListToggleLocationListToggle


" TOGGLELIST (prev: LISTTOGGLE)


" ============================================================================
" EMMET {{{1
" ============================================================================

let g:user_emmet_install_global = 0
" let g:user_emmet_leader_key='<C-n>'

" let g:user_emmet_expandabbr_key = '<A-n>n'
" let g:user_emmet_expandword_key = '<A-n>;'
" let g:user_emmet_update_tag = '<A-n>u'
" let g:user_emmet_balancetaginward_key = '<A-n>d'
" let g:user_emmet_balancetagoutward_key = '<A-n>D'
" " let g:user_emmet_next_key = '<A-n>n'
" " let g:user_emmet_prev_key = '<A-n>N'
" let g:user_emmet_imagesize_key = '<A-n>i'
" let g:user_emmet_togglecomment_key = '<A-n>/'
" let g:user_emmet_splitjointag_key = '<A-n>j'
" let g:user_emmet_removetag_key = '<A-n>k'
" let g:user_emmet_anchorizeurl_key = '<A-n>a'
" let g:user_emmet_anchorizesummary_key = '<A-n>A'
" let g:user_emmet_mergelines_key = '<A-n>m'
" let g:user_emmet_codepretty_key = '<A-n>c'

function! s:emmet_configuration() abort
  execute 'EmmetInstall'

  imap <buffer> <A-n><A-n> <C-y><plug>(emmet-expand-abbr)
  nmap <buffer> <A-n><A-n> <plug>(emmet-expand-abbr)
  vmap <buffer> <A-n><A-n> <plug>(emmet-expand-abbr)

  nmap <buffer> <A-n><A-u> <C-y><plug>(emmet-update-tag)
  imap <buffer> <A-n><A-u> <plug>(emmet-update-tag)
  vmap <buffer> <A-n><A-u> <plug>(emmet-update-tag)

  nmap <buffer> <A-n><A-m> <plug>(emmet-merge-lines)
  imap <buffer> <A-n><A-m> <plug>(emmet-merge-lines)
  vmap <buffer> <A-n><A-m> <plug>(emmet-merge-lines)

  nmap <buffer> <A-n><A-k> <plug>(emmet-remove-tag)
  imap <buffer> <A-n><A-k> <plug>(emmet-remove-tag)
  vmap <buffer> <A-n><A-k> <plug>(emmet-remove-tag)

  nmap <buffer> <A-n><A-j> <plug>(emmet-split-join-tag)
  imap <buffer> <A-n><A-j> <plug>(emmet-split-join-tag)
  vmap <buffer> <A-n><A-j> <plug>(emmet-split-join-tag)

  nmap <buffer> <A-n><A-a> <plug>(emmet-anchorize-url)
  imap <buffer> <A-n><A-a> <plug>(emmet-anchorize-url)
  vmap <buffer> <A-n><A-a> <plug>(emmet-anchorize-url)
endfunction

" augroup AutoEmmet
"   autocmd!
"   autocmd FileType html,css,javascript call s:emmet_configuration()
"   " https://github.com/mattn/emmet-vim/issues/168#issuecomment-35853346
"   autocmd FileType html imap <expr> <tab>
"     \ pumvisible() ? "\<C-n>" :
"     \ emmet#isExpandable() ? "\<plug>(emmet-expand-abbr)" :
"     \ "\<tab>"
" augroup END

" EMMET

" ============================================================================
" SAYONARA {{{1
" ============================================================================

let g:sayonara_confirm_quit = 0

nnoremap <leader>q :Sayonara<cr>
nnoremap <leader>Q :Sayonara!<cr>

" nnoremap <leader>qq :q<cr>
" nnoremap <leader>qa :qa<cr>
" nnoremap <leader>qw :x<cr>

" SAYONARA


" ============================================================================
" QFENTER {{{1
" ============================================================================

let g:qfenter_keymap = {}
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" QFENTER


" ============================================================================
" SQL {{{1
" ============================================================================

" Use previewheight to set default preview window size

" Airline SQL helpers
function! AirlineDBConnName()
  let dbconn = get(b:, 'dbconn', get(g:, 'dbconn'))
  if empty(dbconn)
    return '[NO DB CONNECTION]'
  endif
  return '[' . split(dbconn, '=')[0] . ']'
endfunction
function! AirlineDB(...)
  if &filetype == 'sql'
    let w:airline_section_x = g:airline_section_x . '%{AirlineDBConnName()}'
  endif
endfunction
call airline#add_statusline_func('AirlineDB')


let g:sql_type_default = 'pgsql'

" Disable default vim SQL autocompletion
let g:loaded_sql_completion = 1
let g:omni_sql_no_default_maps = 1

function! GetSQL()
  " if line starts with \, get only the line, else the paragraph
  " query saved in s register
  if getline('.') =~ '^\s*\\'
    execute 'normal "syy'
  else
    execute 'normal "syip'
  endif

  " remove multiline comments
  let @s = substitute(@s, '/\*.\{-}\*/', '', 'g')
  " remove comments ( {-} is the same as * but uses
  " the shortest match first algorithm)
  let @s = substitute(@s, '--.\{-}\n', '', 'g')
  "remove empty lines
  let @s = substitute(@s, '\s\+\n', '', 'g')
  " replace newlines with spaces
  let @s = substitute(@s, '\n\+', ' ', 'g')

endfunction

function! s:get_dbs()
  return values(map(DotenvRead(), {key, val -> key . '=' . val}))
endfunction

function! ConnectToDb(db)
  if exists('g:db')
    let s:scope = 'b:db'
    let b:dbconn = a:db
  else
    let s:scope = 'g:db'
    let g:dbconn = a:db
  endif
  let l:idx = stridx(a:db, '=') + 1
  execute 'DB '. s:scope . ' = ' . strpart(a:db, l:idx)

endfunction

command! DBConnection call fzf#run({
  \ 'source':  s:get_dbs(),
  \ 'down':    '~30%',
  \ 'sink':    function('ConnectToDb')})

function! GetCurrentDbUrl()
  for dict in [w:, t:, b:, g:]
    if has_key(dict, 'db') && !empty(dict.db)
      return dict.db
    endif
  endfor
  return ''
endfunction

function! GetCurrentDbName()
  return get(split(GetCurrentDbUrl(), '/'), -1, 'unknowDB')
endfunction

function! GetCurrentDbUser()
  let s:netloc = get(split(GetCurrentDbUrl(), '/'), 2, 'unknowDB')
  return get(split(s:netloc, ':'), 0, 'unknowUser')
endfunction

function! GetDumpPath()
  let s:path = '~/_db_dumps'
  call MakeDirIfNoExists(s:path)
  return s:path . '/' . strftime("%Y%m%d_%H%M%S_") . GetCurrentDbUser() . '_' . GetCurrentDbName() . '.dump '

endfunction

augroup AutoSQL
  autocmd!
  autocmd FileType sql nnoremap <buffer> cpp :call GetSQL()<CR>:DB <C-R>s<CR>
  autocmd FileType sql vnoremap <buffer> cpp :DB<CR>
  autocmd FileType sql nnoremap <buffer> g? :help personal-sql-mappings<CR>
  autocmd BufReadPost *.dbout let g:last_dadbod_file = expand('%:p')
  autocmd TermOpen *.dbout nnoremap <silent> <buffer> q :close<cr>
  autocmd TermOpen *.dbout tnoremap <silent> <buffer> q <C-\><C-n>:close<cr>
  autocmd TermOpen *.dbout startinsert
augroup END

nnoremap <Leader>zz :DBConnection<cr>
" nnoremap <expr> <Leader>zd ':!pg_dump ' . GetCurrentDbUrl() . ' > '
nnoremap <expr> <Leader>zb ':Spawn -wait=always pg_dump -v -Fc -f ' . GetDumpPath() . ' ' . GetCurrentDbUrl()
nnoremap <expr> <Leader>zs ':echo "Current DB URL -> ' . GetCurrentDbUrl() . '"<cr>'
nnoremap <Leader>zm :-tabnew \| call termopen('pspg -s 6 -f <C-R>=g:last_dadbod_file<CR>')<cr>
nnoremap <Leader>zr :r <C-R>=g:last_dadbod_file<cr><cr>


" END SQL


" ============================================================================
" EASY-ALIGN {{{1
" ============================================================================

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)

xnoremap <Leader>a<space> :EasyAlign \ <cr>
nmap <Leader>a<space> <Plug>(EasyAlign)ab <Nop>

" END EASY-ALIGN


" ============================================================================
" MATCHUP {{{1
" ============================================================================


let g:matchup_transmute_enabled = 1
let g:matchup_matchparen_status_offscreen = 0

let g:matchup_matchpref = {
    \ 'html': { 'tagnameonly': 1, },
    \ 'javascript':  { 'tagnameonly': 1, },
    \}

function! JsxHotfix()
  setlocal matchpairs=(:),{:},[:],<:>
  let b:match_words = '<\@<=\([^/][^ \t>]*\)\g{hlend}[^>]*\%(/\@<!>\|$\):<\@<=/\1>'
endfunction
let g:matchup_hotfix_javascript = 'JsxHotfix'

" END MATCHUP


" ============================================================================
" ULTISNIPS {{{1
" ============================================================================


let g:UltiSnipsExpandTrigger="<A-u>"
let g:UltiSnipsJumpForwardTrigger="<A-j>"
let g:UltiSnipsJumpBackwardTrigger="<A-k>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"



" END ULTISNIPS


" ============================================================================
" HEXOKINASE {{{1
" ============================================================================

let g:Hexokinase_virtualText = '███'
let g:Hexokinase_refreshEvents = ['TextChanged', 'TextChangedI']
let g:Hexokinase_ftAutoload = ['css', 'xml']

" END HEXOKINASE
