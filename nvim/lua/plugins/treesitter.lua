local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = "BufReadPost",
  opts = {
    highlight = {
      enable = true,
      -- syntax off
      additional_vim_regex_highlighting = false,
    },
    autopairs = { enable = true },
    autotag = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-n>",
        node_incremental = "<C-n>",
        scope_incremental = "<C-s>",
        node_decremental = "<C-r>",
      },
    },
    ensure_installed = {
      "bash", "c", "cpp", "diff",
      "git_config", "git_rebase", "gitattributes", "gitcommit", "gitignore",
      "java", "kconfig", "llvm", "lua", "make", "markdown", "markdown_inline",
      "python", "rust", "vim", "vimdoc",
    },
    sync_install = true,
    refactor = {
      highlight_definitions = {
        enable = true,
        -- Set to false if you have an `updatetime` of ~100.
        clear_on_cursor_move = true,
      },
      highlight_current_scope = { enable = false },
    },
  },
  config = function(_, opts)
    require'nvim-treesitter.install'.prefer_git = true
    require'nvim-treesitter.configs'.setup(opts)
  end,
}

return M
