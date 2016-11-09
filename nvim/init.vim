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
"Plug 'chriskempson/base16-vim'
Plug 'jlesquembre/base16-neovim'
Plug 'mhartington/oceanic-next'
Plug 'junegunn/seoul256.vim'
Plug 'rakr/vim-one'
Plug 'joshdick/onedark.vim'
Plug 'MaxSt/FlatColor'
Plug 'KabbAmine/yowish.vim'
Plug 'mhinz/vim-janah'


"Plug 'ryanoasis/vim-devicons'
"Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Navigation
Plug 'tpope/vim-repeat'
"Plug 'tpope/vim-vinegar'
Plug 'Shougo/vimfiler.vim' | Plug 'Shougo/unite.vim'
Plug 'tpope/vim-unimpaired'
Plug 'junegunn/fzf' | Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-grepper'
"Plug 'justinmk/vim-sneak'
Plug 'easymotion/vim-easymotion'
Plug 'takac/vim-hardtime'


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
Plug 'tpope/vim-speeddating'


" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
"Plug 'Yggdroot/indentLine'
Plug 'mhinz/vim-startify'
Plug 'vim-scripts/CursorLineCurrentWindow'
Plug 'mhinz/vim-halo'
Plug 'haya14busa/vim-operator-flashy' | Plug 'kana/vim-operator-user'


" Git
Plug 'tpope/vim-fugitive'
Plug 'jreybert/vimagit'
Plug 'airblade/vim-gitgutter'
Plug 'int3/vim-extradite'


" Syntax
Plug 'tpope/vim-markdown'
Plug 'aliva/vim-fish'
Plug 'stephpy/vim-yaml'
Plug 'mustache/vim-mustache-handlebars'
"Plug 'mitsuhiko/vim-python-combined'
"Plug 'elzr/vim-json'
"PLug 'evanmiller/nginx-vim-syntax'
"PLug 'kurayama/systemd-vim-syntax'
Plug 'Matt-Deacalion/vim-systemd-syntax'
Plug 'rust-lang/rust.vim'
"PLug 'wting/rust.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'HerringtonDarkholme/yats.vim'  " Typescript
"Plug 'LaTeX-Box-Team/LaTeX-Box', {'for': 'tex'}
Plug 'lervag/vimtex', {'for': 'tex'}

Plug 'ap/vim-css-color'  " Needs to be loaded AFTER the syntax

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


" END Plugins


" ============================================================================
" BASIC SETTINGS {{{1
" ============================================================================


set termguicolors
"let base16colorspace = 256
let $NVIM_TUI_ENABLE_CURSOR_SHAPE = 1

colorscheme base16-default-dark
"colorscheme onedark

" The fish shell is not very compatible to other shells and unexpectedly
" breaks things that use 'shell'.
if &shell =~# 'fish$'
  set shell=/bin/bash
endif

set relativenumber
set number
set tildeop
set ignorecase
set smartcase
set noshowmode
set showcmd                     " display incomplete commands
set cursorline
set clipboard=unnamedplus  " Use "+ register

