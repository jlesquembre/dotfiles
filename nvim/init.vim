" ============================================================================
" Neovim default
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
  silent !curl -qfLo ~/.config/nvim/autoload/plug.vim --create-dirs
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
" Plug 'srcery-colors/srcery-vim'
" Plug 'junegunn/seoul256.vim'
" Plug 'rakr/vim-one'
" Plug 'joshdick/onedark.vim'
" Plug 'challenger-deep-theme/vim', {'as': 'challenger-deep-theme'}
" Plug 'KabbAmine/yowish.vim'
" Plug 'mhinz/vim-janah'
" Plug 'dracula/vim', {'as': 'dracula-colorscheme'}
" Plug 'liuchengxu/space-vim-dark'
" Plug 'romainl/Apprentice'
" Plug 'ayu-theme/ayu-vim'


Plug 'ryanoasis/vim-devicons'

" Navigation
" Plug 'andymass/vim-matchup'
" Plug 'Yggdroot/hiPairs'
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-vinegar'
" Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'kristijanhusak/defx-icons'
" Plug 'justinmk/vim-dirvish'
" Plug 'kristijanhusak/vim-dirvish-git'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'yuki-ycino/fzf-preview.vim'
Plug 'stsewd/fzf-checkout.vim'
Plug 'mhinz/vim-grepper'
Plug 'dyng/ctrlsf.vim'
"Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
" Plug 'unblevable/quick-scope'
" Plug 'takac/vim-hardtime'
Plug 'nelstrom/vim-visual-star-search'
Plug 'michaeljsmith/vim-indent-object'


" Text edition
"Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'
Plug 'tpope/vim-commentary'
"gorkunov/smartpairs.vim
"Plug 'cohama/lexima.vim'
" Plug 'jiangmiao/auto-pairs'
" Plug 'tmsvg/pear-tree'
Plug 'tpope/vim-jdaddy'
" Plug 'tpope/vim-endwise'
Plug 'tpope/vim-speeddating'
" Plug 'jlesquembre/rst-tables.nvim', {'do': ':UpdateRemotePlugins'}
" Plug 'machakann/vim-swap'
" Plug 'mattn/emmet-vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'chrisbra/NrrwRgn'
Plug 'tommcdo/vim-exchange'
Plug 'vim-scripts/transpose-words'
Plug 'tpope/vim-capslock'


" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'machakann/vim-highlightedyank'
" Plug 'fszymanski/ListToggle.vim'
"Plug 'itchyny/vim-cursorword'

" https://github.com/vim/vim/issues/453
" Plug 'henrik/vim-indexed-search'


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
Plug 'bakpakin/fennel.vim'
Plug 'bakpakin/janet.vim'

" JS / TS
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'jonsmithers/vim-html-template-literals'
Plug 'jxnblk/vim-mdx-js'
" Plug 'mxw/vim-jsx'
" Plug 'MaxMEllon/vim-jsx-pretty'
" Plug 'HerringtonDarkholme/yats.vim'  " Typescript

"Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': 'tex'}
Plug 'lervag/vimtex', {'for': 'tex'}
Plug 'PotatoesMaster/i3-vim-syntax'
Plug 'LnL7/vim-nix'
Plug 'cespare/vim-toml'
Plug 'purescript-contrib/purescript-vim'
Plug 'google/vim-jsonnet'
Plug 'derekwyatt/vim-scala'
Plug 'vmchale/just-vim'
" Plug 'Glench/Vim-Jinja2-Syntax'

" Plug 'ap/vim-css-color'  " Needs to be loaded AFTER the syntax
Plug 'RRethy/vim-hexokinase'

" General utils
Plug 'Konfekt/vim-alias'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-dotenv'
Plug 'tpope/vim-rsi'
Plug 'radenling/vim-dispatch-neovim'
Plug 'editorconfig/editorconfig-vim'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'tpope/vim-projectionist'
"Plug 'neomake/neomake'
"Plug 'sbdchd/neoformat'
Plug 'w0rp/ale'
Plug 'jamessan/vim-gnupg'
Plug 'kassio/neoterm'
Plug 'metakirby5/codi.vim'
Plug 'mhinz/vim-sayonara'
" Plug 'semanser/vim-outdated-plugins'
Plug 'romainl/vim-qf'
" Plug 'junegunn/vim-peekaboo'
Plug 'chrisbra/Recover.vim'
Plug 'embear/vim-localvimrc'
" Plug 'direnv/direnv.vim'
" Plug 'diepm/vim-rest-console'
" Plug 'baverman/vial'
" Plug 'baverman/vial-http'

" Autocompletion
" Plug 'roxma/nvim-completion-manager'
" Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
" " Plug 'Shougo/neopairs.vim'

" Plug 'ponko2/deoplete-fish'
" Plug 'carlitux/deoplete-ternjs'

if exists("g:use_coc") && exists("g:use_conjure")
  " Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
