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
