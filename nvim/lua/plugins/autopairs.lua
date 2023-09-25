local M = {
  "windwp/nvim-autopairs",
  event = "InsertEnter",

  opts = {
    check_ts = true,
    ts_config = {
      cpp = { "string_literal", "comment" },
      c = { "string_literal", "comment" },
      java = { "string", "comment" },
      python = { "string", "comment" },
      lua = { "string", "comment", "source" },
    },
    disable_filetype = { "TelescopePrompt" },
    fast_wrap = {
      map = "<M-p>",
      chars = { "{", "[", "(", '"', "'" },
      pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
      offset = 0,
      end_key = "$",
      keys = "asdfqwerzxcvgtbnmyuiophjkl",
      check_comma = true,
      highlight = "Search",
      highlight_grey = "Comment",
    },
  },
  config = function(_, opts)
    require("nvim-autopairs").setup(opts)

    -- insert '(' after select function or method item
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local ok, cmp = pcall(require, "cmp")
    if not ok then
      return
    end
    cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  end,
}

return M