Plug 'guns/vim-sexp',                              { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight',                 { 'for': 'clojure' } | Plug 'guns/vim-clojure-static', { 'for': 'clojure' }


" Plug 'clojure-vim/nvim-parinfer.js', {'do': 'lein do npm install'}
Plug 'eraserhd/parinfer-rust', {'do': 'nix-shell --run \"cargo build --release \"'}
Plug 'humorless/vim-kibit'

if exists("g:use_conjure")
  Plug 'Olical/conjure', {'branch': 'master'}
else
  Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
endif

Plug 'guns/vim-slamhound', { 'for': 'clojure' }
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

" Language specific helpers
Plug 'mhinz/vim-crates'  " Already lazy, don't use Plug 'for' or 'on'
Plug 'vim-ruby/vim-ruby', { 'for': 'ruby' }

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
" set lazyredraw

" Better folds
"set foldcolumn=1
set foldmethod=marker
" set foldopen+=jump
" set shortmess-=F

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
" the double // at the end is import see :h dir
execute "set directory=".tmpvim_dir."swap//"
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


augroup CustomFileTypeDetection
  autocmd!
  autocmd BufRead,BufNewFile Tiltfile setfiletype bzl
augroup END

" Set augroup
" See https://vi.stackexchange.com/a/9458/2660
augroup user_augroup
  autocmd!
  autocmd FileType help wincmd K

  " Help NeoVim check for modified files: https://github.com/neovim/neovim/issues/2127
  " autocmd BufEnter,FocusGained * checktime
  " autocmd BufEnter,FocusGained * if mode() != 'c' | checktime | endif
  autocmd BufEnter,FocusGained * if !bufexists("[Command Line]") | checktime | endif


  " autocmd BufEnter,CursorHold,CursorHoldI,CursorMoved,CursorMovedI,FocusGained,BufEnter,FocusLost,WinLeave * checktime

  " The PC is fast enough, do syntax highlight syncing from start
  autocmd BufEnter * syntax sync fromstart

  " Only use cursorline for current window
  autocmd WinEnter,FocusGained * setlocal cursorline
  autocmd WinLeave,FocusLost   * setlocal nocursorline

  " jsonc support
  autocmd BufRead,BufNewFile tsconfig.json set filetype=jsonc
  autocmd FileType jsonc call SetJsoncOptions()
  autocmd FileType json  syntax match Comment +\/\/.\+$+

augroup END

function SetJsoncOptions()
  source $VIMRUNTIME/syntax/json.vim
  syntax match Comment +\/\/.\+$+
  setlocal commentstring=//\ %s
endfunction

" END BASIC SETTINGS

" ============================================================================
" PERSONAL DOC {{{1
" ============================================================================

augroup user_personal_doc
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
  " let s:gui_bg = "0F1419"  " From ayu colors
  let s:gui_bg = "080808"  " From moonfly colors
  " let g:base16_gui00 = "0F1419"
  call Base16hi("Normal",     "",             s:gui_bg,       "", "", "", "")
  call Base16hi("Error",      s:gui_bg,                       "", "", "", "", "")
  call Base16hi("ErrorMsg",   "",             s:gui_bg,       "", "", "", "")
  call Base16hi("Conceal",    s:gui_bg,                       "", "", "", "", "")
  call Base16hi("Cursor",     "",             s:gui_bg,       "", "", "", "")
  " call Base16hi("CursorLine", "",             g:base16_gui00, "", "", "", "")

  call Base16hi("MatchParen",    g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold,italic", "")
  " call Base16hi("hiPairs_matchPair",    g:base16_gui05, g:base16_gui03, g:base16_cterm05, g:base16_cterm03, "bold,italic", "")
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
  highlight clear ALEInfoSignLineNr
  highlight clear ALEWarningSignLineNr
  highlight clear ALEErrorSignLineNr

  call Base16hi("CocErrorSign",   g:base16_gui08, g:base16_gui01, "", "", "", "")
  call Base16hi("CocWarningSign",   g:base16_gui09, g:base16_gui01, "", "", "", "")
  call Base16hi("CocInfoSign",   g:base16_gui0D, g:base16_gui01, "", "", "", "")
  call Base16hi("CocHintSign",   g:base16_gui0B, g:base16_gui01, "", "", "", "")

  call Base16hi("CocError",     "", "", "", "", "underline", g:base16_gui08)
  call Base16hi("CocWarning",     "", "", "", "", "underline", g:base16_gui09)
  call Base16hi("CocHighlightText",     "", g:base16_gui02, "", "", "", "" )

endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call g:Base16_customize()
augroup END

colorscheme base16-default-dark
" colorscheme apprentice
" colorscheme OceanicNext
" colorscheme srcery
" colorscheme onedark
" let ayucolor="light"  " for light version of theme
" let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu

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
  let l:title = system('curl -q -L --compressed --silent '. shellescape(l:link) . ' | gawk -v IGNORECASE=1 -v RS=''</title'' ''RT{gsub(/.*<title[^>]*>/,"");print;exit}'' ')
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

" Expand the Active File Directory
cnoremap <expr> %% getcmdtype() == ':' ? fnameescape(expand('%:h')) . '/' : '%%'

" Better abbreviations
nnoremap : ,
xnoremap : ,
onoremap : ,

nnoremap , :
xnoremap , :
onoremap , :

nnoremap g: g,
nnoremap g, <NOP>

nnoremap @, @:
nnoremap @: <NOP>

nnoremap c, q:
xnoremap c, q:

nnoremap q: <NOP>
xnoremap q: <NOP>

function SetAliases()
  execute 'Alias gp Git\ pull\ --ff-only'
  execute 'Alias gs Git\ switch'
  execute 'Alias gsc Git\ switch\ --create'
  " Create parent directories
  execute 'Alias mk Mkdir!\ |\ update'
endfunction

if exists('s:loaded_vimafter')
  silent doautocmd VimAfter VimEnter *
else
  let s:loaded_vimafter = 1
  augroup VimAfter
    autocmd!
    autocmd VimEnter * call SetAliases()
  augroup END
endif

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

" Center on scroll
" nnoremap j jzz
" nnoremap k kzz
" set scrolloff=999

"nmap <leader>w <C-w>
nnoremap <leader>w <C-w>

" nnoremap <leader>d "_d
" vnoremap <leader>d "_d

" un-join (split) the current line at the cursor position
nnoremap gj i<c-j><esc>k$
" nnoremap gJ i<c-j><esc>k$
nnoremap x  "_d
xnoremap x  "_d

nnoremap <leader>p  "0p
nnoremap <leader>P  "0P
nnoremap g<leader>p  "0gp
nnoremap g<leader>P  "0gP
xnoremap <leader>p  "0p
xnoremap <leader>P  "0P
xnoremap g<leader>p  "0gp
xnoremap g<leader>P  "0gP
nnoremap xx x

" Insert single character
" nnoremap <tab> i_<Esc>r

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
nnoremap <expr> n 'Nn'[v:searchforward] . 'zv'
nnoremap <expr> N 'nN'[v:searchforward] . 'zv'

" Saner command-line history
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Saner CTRL-L
nnoremap <leader>l :nohlsearch<cr>:GitGutter<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>

" Quick saving
nnoremap <silent> <Leader>s :update<CR>
inoremap <C-s> <C-o>:w<cr>

" Show syntax highlighting groups for word under cursor
nnoremap <F10> :call <SID>SynStack()<CR>

" Fix neovim block with function keys
inoremap <F1>  <nop>
inoremap <F2>  <nop>
inoremap <F3>  <nop>
inoremap <F4>  <nop>
inoremap <F5>  <nop>
inoremap <F6>  <nop>
inoremap <F7>  <nop>
inoremap <F8>  <nop>
inoremap <F9>  <nop>
inoremap <F10> <nop>
inoremap <F11> <nop>
inoremap <F12> <nop>

" move vertically by visual line
nnoremap j gj
nnoremap k gk

" tab map
nnoremap <leader>gn :tabnew<cr>

" move to beginning/end of line
noremap <silent> <Leader>b ^
noremap <silent> <Leader>e $

" Quick breakpoints
augroup AutoBreakpoint
  autocmd!
  autocmd FileType python map <silent><buffer> <leader><leader>b oimport ipdb; ipdb.set_trace()<esc>
  autocmd FileType python map <silent><buffer> <leader><leader>B Oimport ipdb; ipdb.set_trace()<esc>
  autocmd FileType javascript,typescript map <silent><buffer> <leader><leader>b odebugger;<esc>
  autocmd FileType javascript,typescript map <silent><buffer> <leader><leader>B Odebugger;<esc>

  autocmd FileType clojure map <silent><expr><buffer> <leader><leader>b 'saa((i./spy <esc>'
augroup END

" Select last inserted text
nnoremap gV `[v`]

" open file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<cr>
" create file under cursor
nnoremap <Leader>nf :vsp %:h/<C-r><C-a><CR>

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

" quickly edit macros
" nnoremap <leader>m  :<c-u><c-r><c-r>='let @'. v:register.' = '. string(getreg(v:register))<cr><c-f><left>
function! ChangeReg() abort
  echo 'Register to edit?'
  let x = nr2char(getchar())
  call feedkeys("q:ilet @" . x . " = \<c-r>\<c-r>=string(@" . x . ")\<cr>\<esc>0f'", 'n')
endfunction
nnoremap <silent> <leader>cr :call ChangeReg()<cr>

" set lazyredraw before running a macro
function! RunMacro() abort
  set lazyredraw
  echo 'Macro to execute?'
  let x = nr2char(getchar())
  execute 'normal! '. v:count . '@' . x
  set nolazyredraw
endfunction
" nnoremap @ :<c-u>call RunMacro()<cr>
" nnoremap Q :<c-u>call RunMacro()<cr>@

" Add insertmode commands and remove some from rsi.vim
augroup readline
  autocmd!
  autocmd VimEnter * iunmap   <C-d>
  autocmd VimEnter * iunmap   <C-f>
  autocmd VimEnter * inoremap <C-y> <C-r><C-o>+
  autocmd VimEnter * cnoremap <C-y> <C-r><C-o>+
augroup END

" END MAPPINGS

" ============================================================================
" VIM PLUGINS {{{1
" ============================================================================

let g:htl_css_templates=1

let g:startify_change_to_vcs_root = 1
let g:startify_session_dir = '~/.config/nvim/session'

let g:rooter_silent_chdir = 1

" END PLUGINS

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

let g:gitgutter_map_keys = 0
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
nmap <Leader>hs <Plug>(GitGutterStageHunk)
nmap <Leader>hd <Plug>(GitGutterUndoHunk)
nmap <Leader>hp <Plug>(GitGutterPreviewHunk)
omap ih <Plug>(GitGutterTextObjectInnerPending)
omap ah <Plug>(GitGutterTextObjectOuterPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)
xmap ah <Plug>(GitGutterTextObjectOuterVisual)

" END GIT GUTTER


" ============================================================================
" FUGITIVE {{{1
" ============================================================================

nnoremap <leader>gww :Gwrite<CR>
nnoremap <leader>grr :Gread<CR>
" <Bar> is the pipe (|) char. Gwrite output is shown, and Gcommit is not
" executed if there is an error with Gwrite, and alternative map is:
" nnoremap <leader>gwc :Gwrite<CR>:Gcommit<CR>
" but in that case we lose the Gwrite output (unless there is an error)
nnoremap <leader>gwc :Gwrite<Bar>:Gcommit<CR>
nnoremap <leader>gd :Gdiff<CR>
nnoremap <leader>gg :G<CR>
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
  autocmd BufEnter COMMIT_EDITMSG inoremap <C-s> <esc>ZZ
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

" Don't use default fzf terminal options
unlet $FZF_DEFAULT_OPTS

" let g:fzf_files_options = '--preview "(file -ib {} | rg binary || bat --color always --paging never --style plain --line-range :'. &lines . ' {} || cat {}) 2> /dev/null"'

" nnoremap <silent> <Leader>f       :FilesFd<CR>
" nnoremap <silent> <Leader>ff      :FilesFd<CR>
" nnoremap <silent> <Leader>fa      :FilesFdAll<CR>
" nnoremap <silent> <Leader>fg      :GFiles<CR>
" nnoremap <silent> <Leader>fc      :Colors<CR>
" nnoremap <silent> <Leader><Enter> :Buffers<CR>
" nnoremap <silent> <Leader>fr     :Find <C-R><C-W><CR>
" xnoremap <silent> <Leader>fr     y:Find <C-R>"<CR>
" nnoremap <silent> <Leader>`       :Marks<CR>

"inoremap <expr> <c-x><c-t> fzf#complete('tmuxwords.rb --all-but-current --scroll 500 --min 5')
imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)
imap <c-x><c-j> <plug>(fzf-complete-file-ag)
imap <c-x><c-l> <plug>(fzf-complete-line)

