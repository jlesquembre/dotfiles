let g:loaded_netrwPlugin = 1 " Disable netrw.vim
let g:fern#disable_default_mappings = 1
" let g:fern#renderer = "nerdfont"

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
  nmap <buffer> H <Plug>(fern-action-hidden:toggle)
  nmap <buffer> R <Plug>(fern-action-rename)
  nmap <buffer> M <Plug>(fern-action-move)
  nmap <buffer> C <Plug>(fern-action-copy)
  nmap <buffer><nowait> r <Plug>(fern-action-reload)
  nmap <buffer><nowait> m <Plug>(fern-action-mark:toggle)j
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
