-- Conjure
local M = {}

vim.g['conjure#log#wrap'] = true

vim.g['conjure#mapping#prefix'] = "c"
vim.g['conjure#mapping#log_jump_to_latest'] = "lg"
vim.g['conjure#mapping#log_split'] = "lx"
vim.g['conjure#mapping#log_vsplit'] = "lv"
vim.g['conjure#mapping#log_toggle'] = "ll"
vim.g['conjure#mapping#log_tab'] = "lt"
vim.g['conjure#mapping#log_close_visible'] = "lq"
-- vim.g['conjure#mapping#eval_current_form'] = "PP"
-- vim.g['conjure#mapping#eval_root_form'] = "PR"
vim.g['conjure#log#botright'] = true
vim.g['conjure#mapping#eval_current_form'] = "pp"
vim.g['conjure#mapping#eval_root_form'] = "pr"
vim.g['conjure#mapping#eval_replace_form'] = "p!"
vim.g['conjure#mapping#eval_marked_form'] = "pm"
vim.g['conjure#mapping#eval_word'] = "pw"
vim.g['conjure#mapping#eval_file'] = "pf"
vim.g['conjure#mapping#eval_buf'] = "pb"
vim.g['conjure#mapping#eval_visual'] = "p"
vim.g['conjure#mapping#eval_motion'] = "m"
-- vim.g['conjure#mapping#doc_word'] = ["K"]
-- vim.g['conjure#mapping#def_word'] = ["gd"]
vim.g['conjure#mapping#eval_comment_current_form'] = "pcc"
vim.g['conjure#mapping#eval_comment_root_form'] = "pcr"

-- vim.g['conjure#client#clojure#nrepl#mapping#disconnect'] = "cd"
vim.g['conjure#client#clojure#nrepl#mapping#connect_port_file'] = "u"
vim.g['conjure#client#clojure#nrepl#mapping#interrupt'] = "ui"
-- vim.g['conjure#client#clojure#nrepl#mapping#last_exception'] = "ve"
-- vim.g['conjure#client#clojure#nrepl#mapping#result_1'] = "v1"
-- vim.g['conjure#client#clojure#nrepl#mapping#result_2'] = "v2"
-- vim.g['conjure#client#clojure#nrepl#mapping#result_3'] = "v3"
-- vim.g['conjure#client#clojure#nrepl#mapping#view_source'] = "vs"
-- vim.g['conjure#client#clojure#nrepl#mapping#session_clone'] = "sc"
-- vim.g['conjure#client#clojure#nrepl#mapping#session_fresh'] = "sf"
-- vim.g['conjure#client#clojure#nrepl#mapping#session_close'] = "sq"
-- vim.g['conjure#client#clojure#nrepl#mapping#session_close_all'] = "sQ"
-- vim.g['conjure#client#clojure#nrepl#mapping#session_list'] = "sl"
-- vim.g['conjure#client#clojure#nrepl#mapping#session_next'] = "sn"
-- vim.g['conjure#client#clojure#nrepl#mapping#session_prev'] = "sp"
-- vim.g['conjure#client#clojure#nrepl#mapping#session_select'] = "ss"
vim.g['conjure#client#clojure#nrepl#mapping#run_all_tests'] = "pta"
vim.g['conjure#client#clojure#nrepl#mapping#run_current_ns_tests'] = "ptt"
vim.g['conjure#client#clojure#nrepl#mapping#run_alternate_ns_tests'] = "ptN"
vim.g['conjure#client#clojure#nrepl#mapping#run_current_test'] = "ptc"
-- let g:conjure#client#clojure#nrepl#mapping#refresh_changed = "rr"
-- let g:conjure#client#clojure#nrepl#mapping#refresh_all = "ra"
-- let g:conjure#client#clojure#nrepl#mapping#refresh_clear = "rc"
--
-- vim.g['conjure#client#fennel#aniseed#aniseed_module_prefix'] = "aniseed."
vim.g['conjure#log#strip_ansi_escape_sequences_line_limit'] = 0
-- Depends on https://github.com/jlesquembre/clj-dev-utils/blob/2770bbbd8eb14b60369510107098040b3e9c0ca6/src/local_utils.clj#L139
vim.g['conjure#client#clojure#nrepl#refresh#after'] = "local-utils/reload-system"

local baleia = require('baleia').setup { line_starts_at = 3 }