nmap <leader><tab> <plug>(fzf-maps-n)
xmap <leader><tab> <plug>(fzf-maps-x)
omap <leader><tab> <plug>(fzf-maps-o)

" let g:fzf_preview_filelist_command = 'fd --hidden --follow --exclude ".git" --type file --type symlink'
" let g:fzf_preview_directory_files_command = 'fd --hidden --follow --no-ignore'
let g:fzf_preview_command = 'bat --color always --paging never --style plain --line-range :100 {-1}'
" let g:fzf_preview_command = 'bat --color always --paging never --style plain {-1}'
let g:fzf_preview_floating_window_winblend = 0
let g:fzf_preview_floating_window_rate = 0.8
let g:fzf_preview_use_dev_icons = 1
" let g:fzf_preview_filelist_postprocess_command = 'xargs -d "\n" exa --color=always' " Use exa

nmap <Leader>f [fzf-p]
xmap <Leader>f [fzf-p]

nnoremap <silent> [fzf-p]f     :<C-u>FzfPreviewProjectFiles<CR>
nnoremap <silent> [fzf-p]a     :<C-u>FzfPreviewDirectoryFiles<CR>
nnoremap <silent> [fzf-p]gg    :<C-u>FzfPreviewGitStatus<CR>
nnoremap <silent> <Leader><CR> :<C-u>FzfPreviewBuffers<CR>
nnoremap <silent> [fzf-p]b     :<C-u>FzfPreviewAllBuffers<CR>
nnoremap <silent> [fzf-p]j     :<C-u>FzfPreviewJumps<CR>
nnoremap <silent> [fzf-p]/     :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'"<CR>
nnoremap <silent> [fzf-p]*     :<C-u>FzfPreviewLines -add-fzf-arg=--no-sort -add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>
nnoremap          [fzf-p]s     :<C-u>FzfPreviewProjectGrep<Space>
xnoremap          [fzf-p]s     "sy:FzfPreviewProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"
nnoremap <silent> [fzf-p]q     :<C-u>FzfPreviewQuickFix<CR>
nnoremap <silent> [fzf-p]l     :<C-u>FzfPreviewLocationList<CR>
nnoremap <silent> [fzf-p]m     :<C-u>FzfPreviewMarks<CR>
" nnoremap <silent> [fzf-p]g;    :<C-u>FzfPreviewChanges<CR>
" nnoremap <silent> [fzf-p]t     :<C-u>FzfPreviewBufferTags<CR>

