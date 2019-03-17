

function! myflog#quit()
  call s:delete_flog_term()
  call flog#quit()
endfunction

function! s:delete_flog_term()
  let l:state = flog#get_state()
  let l:termbufnr = get(l:state, 'termbufnr', 0)
  if l:termbufnr != 0
    execute('bdelete! ' . l:termbufnr)
  endif
  let l:state.termbufnr = 0
endfunction


function! myflog#diff_fancy(mods)
  " call flog#close_preview()

  let l:state = flog#get_state()
  call s:delete_flog_term()

  let l:previous_window_id = win_getid()
  let l:commit = flog#get_commit_data(line('.')).short_commit_hash
  " let l:dir = s:defx_directory_from_context(a:context)
  " execute 'vnew +set\ filetype=custom_term'
  execute 'vertical botright new +set\ filetype=flog_term_diff'
  " let l:term_winid = win_getid()
  " echo winbufnr(l:previous_window_id) . '  --> ' . winbufnr(l:term_winid)
  " execute 'autocmd TermClose <buffer='.winbufnr(l:term_winid).'> bdelete!'
  " execute 'botright vnew +set\ filetype=custom_term'
  setlocal nonumber norelativenumber
  " call termopen(flog#get_fugitive_git_command() . ' -p show ' . l:commit)
  " let l:termid = termopen('git show ' . l:commit, {'on_exit': 's:OnExit'})
  let l:state.termid = termopen(['git', 'show', l:commit]) ", {'on_exit': function('s:on_term_exit')})
  call cursor(line("$"), 1)
  " call chansend(l:state.termid, "G")
  " let l:termid = termopen('git show '. l:commit, {'on_exit': function('s:OnExit')})
  " call termopen('git show ' . l:commit, {'on_exit': 's:OnExit'})
  " let l:state.preview_window_ids += [win_getid()]
  let l:state.termbufnr = winbufnr(win_getid())
  " execute 'startinsert'

  call win_gotoid(l:previous_window_id)

endfunction


function! myflog#scroll_down()
  call s:scroll(1)
endfunction

function! myflog#scroll_up()
  call s:scroll(0)
endfunction

function s:scroll(goDown)
  let l:state = flog#get_state()
  try
    if (a:goDown)
      call chansend(l:state.termid, "j")
    else
      call chansend(l:state.termid, "k")
    endif
  catch /send data to closed stream/
      echo 'Channel closed'
  endtry

endfunction
