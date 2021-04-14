local gl = require('galaxyline')
local gls = gl.section
gl.short_line_list = {'LuaTree','vista','dbui'}

local colors = {
  bg = '#282c34',
  line_bg = '#353644',
  fg = '#8FBCBB',
  fg_green = '#65a380',

  yellow = '#fabd2f',
  cyan = '#008080',
  darkblue = '#081633',
  green = '#afd700',
  orange = '#FF8800',
  purple = '#5d4d7a',
  magenta = '#c678dd',
  blue = '#51afef';
  red = '#ec5f67'
}

local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand('%:t')) ~= 1 then
    return true
  end
  return false
end

local term_name = function()
  if vim.b.nterm_name == nil then
    return false
  end
  return vim.b.nterm_name
end

local git_project = require('galaxyline.provider_vcs').check_git_workspace

local checkwidth = function()
  local squeeze_width  = vim.fn.winwidth(0) / 2
  if squeeze_width > 40 then
    return true
  end
  return false
end

gls.left = {
{
  FirstElement = {
    provider = function() return '▊ ' end,
    highlight = {colors.blue,colors.line_bg}
  },
},
{
  ViMode = {
    provider = function()
      -- auto change color according the vim mode
      local mode_color = {
        n = colors.magenta,
        i = colors.green,
        v = colors.blue,
        [''] = colors.blue,
        V = colors.blue,
        c = colors.red,
        no = colors.magenta,
        s = colors.orange,
        S=colors.orange,
        [''] = colors.orange,
        ic = colors.yellow,
        R = colors.purple,
        Rv = colors.purple,
        cv = colors.red,
        cel= colors.red,
        r = colors.cyan,
        rm = colors.cyan,
        ['r?'] = colors.cyan,
        ['!']  = colors.red,
        t = colors.green,
      }
      vim.api.nvim_command('hi GalaxyViMode guibg='..mode_color[vim.fn.mode()])
      local alias = {
          n = 'NORMAL',
          i = 'INSERT',
          c = 'COMMAND',
          v = 'VISUAL',
          [''] = 'VISUAL BLK',
          t = 'TERM',
        }
      return alias[vim.fn.mode()] or vim.fn.mode()
    end,
    separator = ' ',
    highlight = {colors.bg,colors.line_fg,'bold'},
    separator_highlight = {colors.fg, colors.line_bg},
  },
},
{
  FileIcon = {
    provider = 'FileIcon',
    condition = buffer_not_empty,
    highlight = {require('galaxyline.provider_fileinfo').get_file_icon_color,colors.line_bg},
  },
},
{
  FileName = {
    provider = {'FileName','FileSize'},
    condition = function() return buffer_not_empty() and (not term_name()) end ,
    -- condition = function() return buffer_not_empty() and git_project() end,
    highlight = {colors.fg,colors.line_bg,'bold'},
    -- separator = '',
    -- separator_highlight = {colors.purple,colors.line_bg},
  }
},
{
  TermName = {
    provider = function() return "NTERM: " .. term_name() end,
    condition = term_name,
    highlight = {colors.fg,colors.line_bg,'bold'},
  }
},
{
  Separator = {
    provider = function() return '' end,
    condition = git_project,
    highlight = {colors.purple,colors.line_bg},
  }
},
{
  GitIcon = {
    provider = function() return '   ' end,
    condition = git_project,
    highlight = {colors.line_fg,colors.purple},
  }
},
{
  GitBranch = {
    provider = 'GitBranch',
    condition = git_project,
    separator = ' ',
    highlight = {colors.fg,colors.purple,'bold'},
    separator_highlight = {colors.purple,colors.line_bg},
  }
},

{
  DiffAdd = {
    provider = 'DiffAdd',
    condition = checkwidth,
    icon = '',
    highlight = {colors.green,colors.line_bg},
  }
},
{
  DiffModified = {
    provider = 'DiffModified',
    condition = checkwidth,
    icon = '~',
    highlight = {colors.orange,colors.line_bg,'bold'},
  }
},
{
  DiffRemove = {
    provider = 'DiffRemove',
    condition = checkwidth,
    icon = '',
    highlight = {colors.red,colors.line_bg},
  }
},
{
  LeftEnd = {
    provider = function() return '' end,
    separator = '',
    separator_highlight = {colors.bg,colors.line_bg},
    highlight = {colors.line_bg,colors.line_bg}
  }
},
{
  DiagnosticError = {
    provider = 'DiagnosticError',
    -- icon = '  ',
    -- icon = '  ',
    icon = '  ',
    separator = ' ',
    highlight = {colors.red,colors.bg},
    separator_highlight = {colors.line_bg,colors.bg},
  }
},
{
  DiagnosticWarn = {
    provider = 'DiagnosticWarn',
    icon = '  ',
    -- icon = '  ',
    highlight = {colors.orange,colors.bg},
  }
}
}
gls.right[1]= {
  FileFormat = {
    provider = 'FileFormat',
    separator = ' ',
    separator_highlight = {colors.bg,colors.line_bg},
    highlight = {colors.fg,colors.line_bg,'bold'},
  }
}
gls.right[2] = {
  LineInfo = {
    provider = 'LineColumn',
    separator = ' | ',
    separator_highlight = {colors.blue,colors.line_bg},
    highlight = {colors.fg,colors.line_bg},
  },
}
gls.right[3] = {
  PerCent = {
    provider = 'LinePercent',
    separator = ' ',
    separator_highlight = {colors.line_bg,colors.line_bg},
    highlight = {colors.cyan,colors.darkblue,'bold'},
  }
}
gls.right[4] = {
  ScrollBar = {
    provider = 'ScrollBar',
    highlight = {colors.blue,colors.purple},
  }
}

gls.short_line_left[1] = {
  BufferType = {
    provider = 'FileTypeName',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.fg,colors.purple}
  }
}
gls.short_line_left[2] = {
  FileName = {
    provider = {'FileName','FileSize'},
    condition = function() return buffer_not_empty() and (not term_name()) end ,
    highlight = {colors.fg,colors.line_bg,'bold'},
    separator_highlight = {colors.purple,colors.line_bg},
  }
}

gls.short_line_left[3] = {
  TermNameLeft = {
    provider = term_name,
    condition = term_name,
    highlight = {colors.fg,colors.line_bg,'bold'},
    separator_highlight = {colors.purple,colors.line_bg},
    -- highlight = {colors.fg,colors.line_bg,'bold'},
    -- separator_highlight = {colors.purple,colors.line_bg},
  }
}


gls.short_line_right[1] = {
  BufferIcon = {
    provider= 'BufferIcon',
    separator = '',
    separator_highlight = {colors.purple,colors.bg},
    highlight = {colors.fg,colors.purple}
  }
}