command! -bang -nargs=? -complete=dir FilesFd call fzf#vim#files(<q-args>, {
  \ 'source': 'fd --hidden --follow --exclude ".git" --type file --type symlink'
  \ },
  \ <bang>0)

command! -bang -nargs=? -complete=dir FilesFdAll call fzf#vim#files(<q-args>, {
  \ 'source': 'fd --hidden --follow --no-ignore'
  \ },
  \ <bang>0)


command! Plugs call fzf#run({
  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
  \ 'options': '--delimiter / --nth -1',
  \ 'down':    '~30%',
  \ 'sink':    'Defx'})

" augroup fzf_custom
"   autocmd!
"   autocmd FileType fzf tnoremap <buffer> <C-j> <C-n>
"   autocmd FileType fzf tnoremap <buffer> <C-k> <C-p>
"   autocmd FileType fzf tnoremap <buffer> <esc> <C-c>
" augroup END


" END FZF


" ============================================================================
" AIRLINE {{{1
" ============================================================================

let g:whitespace_filetypes_blacklist = [
\ 'git', 'fugitive', 'magit',
\ 'diff', 'gitcommit', 'unite', 'qf', 'help'
\ ]


let g:airline_theme='oceanicnext'
"let g:airline_theme='onedark'
" let g:airline_theme='base16_default' " same as base16-default-dark
let g:airline_powerline_fonts = 1

