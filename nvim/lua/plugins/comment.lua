M = {
  'numToStr/Comment.nvim',
  event = "VeryLazy",
  keys = {
    { "<A-;>", "<Plug>(comment_toggle_linewise_current)", mode = "n" },
    { "<A-;>", "<Plug>(comment_toggle_linewise_visual)", mode = "v" },
  },
  config = function()
    require'Comment'.setup()
  end,
}

return M
