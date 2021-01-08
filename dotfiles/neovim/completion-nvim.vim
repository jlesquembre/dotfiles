autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Limit the popup height
set pumheight=15

" Avoid showing extra message when using completion
" set shortmess+=c

let g:completion_matching_strategy_list = ['exact', 'substring']

let g:completion_confirm_key = ""
imap <expr> <cr> pumvisible() ? complete_info()["selected"] != "-1" ?
  \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

augroup CompletionTriggerCharacter
autocmd!
autocmd BufEnter * let g:completion_trigger_character = ['.']
autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']
autocmd BufEnter *.clj,*.cljs,*.cljc,*.bb let g:completion_trigger_character = ['.', ':']
augroup end

" let g:completion_enable_auto_signature = 1

let g:completion_auto_change_source = 0
let g:completion_matching_smart_case = 1
let g:completion_menu_length = 45
let g:completion_sorting = "none"
let g:completion_enable_auto_paren = 1

"vim.g.completion_auto_change_source = 0
"vim.g.completion_enable_snippet = "vim-vsnip"
"vim.g.completion_enable_auto_paren = 1
"vim.g.completion_items_priority = {
"  ["vim-vsnip"] = 0
"}
"vim.g.completion_matching_smart_case = 1
"vim.g.completion_menu_length = 45
"vim.g.completion_sorting = "none"
"vim.g.completion_matching_strategy_list = {
"  "exact",
"  "substring"
"}

imap  <c-j> <Plug>(completion_next_source)
imap  <c-k> <Plug>(completion_prev_source)

let g:completion_chain_complete_list = {
    \ 'default' : {
    \   'default': [
    \       {'complete_items': ['lsp', 'snippet']},
    \       {'complete_items': ['path']},
    \   ],
    \   'string': [ {'complete_items': ['path']}],
    \   'comment': []
    \   }
    \}
    " \       {'complete_items': ['ts']},
    " \       {'mode': '<c-p>'},
    " \       {'mode': '<c-n>'},
