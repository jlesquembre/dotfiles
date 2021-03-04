Plug 'dyng/ctrlsf.vim'
Plug 'nelstrom/vim-visual-star-search'
Plug 'michaeljsmith/vim-indent-object'

" Text edition
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
" Plug 'metakirby5/codi.vim'
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

call plug#end()




" VIM PLUGINS {{{
" ============================================================================

let g:htl_css_templates=1

let g:startify_change_to_vcs_root = 1
let g:startify_session_dir = '~/.config/nvim/session'

let g:rooter_silent_chdir = 1

" END PLUGINS





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
" CLOJURE {{{



function! EvalForms(scope)

  " execute "lua require('conjure.eval')['current-form']()"
  if a:scope == 'current'
    execute 'normal cPP'
  elseif a:scope == 'root'
    execute 'normal cPR'
  endif

  if getpos("'M")[2] != 0
    execute 'normal cpmM'
  elseif getpos("'m")[2] != 0
    execute 'normal cpmm'
  endif
endfunction

function! DeleteMark()
  echo 'Mark to delete?'
  let mark = nr2char(getchar())
  if match(mark, '\a') == -1
    echo 'Invalid mark'
  else
    execute 'delmarks ' . mark
  endif
endfunction

nnoremap <silent> dm :call DeleteMark()<cr>

function! LispCustomSettings()
  nnoremap cpp :call EvalForms('current')<cr>
  nnoremap cpr :call EvalForms('root')<cr>

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


augroup clojure
  autocmd!
  autocmd FileType lisp,clojure,scheme call LispCustomSettings()
  autocmd BufEnter conjure-log-* nnoremap <buffer><silent> <leader>q :lua require('conjure.log')['close-visible']()<CR>

augroup END


" END CLOJURE


" ============================================================================
" NEOTERM / CODI {{{1
" ============================================================================

let g:floaterm_shell = 'fish'
let g:floaterm_height = 0.85
let g:floaterm_width = 0.85

nnoremap <c-t><c-e> :FloatermNew --autoclose=2 ranger<cr>

nnoremap <c-t><c-t> :FloatermToggle<cr>
tnoremap <c-t><c-t> <cmd>FloatermToggle<cr>

tnoremap <c-t><c-k> <cmd>FloatermNext<cr>i
tnoremap <c-t><c-j> <cmd>FloatermPrev<cr>i

tnoremap <c-t><c-g> <cmd>FloatermUpdate --wintype=normal --height=0.5 --width=0.5 --position=right<cr>
tnoremap <c-t><c-f> <cmd>FloatermUpdate --wintype=floating  --height=0.85 --width=0.85 --position=center<cr>
nnoremap <c-t><c-g> <cmd>FloatermUpdate --wintype=normal<cr>
nnoremap <c-t><c-f> <cmd>FloatermUpdate --wintype=floating<cr>

nnoremap <c-t><c-s> :FloatermSend<cr>
" tnoremap <m-t><m-k> <c-o>:FloatermNext<cr>
" tnoremap <m-t><m-j> <c-o>:FloatermPrev<cr>
" nnoremap <c-t><c-f> :FloatermNew!  fzf --preview 'fzf_preview_all {}'<cr>
" nnoremap <c-t>e :FloatermNew --wintype=floating --name=floaterm1 --position=topleft --autoclose=2 ranger<cr>

" function! SetFloatermMappings()
"      tnoremap <buffer> <c-t> <cmd>let g:floaterm_open_command = 'tabedit' \| call feedkeys("l", "i")<cr>
"      tnoremap <buffer> <c-o> <cmd>let g:floaterm_open_command = 'edit'    \| call feedkeys("l", "i")<CR>
"      tnoremap <buffer> <c-v> <cmd>let g:floaterm_open_command = 'vsplit'  \| call feedkeys("l", "i")<CR>
"      tnoremap <buffer> <c-s> <cmd>let g:floaterm_open_command = 'splqit'  \| call feedkeys("l", "i")<CR>
" endfunction

" augroup floaterm_extra_maps
"   autocmd!
"   autocmd filetype floaterm call SetFloatermMappings()
" augroup END

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
