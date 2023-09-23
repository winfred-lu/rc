M = {
  'phaazon/hop.nvim',
  event = "VeryLazy",
  keys = {
    { "<leader>l", "<cmd>HopLine<cr>" },
    { "<leader>w", "<cmd>HopWord<cr>" },
    { "<leader>t", "<cmd>HopChar2<cr>" },
  },
  opts = {
    keys = 'fjdksla;ghrueiwoqptyvmc,x.z/bn',
  },
  config = function(_, opts)
    require'hop'.setup(opts)
  end,
}

return M
