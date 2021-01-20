local pConf = function ()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--prose-wrap always'},
    stdin = true
  }
end

local hclConf = function ()
  return {
    exe = "terraform",
    args = {"fmt", '-'},
    stdin = true
  }
end

require('formatter').setup({
  logging = false,
  filetype = {
    javascript = { pConf } ,
    typescript = { pConf } ,
    yaml = { pConf } ,
    json = {pConf} ,
    css = {pConf} ,
    scss = {pConf} ,
    html = {pConf} ,
    yaml = {pConf} ,
    markdown = {pConf} ,
    ["markdown.mdx"] = {pConf} ,

    tf = {hclConf},

    nix = {
      function()
        return {
          exe = "nixpkgs-fmt",
          stdin = true}
      end},

    rust = {
      function()
        return {
          exe = "rustfmt",
          args = {"--emit=stdout"},
          stdin = true}
      end},

}})

vim.api.nvim_exec([[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost * silent FormatWrite
augroup END
]], true)
