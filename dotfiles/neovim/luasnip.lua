local ls = require"luasnip"
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local events = require("luasnip.util.events")

-- -- Helper functions
function fname(ctx)
  return vim.fn.substitute(vim.fn.expand('%:p:t'), [[^\@<!\..*$]], '', '')
end

-- https://github.com/tpope/vim-abolish/blob/68bc80c88617672fd41da7a6ace87d29cd3fe1e3/plugin/abolish.vim#L149-L158
function abolish(s, case, ...)
  return vim.api.nvim_eval('g:Abolish.'.. case .. '("' .. s ..'")')
end

local date_input = function(args, state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return sn(nil, t(os.date(fmt)))
end


ls.add_snippets("all", {
 s("date", { d(1, date_input, {} ), }),
})

ls.add_snippets("clojure", {
 s("item", {
    t({'{:description "'}), i(1), t({'" ', ''}),
    t({' :amount '}), i(2), t({' ', ''}),
    t({' :tags #{'}), i(3), t({'}', ''}),
    t({' :date "'}), f(function() return os.date("%Y-%m-%d") end), t({'"}',''}),
  }),
})

local elementName = function()
  return sn(nil, i(1, fname()))
end

local className = function(args)
  return abolish(args[1][1], "mixedcase")
end

local interface = function(args)
  local name = args[1][1]
  return '"' .. name .. '": ' .. abolish(name, "mixedcase") .. ';'
end

ls.add_snippets("typescript", {
  s("lite", {
    t({'import { LitElement, html, css } from "lit";',
       'import { customElement, property } from "lit/decorators.js";',
       '@customElement("'
    }),
    d(1, elementName, {} ),
    t({'")', 'export class ', }),
    f(className, 1),
    t({' extends LitElement {',
      '  static styles = css`',
      '    :host {',
      '      display: block;',
      '    }',
      '  `;', '',
      '  render() {',
      '    return html`',
      '                <div>',
    }),
    i(0),
    t({
      '</div>', '',
      '`;',
      '  }',
      '}', '',
      'declare global {',
      '  interface HTMLElementTagNameMap {',
      '    ',
       }),
    f(interface, 1),
    t({'',
      '  }',
      '}'}),
  }),

  s("cons",{
    t({
     'constructor(){',
     '  super();', '  ',
    }),
    i(0),
    t({'', '  }',
    }),
  }),

})
