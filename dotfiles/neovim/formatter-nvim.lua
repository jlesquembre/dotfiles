local pConf = function ()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), '--single-quote'},
    stdin = true
  }
end

require('formatter').setup({
logging = false,
filetype = {
javascript = { pConf } ,
typescript = { pConf } ,
nix = {
  function()
    return {
      exe = "nixpkgs-fmt",
      stdin = true}

  end}
,
rust = {
  function()
    return {
      exe = "rustfmt",
      args = {"--emit=stdout"},
      stdin = true}

  end}
,

}})
