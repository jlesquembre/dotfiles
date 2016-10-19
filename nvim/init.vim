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


" ============================================================================
" Plugins (administrated by Plug) {{{
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

"Plug 'ryanoasis/vim-devicons'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Navigation
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-vinegar'
Plug 'Shougo/vimfiler.vim' | Plug 'Shougo/unite.vim'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'


" Text edition
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
"gorkunov/smartpairs.vim
"Plug 'cohama/lexima.vim'
Plug 'jiangmiao/auto-pairs'
" https://github.com/Raimondi/delimitMate ???
Plug 'tpope/vim-jdaddy'
Plug 'tpope/vim-endwise'
Plug 'ntpeters/vim-better-whitespace'


" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Yggdroot/indentLine'
Plug 'ap/vim-css-color'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/CursorLineCurrentWindow'


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
Plug 'mitsuhiko/vim-python-combined'
"Plug 'elzr/vim-json'
"PLug 'evanmiller/nginx-vim-syntax'
"PLug 'kurayama/systemd-vim-syntax'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'rust-lang/rust.vim'
"PLug 'wting/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'  " Typescript

" General utils
Plug 'tpope/vim-dispatch'
Plug 'radenling/vim-dispatch-neovim'
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


" }}} END Plugins


" ============================================================================
" BASIC SETTINGS {{{
" ============================================================================


set termguicolors
"let base16colorspace = 256
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

colorscheme base16-default-dark
"colorscheme onedark

set shell=bash  " many plugins expect bash
set relativenumber
set number
set noshowmode
set showcmd                     " display incomplete commands
set cursorline
set clipboard=unnamedplus  " Use "+ register

set splitbelow
set splitright

let mapleader="\<SPACE>"
let maplocalleader="\<SPACE>"


" Backups {{{

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

" }}}


" Make sure you dont change logfiles
augroup readonly_files
    au BufNewFile,BufRead /var/log/* set readonly
    au BufNewFile,BufRead /var/log/* set nomodifiable
augroup END


" Set augroup
augroup MyAutoCmd
  autocmd!
augroup END

autocmd MyAutoCmd FileType help wincmd K

" }}} BASIC SETTINGS

" ============================================================================
" MAPPINGS {{{
" ============================================================================

noremap <Leader><Space> :noh<CR>
nnoremap Y y$

" Neovim terminal mapping
" terminal 'normal mode'
tmap <esc> <c-\><c-n><esc><cr>

" give it a try and you will like it
" nnoremap ; :
" nnoremap : ;


nnoremap <leader>d "_d
vnoremap <leader>d "_d
"map <esc> :noh<cr>

" Fast window moves
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Save as root
"cmap w!! w !sudo tee % >/dev/null<CR>:e!<CR><CR>
cabbrev w!! silent execute "w !sudo tee % > /dev/null" \| e!
"command! Sudow execute "w !sudo tee > /dev/null %"

" Quick saving
nmap <silent> <Leader>w :update<CR>

" }}} MAPPINGS


" ============================================================================
" GREPPER {{{
" ============================================================================

"nnoremap <leader>G :Grepper -tool git<cr>
nnoremap <leader>g :Grepper -tool rg<cr>
"nmap gs <plug>(GrepperOperator)
"xmap gs <plug>(GrepperOperator)

" }}}



" ============================================================================
" FZF {{{
" ============================================================================

" File preview using Pygments
let g:fzf_files_options = '--preview "pygmentize -O style=monokai -f console256 -g {} | head -'.&lines.'"'

nnoremap <silent> <Leader>p :GFiles<CR>
nnoremap <silent> <Leader>P :Files<CR>
nnoremap <silent> <Leader>C        :Colors<CR>
nnoremap <silent> <Leader><Enter>  :Buffers<CR>
nnoremap <silent> <Leader>ag       :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG       :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag       y:Ag <C-R>"<CR>
nnoremap <silent> <Leader>`        :Marks<CR>
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

command! Plugs call fzf#run({
  \ 'source':  map(sort(keys(g:plugs)), 'g:plug_home."/".v:val'),
  \ 'options': '--delimiter / --nth -1',
  \ 'down':    '~30%',
  \ 'sink':    'VimFiler'})

autocmd MyAutoCmd FileType fzf setlocal nocursorline

" }}}


" ============================================================================
" Airline {{{
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

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

let g:airline_symbols.maxlinenr = ''


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



" ============================================================================
" Vimfiler {{{
" ============================================================================
"nmap <buffer> - :VimFilerBufferDir<CR>
nmap - :VimFilerBufferDir<CR>
nmap <Leader>- :VimFilerExplorer<CR>

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

autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() abort "{{{

  setlocal cursorline
  let w:persistent_cursorline = 1  " For compat with CursorLineCurrentWindow
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

endfunction   "}}}


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


" }}}


let g:startify_change_to_vcs_root = 1


" Window chooser
" let winnr = unite#helper#choose_window()
" call vimfiler#util#winmove(winnr)
