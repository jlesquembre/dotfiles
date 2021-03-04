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
    \ 'sexp_splice_list':               '<leader>-',
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
let g:conjure#mapping#eval_current_form = "PP"
let g:conjure#mapping#eval_root_form = "PR"
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
\   'java': [],
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
" \   'java'       : [ 'google_java_format' ],
" \   'java'       : [ 'uncrustify' ],

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
        \'coc-java',
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
