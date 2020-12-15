autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

let g:completion_confirm_key = ""

imap <expr> <cr> pumvisible() ? complete_info()["selected"] != "-1" ?
  \ "\<Plug>(completion_confirm_completion)"  : "\<c-e>\<CR>" :  "\<CR>"

augroup CompletionTriggerCharacter
autocmd!
autocmd BufEnter * let g:completion_trigger_character = ['.']
autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::']
autocmd BufEnter *.clj,*.cljs,*.cljc,*.bb let g:completion_trigger_character = ['.', ':']
augroup end

let g:completion_timer_cycle = 200 "default value is 80

imap  <c-j> <Plug>(completion_next_source)
imap  <c-k> <Plug>(completion_prev_source)
let g:completion_chain_complete_list = {
    \'comment': [],
    \'default' : [
    \    {'complete_items': ['lsp', 'snippet','ts', 'path']},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
    \}
