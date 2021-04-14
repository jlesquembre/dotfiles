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

" BASIC SETTINGS
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
set diffopt+=vertical
" set spell
" set spelllang=en_us
" set lazyredraw

" Better folds
"set foldcolumn=1
set foldmethod=marker
" set foldopen+=jump
" set shortmess-=F

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
set shada='1000,<500,s100,h,f0 " file saved at ~/.local/share/nvim
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
  autocmd BufEnter,FocusGained * if !bufexists("[Command Line]") | checktime | endif

  " The PC is fast enough, do syntax highlight syncing from start
  autocmd BufEnter * syntax sync fromstart

  " Only use cursorline for current window
  autocmd WinEnter,FocusGained * setlocal cursorline
  autocmd WinLeave,FocusLost   * setlocal nocursorline

  "TODO still needed?
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


" COLORSCHEMA
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

  call Base16hi("Reverse", "", "", "", "", "reverse", "reverse")

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

  call Base16hi("LspReferenceRead",     "", g:base16_gui02, "", "", "", "" )
  call Base16hi("LspReferenceWrite",     "", g:base16_gui02, "", "", "", "" )
  call Base16hi("LspReferenceText",     "", g:base16_gui02, "", "", "", "" )

endfunction

augroup on_change_colorschema
  autocmd!
  autocmd ColorScheme * call g:Base16_customize()
  autocmd TextYankPost * silent! lua vim.highlight.on_yank {higroup="Reverse", timeout=350}
augroup END

colorscheme base16-default-dark


" FUNCTIONS
" ============================================================================

" Show syntax highlighting groups for word under cursor
function! <SID>SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

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

" COMMANDS
" ============================================================================

" I never remember the StripWhitespace command
command! RemoveWhitespace execute "StripWhitespace"
command! DeleteWhitespace execute "StripWhitespace"

" Save as root
cnoreabbrev w!! silent execute "w !sudo tee % > /dev/null" \| e!

" Expand the Active File Directory
cnoremap <expr> %% getcmdtype() == ':' ? fnameescape(expand('%:h')) . '/' : '%%'

" Better replacement for cnoreabbrev
function SetAliases()
  execute 'Alias g Git'
  execute 'Alias gp Git\ pull\ --ff-only'
  execute 'Alias gs Git\ switch'
  execute 'Alias gsc Git\ switch\ --create'
  " Create parent directories
  execute 'Alias mk Mkdir!\ |\ update'

  execute 'Alias t FloatermNew'
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

" MAPPINGS
" ============================================================================

" Neovim terminal mapping
" terminal 'normal mode'
tnoremap <Esc> <C-\><C-n>
tnoremap <M-[> <C-\><C-n>
tnoremap <C-v><Esc> <Esc>

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

" Make yank more logical
map Y y$

nnoremap <leader>w <C-w>

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

" Saner behavior of n and N
nnoremap <expr> n 'Nn'[v:searchforward] . 'zv'
nnoremap <expr> N 'nN'[v:searchforward] . 'zv'

" Saner command-line history
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Saner CTRL-L
nnoremap <silent> <leader>l <cmd>nohlsearch<cr><cmd>diffupdate<cr><cmd>syntax sync fromstart<cr><c-l>

" Quick saving
nnoremap <silent> <Leader>s :update<CR>
" TODO add one for save an exit
inoremap <C-s> <C-o>:w<cr>

" Show syntax highlighting groups for word under cursor
nnoremap <F10> :call <SID>SynStack()<CR>

" neovim freezes if function keys are pressed
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
"
