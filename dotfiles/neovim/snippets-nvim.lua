local snippets = require'snippets'
local U = require'snippets.utils'
-- require'snippets'.set_ux(require'snippets.inserters.vim_input')
-- require'snippets'.set_ux(require'snippets.inserters.floaty')
-- require'snippets'.set_ux(require'snippets.inserters.skeleton')
require'snippets'.set_ux(require'snippets.inserters.text_markers')


-- Helper functions
function fname(ctx)
  return vim.fn.substitute(vim.fn.expand('%:p:t'), [[^\@<!\..*$]], '', '')
end


-- https://github.com/tpope/vim-abolish/blob/68bc80c88617672fd41da7a6ace87d29cd3fe1e3/plugin/abolish.vim#L149-L158
function abolish(s, case, ...)
  return vim.api.nvim_eval('g:Abolish.'.. case .. '("' .. s ..'")')
end


-- require'snippets'.use_suggested_mappings()

-- NOTE
-- Functions called by snippets.nvim get the context as the first argument
require'snippets'.snippets = {
  _global = {
    todo = U.force_comment "TODO ";
    uname = function() return vim.loop.os_uname().sysname end;
    date = function () return os.date() end;
    -- note = [[NOTE(${1=io.popen("id -un"):read"*l"}): ]];
  };
  typescript = {

    lite = [[
import { customElement, property, LitElement, html, css } from "lit-element";

@customElement("${1=fname}")
export class ${|abolish(S[1],"mixedcase")} extends LitElement {
  static styles = css`
    :host {
      display: block;
    }
  `;

  render() {
    return html`$0`;
  }
}
]];

    cons = U.match_indentation[[
constructor(){
  super();
  $0
}]];

  prop = U.match_indentation[[
@property()
$0]];
  };

}
