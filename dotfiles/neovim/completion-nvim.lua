-- see https://github.com/nvim-lua/completion-nvim/wiki/Customizing-LSP-label
-- for how to do this without completion-nvim
-- see https://github.com/akinsho/dotfiles/blob/main/.config/nvim/lua/as/plugins/completion.lua
vim.g.completion_customize_lsp_label = {
  Keyword = "\u{f1de}",
  Variable = "\u{e79b}",
  Value = "\u{f89f}",
  Operator = "\u{03a8}",
  Function = "\u{0192}",
  Reference = "\u{fa46}",
  Constant = "\u{f8fe}",
  Method = "\u{f09a}",
  Struct = "\u{fb44}",
  Class = "\u{f0e8}",
  Interface = "\u{f417}",
  Text = "\u{e612}",
  Enum = "\u{f435}",
  EnumMember = "\u{f02b}",
  Module = "\u{f40d}",
  Color = "\u{e22b}",
  Property = "\u{e624}",
  Field = "\u{f9be}",
  Unit = "\u{f475}",
  Event = "\u{facd}",
  File = "\u{f723}",
  Folder = "\u{f114}",
  TypeParameter = "\u{f728}",
  Default = "\u{f29c}",
  Buffers = "",
  Snippet = "",
  ["vim-vsnip"] = ""
}
