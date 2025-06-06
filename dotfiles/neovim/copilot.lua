require("copilot").setup({
  suggestion = { enabled = false },
  panel = { enabled = false },
})

require("copilot_cmp").setup()

require("codecompanion").setup({
  opts = {
    -- log_level = "DEBUG", -- or "TRACE"
  },
  strategies = {
    chat = {
      opts = {
        completion_provider = "cmp", -- blink|cmp|coc|default
      },
    },
  },
})