let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''


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
let g:airline#extensions#ale#enabled = 1

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


augroup customAirline
  autocmd!
  autocmd VimEnter   *        call airline#add_statusline_func('AirlineTerm')
  autocmd VimEnter   *        call airline#add_statusline_func('AirlineDB')
  autocmd SourcePost $MYVIMRC if exists(':AirlineRefresh') | AirlineRefresh | endif
  execute 'autocmd FileType '.join(g:whitespace_filetypes_blacklist, ','). ' let b:airline_whitespace_disabled = 1'
  " autocmd WinEnter,BufWinEnter __vial_* let w:airline_disabled=1
augroup END


" END AIRLINE


" ============================================================================
" FERN {{{1
" ============================================================================

let g:loaded_netrwPlugin = 1 " Disable netrw.vim
let g:fern#disable_default_mappings = 1
let g:fern#renderer = "nerdfont"

" Return a parent directory of the current buffer when the buffer is a file.
" Otherwise it returns a current working directory.
function! s:smart_path() abort
  if !empty(&buftype) || bufname('%') =~# '^[^:]\+://'
    return fnamemodify('.', ':p')
  endif
  return fnamemodify(expand('%'), ':p:h')
endfunction

" noremap <silent>  :Fern . -drawer -width=35 -toggle<CR><C-w>=
noremap <silent> <Leader>ee :Fern . -toggle -drawer -reveal=% -width=35<CR><C-w>=
noremap <silent> - :Fern <C-r>=<SID>smart_path()<CR> -reveal=%<CR>


function! FernInit() abort
  nmap <buffer><expr>
        \ <Plug>(fern-my-open-expand-collapse)
        \ fern#smart#leaf(
        \   "\<Plug>(fern-action-open:select)",
        \   "\<Plug>(fern-action-expand)",
        \   "\<Plug>(fern-action-collapse)",
        \ )
  nmap <buffer> <CR> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> <2-LeftMouse> <Plug>(fern-my-open-expand-collapse)
  nmap <buffer> N <Plug>(fern-action-new-file)
  " nmap <buffer> A <Plug>(fern-action-new-file)<C-r>=strftime("%Y-%m-%d-")<cr>.md<Left><Left><Left>
  nmap <buffer> K <Plug>(fern-action-new-dir)
  nmap <buffer> D <Plug>(fern-action-remove)
  nmap <buffer> H <Plug>(fern-action-hidden-toggle)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> C <Plug>(fern-action-copy)
  nmap <buffer><nowait> r <Plug>(fern-action-reload)
  nmap <buffer><nowait> m <Plug>(fern-action-mark-toggle)j
  nmap <buffer> e <Plug>(fern-action-open)
  nmap <buffer> s <Plug>(fern-action-open:split)
  nmap <buffer> v <Plug>(fern-action-open:vsplit)
  nmap <buffer> p <Plug>(fern-action-open:side)<C-w>p
  nmap <buffer> t <Plug>(fern-action-open:tabedit)
  nmap <buffer><nowait> <Right> <Plug>(fern-action-enter)
  nmap <buffer><nowait> <Left> <Plug>(fern-action-leave)
  nmap <buffer><nowait> - <Plug>(fern-action-leave)
endfunction

augroup FernGroup
  autocmd!
  autocmd FileType fern call FernInit()
augroup END

" END FERN


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

let g:highlightedyank_highlight_duration = 500

hi HighlightedyankRegion cterm=reverse gui=reverse

" END OPERATOR FLASHY


" ============================================================================
" CLOJURE {{{1
" ============================================================================

" Disable predefined sexp mappings {{{2