" Better folds
set foldcolumn=1
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
    au BufNewFile,BufRead /var/log/* set readonly
    au BufNewFile,BufRead /var/log/* set nomodifiable
augroup END


" Set augroup
augroup MyAutoCmd
  autocmd!
augroup END

autocmd MyAutoCmd FileType help wincmd K

" Help NeoVim check for modified files: https://github.com/neovim/neovim/issues/2127
autocmd BufEnter,FocusGained * checktime

" The PC is fast enough, do syntax highlight syncing from start
autocmd BufEnter * :syntax sync fromstart

" END BASIC SETTINGS


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
tmap <esc> <c-\><c-n><esc><cr>

" give it a try and you will like it
" nnoremap ; :
" nnoremap : ;

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

" Saner behavior of n and N
nnoremap <silent><expr> n 'Nn'[v:searchforward] . 'zv:call halo#run()<cr>'
nnoremap <silent><expr> N 'nN'[v:searchforward] . 'zv:call halo#run()<cr>'

" Saner command-line history
cnoremap <c-n>  <down>
cnoremap <c-p>  <up>

" Saner CTRL-L
nnoremap <leader>l :nohlsearch<cr>:call clearmatches()<cr>:diffupdate<cr>:syntax sync fromstart<cr><c-l>
" TODO remove clearmatches when this is fixed:
" https://github.com/mhinz/vim-halo/issues/2

" Quick saving
nnoremap <silent> <Leader>w :update<CR>

" Show syntax highlighting groups for word under cursor
nnoremap <F10> :call <SID>SynStack()<CR>

" END MAPPINGS


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
omap uu <Plug>(easymotion-bd-f)

" f
nmap sf <Plug>(easymotion-f)
xmap sf <Plug>(easymotion-f)
omap uf <Plug>(easymotion-f)

" F
nmap sF <Plug>(easymotion-F)
xmap sF <Plug>(easymotion-F)
omap uF <Plug>(easymotion-F)

" t
nmap st <Plug>(easymotion-t)
xmap st <Plug>(easymotion-t)
omap ut <Plug>(easymotion-t)

" T
nmap sT <Plug>(easymotion-T)
xmap sT <Plug>(easymotion-T)
omap uT <Plug>(easymotion-T)

" w
nmap sw <Plug>(easymotion-w)
xmap sw <Plug>(easymotion-w)
omap uw <Plug>(easymotion-w)

" W
nmap sW <Plug>(easymotion-W)
xmap sW <Plug>(easymotion-W)
omap uW <Plug>(easymotion-W)

" b
nmap sb <Plug>(easymotion-b)
xmap sb <Plug>(easymotion-b)
omap ub <Plug>(easymotion-b)

" B
nmap sB <Plug>(easymotion-B)
xmap sB <Plug>(easymotion-B)
omap uB <Plug>(easymotion-B)

" e
nmap se <Plug>(easymotion-e)
xmap se <Plug>(easymotion-e)
omap ue <Plug>(easymotion-e)

" E
nmap sE <Plug>(easymotion-E)
xmap sE <Plug>(easymotion-E)
omap uE <Plug>(easymotion-E)

" ge
nmap sge <Plug>(easymotion-ge)
xmap sge <Plug>(easymotion-ge)
omap uge <Plug>(easymotion-ge)

" gE
nmap sgE <Plug>(easymotion-gE)
xmap sgE <Plug>(easymotion-gE)
omap ugE <Plug>(easymotion-gE)

" j
nmap sj <Plug>(easymotion-j)
xmap sj <Plug>(easymotion-j)
omap uj <Plug>(easymotion-j)

" k
nmap sk <Plug>(easymotion-k)
xmap sk <Plug>(easymotion-k)
omap uk <Plug>(easymotion-k)

" n
nmap sn <Plug>(easymotion-n)
xmap sn <Plug>(easymotion-n)
omap un <Plug>(easymotion-n)

" N
nmap sN <Plug>(easymotion-N)
xmap sN <Plug>(easymotion-N)
omap uN <Plug>(easymotion-N)

map  s/ <Plug>(easymotion-sn)
omap u/ <Plug>(easymotion-tn)

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
nnoremap <leader>gp :Gpush<CR>
"nnoremap <leader>gr :Git reset -q -- %<CR>

" END FUGITIVE


" ============================================================================
" GREPPER {{{1
" ============================================================================

let g:grepper = {
    \ 'tools': ['rg_extra', 'rg', 'git', 'grep'],
    \ 'highlight': 0,
    \ 'rg_extra':
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

" File preview using Pygments
let g:fzf_files_options = '--preview "file -ib {} | rg binary; or pygmentize -O style=monokai -f console256 -g {} | head -'.&lines.'"'

nnoremap <silent> <Leader>f       :FilesRg<CR>
nnoremap <silent> <Leader>ff      :FilesRg<CR>
nnoremap <silent> <Leader>fg      :GFiles<CR>
nnoremap <silent> <Leader>fc      :Colors<CR>
nnoremap <silent> <Leader><Enter> :Buffers<CR>
nnoremap <silent> <Leader>frg     :Find <C-R><C-W>
xnoremap <silent> <Leader>frg     y:Find <C-R>"<CR>
nnoremap <silent> <Leader>ag      :Ag <C-R><C-W><CR>
nnoremap <silent> <Leader>AG      :Ag <C-R><C-A><CR>
xnoremap <silent> <Leader>ag      y:Ag <C-R>"<CR>
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

autocmd MyAutoCmd FileType fzf setlocal nocursorline

" END FZF


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

autocmd MyAutoCmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings() abort

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

let g:startify_change_to_vcs_root = 1

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
" OPERATOR FLASHY {{{1
" ============================================================================

map y <Plug>(operator-flashy)
nmap Y <Plug>(operator-flashy)$

" END OPERATOR FLASHY
