local sql = require("jlle.sql_utils")

require("lualine").setup({
  options = {
    icons_enabled = true,
    theme = "base16",
    -- component_separators = { left = '', right = ''},
    -- section_separators = { left = '', right = ' '},
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = {
      "encoding",
      "fileformat",
      "filetype",
      {
        sql.current_db,
        icon = "",
        cond = function()
          return vim.bo.filetype == "sql"
        end,
      },
    },
    lualine_y = { "progress" },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {
    lualine_a = {
      {
        "tabs",
        tab_max_length = 50, -- Maximum width of each tab. The content will be shorten dynamically (example: apple/orange -> a/orange)
        -- max_length = vim.o.columns / 3, -- Maximum width of tabs component.
        -- Note:
        -- It can also be a function that returns
        -- the value of `max_length` dynamically.
        mode = 2, -- 0: Shows tab_nr
        -- 1: Shows tab_name
        -- 2: Shows tab_nr + tab_name

        path = 0, -- 0: just shows the filename
        -- 1: shows the relative path and shorten $HOME to ~
        -- 2: shows the full path
        -- 3: shows the full path and shorten $HOME to ~

        -- Automatically updates active tab color to match color of other components (will be overidden if buffers_color is set)
        use_mode_colors = false,

        -- tabs_color = {
        --   -- Same values as the general color option can be used here.
        --   active = "lualine_{section}_normal", -- Color for active tab.
        --   inactive = "lualine_{section}_inactive", -- Color for inactive tab.
        -- },

        show_modified_status = true, -- Shows a symbol next to the tab name if the file has been modified.
        symbols = {
          modified = "[+]", -- Text to show when the file is modified.
        },

        fmt = function(name, context)
          -- Show + if buffer is modified in tab
          local buflist = vim.fn.tabpagebuflist(context.tabnr)
          local winnr = vim.fn.tabpagewinnr(context.tabnr)
          local bufnr = buflist[winnr]
          local mod = vim.fn.getbufvar(bufnr, "&mod")

          local countnr = #buflist <= 1 and "" or ("[" .. #buflist .. "] ")

          return countnr .. name .. (mod == 1 and " +" or "")
        end,
      },
    },
    -- lualine_a = { "buffers" },
    lualine_b = {},
    lualine_c = {},
    -- lualine_c = { "filename" },
    lualine_x = {},
    lualine_y = {},
    lualine_z = { "tabs" },
    -- lualine_z = {},
  },
  winbar = {},
  inactive_winbar = {},
  extensions = {},
})