let g:sexp_mappings = {
    \ 'sexp_outer_list':                'af',
    \ 'sexp_inner_list':                'if',
    \ 'sexp_outer_top_list':            'ar',
    \ 'sexp_inner_top_list':            'ir',
    \ 'sexp_outer_string':              'as',
    \ 'sexp_inner_string':              'is',
    \ 'sexp_outer_element':             'ae',
    \ 'sexp_inner_element':             'ie',
    \ 'sexp_move_to_prev_bracket':      '<M-f>',
    \ 'sexp_move_to_next_bracket':      '<M-v>',
    \ 'sexp_move_to_prev_element_head': '',
    \ 'sexp_move_to_next_element_head': '',
    \ 'sexp_move_to_prev_element_tail': '',
    \ 'sexp_move_to_next_element_tail': '',
    \ 'sexp_flow_to_prev_open':         '(',
    \ 'sexp_flow_to_next_open':         ')',
    \ 'sexp_flow_to_prev_close':        '',
    \ 'sexp_flow_to_next_close':        '',
    \ 'sexp_flow_to_prev_leaf_head':    'b',
    \ 'sexp_flow_to_next_leaf_head':    'w',
    \ 'sexp_flow_to_prev_leaf_tail':    'ge',
    \ 'sexp_flow_to_next_leaf_tail':    'e',
    \ 'sexp_move_to_prev_top_element':  '[[',
    \ 'sexp_move_to_next_top_element':  ']]',
    \ 'sexp_select_prev_element':       '[v',
    \ 'sexp_select_next_element':       ']v',
    \ 'sexp_indent':                    '==',
    \ 'sexp_indent_top':                '=-',
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
    \ 'sexp_convolute':                 '<leader>?',
    \ 'sexp_raise_list':                '<leader>o',
    \ 'sexp_raise_element':             '<leader>O',
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

  " It's not possible to remap CTRL-M in insert mode, see
  " :h index -> see list of vim mappings
  " :h key-notation
  nnoremap <silent><buffer> <c-n> :ParinferToggleMode<cr>
  vnoremap <silent><buffer> <c-n> <esc>:ParinferToggleMode<cr>gv
  inoremap <silent><buffer> <c-n> <c-o>:ParinferToggleMode<cr>
  nnoremap <silent><buffer> <leader>cm :ParinferToggleMode<cr>

  nnoremap <buffer> <leader>cn :Slamhound<cr>
endfunction

" let g:conjure_default_mappings = v:false
" let g:conjure_log_direction = "horizontal"
" " let g:conjure_log_auto_open = ['eval', 'ret', 'ret-multiline', 'out', 'err', 'tap', 'doc', 'load-file', 'test']
" let g:conjure_log_blacklist = ["ret", "ret-multiline", "load-file", "eval"]

let conjure#log#wrap = v:true

let g:conjure#mapping#prefix = "c"
let g:conjure#mapping#log_split = "ls"
let g:conjure#mapping#log_vsplit = "ll"
let g:conjure#mapping#log_tab = "lt"
let g:conjure#mapping#log_close_visible = "lq"
let g:conjure#mapping#eval_current_form = "pp"
let g:conjure#mapping#eval_root_form = "pr"
let g:conjure#mapping#eval_replace_form = "p!"
let g:conjure#mapping#eval_marked_form = "pm"
let g:conjure#mapping#eval_word = "pw"
let g:conjure#mapping#eval_file = "pf"
let g:conjure#mapping#eval_buf = "pb"
let g:conjure#mapping#eval_visual = "p"
let g:conjure#mapping#eval_motion = "m"
" let g:conjure#mapping#doc_word = ["K"]
" let g:conjure#mapping#def_word = ["gd"]

" let g:conjure#client#clojure#nrepl#mapping#disconnect = "cd"
let g:conjure#client#clojure#nrepl#mapping#connect_port_file = "u"
let g:conjure#client#clojure#nrepl#mapping#interrupt = "ui"
" let g:conjure#client#clojure#nrepl#mapping#last_exception = "ve"
" let g:conjure#client#clojure#nrepl#mapping#result_1 = "v1"
" let g:conjure#client#clojure#nrepl#mapping#result_2 = "v2"
" let g:conjure#client#clojure#nrepl#mapping#result_3 = "v3"
" let g:conjure#client#clojure#nrepl#mapping#view_source = "vs"
" let g:conjure#client#clojure#nrepl#mapping#session_clone = "sc"
" let g:conjure#client#clojure#nrepl#mapping#session_fresh = "sf"
" let g:conjure#client#clojure#nrepl#mapping#session_close = "sq"
" let g:conjure#client#clojure#nrepl#mapping#session_close_all = "sQ"
" let g:conjure#client#clojure#nrepl#mapping#session_list = "sl"
" let g:conjure#client#clojure#nrepl#mapping#session_next = "sn"
" let g:conjure#client#clojure#nrepl#mapping#session_prev = "sp"
" let g:conjure#client#clojure#nrepl#mapping#session_select = "ss"
let g:conjure#client#clojure#nrepl#mapping#run_all_tests = "pta"
let g:conjure#client#clojure#nrepl#mapping#run_current_ns_tests = "ptt"
let g:conjure#client#clojure#nrepl#mapping#run_alternate_ns_tests = "ptN"
let g:conjure#client#clojure#nrepl#mapping#run_current_test = "ptc"
" let g:conjure#client#clojure#nrepl#mapping#refresh_changed = "rr"
" let g:conjure#client#clojure#nrepl#mapping#refresh_all = "ra"
" let g:conjure#client#clojure#nrepl#mapping#refresh_clear = "rc"

function! ClojureCustomSettings()
  if exists("g:use_conjure")
    " nnoremap <buffer> cu :ConjureUp<cr>
    " nnoremap <buffer> cps :ConjureStatus<cr>
    " vnoremap <buffer> cpw :ConjureEval<cr>
    " vnoremap <buffer> cpp :ConjureEvalSelection<cr>
    " nnoremap <buffer> cpp :ConjureEvalCurrentForm<cr>
    " nnoremap <buffer> cpr :ConjureEvalRootForm<cr>
    " nnoremap <buffer> cpm :ConjureEvalFormAtMark<cr>
    " nnoremap <buffer> cpb :ConjureEvalBuffer<cr>
    " nnoremap <buffer> cpf :ConjureLoadFile <c-r>=expand('%:p')<cr><cr>
    " nnoremap <buffer> K :ConjureDoc <c-r><c-w><cr>
    " nnoremap <buffer> css :ConjureSource <c-r><c-w><cr><cr>
    " nnoremap <buffer> gd :ConjureDefinition <c-r><c-w><cr>
    " nnoremap <buffer> cll :ConjureToggleLog<cr>

    " " nnoremap <buffer> crr :ConjureEval (clojure.tools.namespace.repl/refresh)<cr>
    " nnoremap <buffer> crr :ConjureRefresh changed<cr>
    " nnoremap <buffer> cra :ConjureRefresh all<cr>
    " nnoremap <buffer> crc :ConjureRefresh clear<cr>
    " nnoremap <buffer> cri :ConjureEval (integrant.repl/reset)<cr>
    " " nnoremap <buffer> <leader>q :ConjureCloseLog<cr>
    " nnoremap <buffer> cpt :ConjureRunTests<cr>
    " nnoremap <buffer> cptt :ConjureRunAllTests<cr>
    " setlocal omnifunc=conjure#omnicomplete
  else
    nmap <silent><buffer> <leader>cc cqp<Up>
    nnoremap <buffer> crr :Require<cr>
    nnoremap <buffer> cra :Require!<cr>
  endif

  " Insert double quote
  imap <silent><buffer> "    <Plug>(sexp_insert_double_quote)
  " Delete paired delimiters
  imap <silent><buffer> <BS> <Plug>(sexp_insert_backspace)

  nmap <buffer> <leader>a >I<cr>
  nmap <buffer> <leader>i <I<del><cr><up>

  nmap saf <Plug>(operator-sandwich-add)if(
  nmap sar <Plug>(operator-sandwich-add)if[
  nmap sav <Plug>(operator-sandwich-add)if{
  nmap saj <Plug>(operator-sandwich-add)ie(
  nmap sau <Plug>(operator-sandwich-add)ie[
  nmap sam <Plug>(operator-sandwich-add)ie{

endfunction


augroup clojure
  autocmd!
  autocmd FileType lisp,clojure,scheme call LispCustomSettings()
  autocmd FileType clojure call ClojureCustomSettings()
  autocmd BufEnter conjure-log-* nnoremap <buffer><silent> <leader>q :lua require('conjure.log')['close-visible']()<CR>

  " if exists("g:use_conjure")
  "   autocmd InsertEnter *.edn,*.clj,*.clj[cs] :call conjure#close_unused_log()
  "   autocmd CursorMoved *.edn,*.clj,*.clj[cs] :call conjure#quick_doc()
  "   autocmd CursorMovedI *.edn,*.clj,*.clj[cs] :call conjure#quick_doc()
  "   autocmd BufLeave *.edn,*.clj,*.clj[cs] :call conjure#quick_doc_cancel()
  " endif
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
" ALE {{{1
" ============================================================================

let g:ale_sign_error = '⬥'
let g:ale_sign_warning = '⬥'

" " let g:ale_javascript_prettier_executable = 'prettier_d'
" " let g:ale_javascript_prettier_options = '--trailing-comma es5'
" " let g:ale_javascript_eslint_executable = 'eslint_d'

" let g:ale_virtualenv_dir_names = ['venv', '.env', 'env', 've', 'virtualenv']

let g:ale_linters = {
\   'javascript': [],
\   'typescript': [],
\   'json': [],
\}

let g:ale_pattern_options = {
\   '\.go$':              {'ale_fix_on_save': 1},
\   '\.nix$':             {'ale_fix_on_save': 1},
\   'configuration.nix$': {'ale_fixers': []},
\   'all-packages.nix$':  {'ale_fixers': []},
\   '\.rs$':              {'ale_fix_on_save': 1},
\   '\.sh$':              {'ale_fix_on_save': 1},
\   'scope\.sh$':         {'ale_fixers': []},
\}

let g:ale_fixers = {
\   'go'         : [ 'gofmt' ],
\   'nix'        : [ 'nixpkgs-fmt' ],
\   'rust'       : [ 'rustfmt' ],
\   'sh'         : [ 'shfmt' ],
\}

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
nmap <silent> [w <Plug>(ale_previous_wrap)
nmap <silent> ]w <Plug>(ale_next_wrap)

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
        \'coc-emmet',
        \'coc-angular',
        \]
        " \'coc-metals',

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

  let g:coc_snippet_next = '<tab>'

  " Use <C-l> for trigger snippet expand.
  imap <expr> <C-l> pumvisible()? "\<Plug>(coc-snippets-expand)" : '\<C-l>'

  " Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
  " Coc only does snippet and additional edit on confirm.
  inoremap <silent><expr> <cr> complete_info()["selected"] != "-1" ?
        \ "\<C-y>" :
        \ "\<C-g>u\<cr>\<c-r>=coc#on_enter()\<cr>"

  " Use K to show documentation in preview window
  function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
  endfunction
  nnoremap <silent> K :call <SID>show_documentation()<cr>

  augroup cocCustom
    autocmd!
    " Highlight symbol under cursor on CursorHold
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Update signature help on jump placeholder
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp') "TODO
  augroup END

  " Remap for rename current word
  nmap <leader>rn <Plug>(coc-rename)

  " GoTo code navigation.
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gy <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)

  " Use <c-space> for trigger completion.
  inoremap <silent><expr> <c-space> coc#refresh()

  " Use `[c` and `]c` for navigate diagnostics
  " Use ALE to display diagnostics
  " nmap <silent> [c <Plug>(coc-diagnostic-prev)
  " nmap <silent> ]c <Plug>(coc-diagnostic-next)


  " Introduce function text object
  " NOTE: Requires 'textDocument.documentSymbol' support from the language server.
  xmap if <Plug>(coc-funcobj-i)
  xmap af <Plug>(coc-funcobj-a)
  omap if <Plug>(coc-funcobj-i)
  omap af <Plug>(coc-funcobj-a)

  " Use <TAB> for selections ranges.
  " NOTE: Requires 'textDocument/selectionRange' support from the language server.
  " coc-tsserver, coc-python are the examples of servers that support it.
  nmap <silent> <tab> <Plug>(coc-range-select)
  xmap <silent> <tab> <Plug>(coc-range-select)

  " Add `:OR` command for organize imports of the current buffer.
  command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
  nnoremap <leader>di :call CocAction('runCommand', 'editor.action.organizeImport')<cr>

  " Mappings using CoCList:
  nnoremap <silent> <leader>dl  :<C-u>CocList<cr>
  " " Show all diagnostics. Not useful because forward to ALE
  " nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
  " " Manage extensions.
  " nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
  " " Show commands.
  " nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
  " " Find symbol of current document.
  " nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
  " Search workspace symbols.
  nnoremap <silent> <leader>ds  :<C-u>CocList -I symbols<cr>
  " " Do default action for next item.
  " nnoremap <silent> <space>j  :<C-u>CocNext<CR>
  " " Do default action for previous item.
  " nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
  " " Resume latest coc list.
  " nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

  " For an example see:
  " https://github.com/microsoft/vscode-extension-samples/tree/master/code-actions-sample
  " " Applying codeAction to the selected region.
  " " Example: `<leader>aap` for current paragraph
  " xmap <leader>a  <Plug>(coc-codeaction-selected)
  " nmap <leader>a  <Plug>(coc-codeaction-selected)
  " Remap keys for applying codeAction to the current line.
  nnoremap <leader>dc :CocAction<cr>
  " Apply AutoFix to problem on the current line.
  nnoremap <leader>df :CocFix<cr>

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

let g:neoterm_automap_keys = '<Leader>tm'

nnoremap <silent> <Leader>tt :Ttoggle<cr>
nnoremap <silent> <Leader>tl :call neoterm#clear()<cr>
nnoremap <Leader>tl :<c-u>exec v:count.'Tclear'<cr>
nnoremap <Leader>tk :Tclose!
nnoremap <Leader>tn :T nix-shell<cr>

" REPL maps
nnoremap <silent> <Leader>tff :TREPLSendFile<cr>
nnoremap <silent> <Leader>tss :TREPLSendLine<cr>
nnoremap <silent> <Leader>ts :set opfunc=SendToNeoterm<CR>g@
vnoremap <silent> <Leader>ts :TREPLSendSelection<cr>

function! s:neoterm_extra_maps() abort
  " Don't add on these filetypes
  if &ft =~ 'clojure\|clojurescript\|sql\|scala\|fennel\|janet'
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
" VIM-QF {{{1
" ============================================================================

let g:qf_mapping_ack_style = 1

nmap <leader>x <Plug>(qf_qf_toggle)
nmap <leader>v <Plug>(qf_loc_toggle)

" VIM-QF


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

" Called in customAirline augroup
function! AirlineDB(...)
  if &filetype == 'sql'
    let w:airline_section_x = g:airline_section_x . '%{AirlineDBConnName()}'
  endif
endfunction


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

" xnoremap <Leader>a<space> :EasyAlign \ <cr>
" nmap <Leader>a<space> <Plug>(EasyAlign)ab <Nop>

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


let g:matchup_matchparen_deferred = 1
let g:matchup_matchparen_hi_surround_always = 1

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
let g:Hexokinase_ftEnabled = ['css', 'html' ]

" END HEXOKINASE

" ============================================================================
" CRATES
" ============================================================================

augroup crates_updates
  autocmd!
  autocmd BufRead Cargo.toml call crates#toggle()
  autocmd BufRead Cargo.toml map <buffer> <leader>ct :CratesToggle<cr>
  autocmd BufRead Cargo.toml map <buffer> <leader>cu :CratesUp<cr>
augroup END


" END CRATES

" ============================================================================
" PAGE https://github.com/I60R/page {{{1
" ============================================================================
augroup readonly_files
  autocmd!
  autocmd User PageOpen set norelativenumber
  autocmd User PageOpen AirlineToggle
  autocmd User PageOpen set showmode
  autocmd User PageOpen :mode
  autocmd User PageOpen exe 'map  <buffer> q :q<CR>'
  autocmd User PageOpen exe 'tmap  <buffer> q :q<CR>'
augroup END


" END PAGE


" ============================================================================
" LOCALVIMRC  {{{1
" ============================================================================

let g:localvimrc_ask = 0
let g:localvimrc_sandbox = 0

" END LOCALVIMRC

" ============================================================================
" SCALA {{{1
" ============================================================================

function! ScalaCustomSettings()
  " Toggle panel with Tree Views
  nnoremap <silent><buffer> <leader>dtt :<C-u>CocCommand metals.tvp<cr>
  " Toggle Tree View 'metalsBuild'
  nnoremap <silent><buffer> <leader>dtb :<C-u>CocCommand metals.tvp metalsBuild<cr>
  " Toggle Tree View 'metalsCompile'
  nnoremap <silent><buffer> <leader>dtc :<C-u>CocCommand metals.tvp metalsCompile<cr>
  " Reveal current current class (trait or object) in Tree View 'metalsBuild'
  nnoremap <silent><buffer> <leader>dtf :<C-u>CocCommand metals.revealInTreeView metalsBuild<cr>

  nnoremap <silent><buffer> <leader>dtn :<C-u>CocCommand metals.new-scala-file<cr>
  " Used to expand decorations in worksheets
  nmap <buffer> cpp <Plug>(coc-metals-expand-decoration)
endfunction


augroup scala_settings
  autocmd!
  " Configuration for vim-scala
  autocmd BufRead,BufNewFile *.sbt set filetype=scala
  autocmd FileType scala call ScalaCustomSettings()
augroup END

" END SCALA
