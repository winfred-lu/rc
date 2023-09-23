return {
  {
    'rose-pine/neovim',
    lazy = true,
  },
  {
    'sainnhe/gruvbox-material',
    lazy = true,
  },
  {
    'rebelot/kanagawa.nvim',
    priority = 1000,
    opts = {
      colors = {
        palette = {
          fujiWhite = '#DCD7CA',
        },
      },
    },
    config = function(_, opts)
      local kanagawa = require("kanagawa")
      kanagawa.setup(opts)
      kanagawa.load()
    end,
  },
}

