local M = {
  "nvim-telescope/telescope.nvim",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope-file-browser.nvim",
  },
--vim.keymap.set('n', '<leader>fb', "<cmd>Telescope buffers<cr>")
--vim.keymap.set('n', '<leader>fr', "<cmd>Telescope file_browser<cr>")
--vim.keymap.set('n', '<leader>ff', "<cmd>Telescope find_files<cr>")
--vim.keymap.set('n', '<leader>fg', "<cmd>Telescope live_grep<cr>")
  keys = {
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fc", "<cmd>Telescope current_buffer_fuzzy_find<cr>" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
    { "<leader>fr", "<cmd>Telescope file_browser<cr>" },
    { "<leader>fa",
      "<cmd>lua require('telescope.builtin').builtin(require('telescope.themes').get_dropdown({}))<cr>",
    },
  },
  opts = function()
    local actions = require("telescope.actions")
    local theme = require("telescope.themes")
    return {
      defaults = {
        mappings = { i = { ["<esc>"] = actions.close } },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = {
          additional_args = function(opts)
            return { "--hidden" }
          end,
        },
      },
      extensions = {
        file_browser = {
          theme = "ivy",
          hijack_netrw = true,
        },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("file_browser")
  end,
}

return M