function lisp_settings(args)
  local bufnr = args.buf
  local set_keymap = vim.api.nvim_buf_set_keymap
  local opts = {noremap = true, silent = true}

  set_keymap(bufnr, 'i', '"',    '<Plug>(sexp_insert_double_quote)', {})
  set_keymap(bufnr, 'i', '<BS>', '<Plug>(sexp_insert_backspace)', {})

  set_keymap(bufnr, 'n', '<leader>a', '>I<cr>', {})
  set_keymap(bufnr, 'n', '<leader>i', '<I<del><cr><up>', {})

  set_keymap(bufnr, 'n', 'saf', '<Plug>(operator-sandwich-add)if(', {})
  set_keymap(bufnr, 'n', 'sar', '<Plug>(operator-sandwich-add)if[', {})
  set_keymap(bufnr, 'n', 'sav', '<Plug>(operator-sandwich-add)if{', {})
  set_keymap(bufnr, 'n', 'saj', '<Plug>(operator-sandwich-add)ie(', {})
  set_keymap(bufnr, 'n', 'sau', '<Plug>(operator-sandwich-add)ie[', {})
  set_keymap(bufnr, 'n', 'sam', '<Plug>(operator-sandwich-add)ie{', {})

  set_keymap(bufnr, 'n', '<c-n>', '<cmd>ParinferToggleMode<cr>', {})
  set_keymap(bufnr, 'i', '<c-n>', '<cmd>ParinferToggleMode<cr>', {})
  set_keymap(bufnr, 'v', '<c-n>', '<cmd>ParinferToggleMode<cr>', {})
  set_keymap(bufnr, 'n', '<leader>cn', '<cmd>ParinferToggleMode<cr>', {})
end


M.lisp_langs = {"clojure"," scheme", "lisp", "racket", "hy", "fennel", "janet", "carp", "wast", "yuck"}

vim.api.nvim_create_autocmd("FileType", {
  pattern = M.lisp_langs,
  callback = lisp_settings,
})
vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "conjure-log-*",
  callback = function(args) baleia.automatically(args.buf) end,
})

-- S-exp

vim.g.sexp_enable_insert_mode_mappings = 0
vim.g.sexp_insert_after_wrap = 0
vim.g.clojure_align_multiline_strings = 1

vim.g.sexp_mappings = {
  sexp_outer_list =                'af',
  sexp_inner_list =                'if',
  sexp_outer_top_list =            'ar',
  sexp_inner_top_list =            'ir',
  sexp_outer_string =              'as',
  sexp_inner_string =              'is',
  sexp_outer_element =             'ae',
  sexp_inner_element =             'ie',
  sexp_move_to_prev_bracket =      '<M-f>',
  sexp_move_to_next_bracket =      '<M-v>',
  sexp_move_to_prev_element_head = '',
  sexp_move_to_next_element_head = '',
  sexp_move_to_prev_element_tail = '',
  sexp_move_to_next_element_tail = '',
  sexp_flow_to_prev_open =         '(',
  sexp_flow_to_next_open =         ')',
  sexp_flow_to_prev_close =        '',
  sexp_flow_to_next_close =        '',
  sexp_flow_to_prev_leaf_head =    'b',
  sexp_flow_to_next_leaf_head =    'w',
  sexp_flow_to_prev_leaf_tail =    'ge',
  sexp_flow_to_next_leaf_tail =    'e',
  sexp_move_to_prev_top_element =  '[[',
  sexp_move_to_next_top_element =  ']]',
  sexp_select_prev_element =       '[v',
  sexp_select_next_element =       ']v',
  sexp_indent =                    '==',
  sexp_indent_top =                '=-',
  sexp_round_head_wrap_list =      '',
  sexp_round_tail_wrap_list =      '',
  sexp_square_head_wrap_list =     '',
  sexp_square_tail_wrap_list =     '',
  sexp_curly_head_wrap_list =      '',
  sexp_curly_tail_wrap_list =      '',
  sexp_round_head_wrap_element =   '',
  sexp_round_tail_wrap_element =   '',
  sexp_square_head_wrap_element =  '',
  sexp_square_tail_wrap_element =  '',
  sexp_curly_head_wrap_element =   '',
  sexp_curly_tail_wrap_element =   '',
  sexp_insert_at_list_head =       '',
  sexp_insert_at_list_tail =       '',
  sexp_splice_list =               '<leader>-',
  sexp_convolute =                 '<leader>?',
  sexp_raise_list =                '<leader>o',
  sexp_raise_element =             '<leader>O',
  sexp_swap_list_backward =        '',
  sexp_swap_list_forward =         '',
  sexp_swap_element_backward =     '',
  sexp_swap_element_forward =      '',
  sexp_emit_head_element =         '',
  sexp_emit_tail_element =         '',
  sexp_capture_prev_element =      '',
  sexp_capture_next_element =      '',
}

return M
