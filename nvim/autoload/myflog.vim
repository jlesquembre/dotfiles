function! myflog#quit()
  call s:delete_flog_term()
  call flog#quit()
endfunction


function! myflog#close_term_preview()
  call s:delete_flog_term()
endfunction


function! s:delete_flog_term()
  let l:state = flog#get_state()
  let l:termbufnr = get(l:state, 'termbufnr', 0)
  if l:termbufnr
    execute('bdelete! ' . l:termbufnr)
  endif
  let l:state.termbufnr = 0
endfunction


function! myflog#diff_fancy()
  call flog#close_preview()

  let l:state = flog#get_state()
  call s:delete_flog_term()

  let l:previous_window_id = win_getid()
  let l:commit = flog#get_commit_data(line('.')).short_commit_hash
  execute 'vertical botright new +set\ filetype=flog_term_diff'
  setlocal nonumber norelativenumber
  let l:state.termid = termopen(['git', 'show', l:commit]) ", {'on_exit': function('s:on_term_exit')})
  " Output is followed only if the cursor is on the last line.
  call cursor(line("$"), 1)
  let l:state.termbufnr = winbufnr(win_getid())

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
    if a:goDown
      call chansend(l:state.termid, "j")
    else
      call chansend(l:state.termid, "k")
    endif
  catch /send data to closed stream/
      echo 'Channel closed'
  endtry

endfunction


function! myflog#preview_next_commit() abort
  let l:state = flog#get_state()
  let l:termbufnr = get(l:state, 'termbufnr', 0)
  if l:termbufnr
    call flog#jump_commits(v:count1)
    call myflog#diff_fancy()
  else
    call flog#next_commit() | vertical belowright Flogsplitcommit
  endif
endfunction


function! myflog#preview_prev_commit() abort
  let l:state = flog#get_state()
  let l:termbufnr = get(l:state, 'termbufnr', 0)
  if l:termbufnr
    call flog#jump_commits(-v:count1)
    call myflog#diff_fancy()
  else
    call flog#previous_commit() | vertical belowright Flogsplitcommit
  endif
endfunction
