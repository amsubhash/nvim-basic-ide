local M = {
  "nvim-telescope/telescope.nvim",
  commit = "40c31fdde93bcd85aeb3447bb3e2a3208395a868",
  event = "Bufenter",
  cmd = { "Telescope" },
  cond = not vim.g.vscode,
  dependencies = {
    {
      "ahmedkhalf/project.nvim",
      commit = "8c6bad7d22eef1b71144b401c9f74ed01526a4fb",
    },
    {
      "nvim-telescope/telescope-live-grep-args.nvim",
      -- This will not install any breaking changes.
      -- For major updates, this must be adjusted manually.
      version = "^1.0.0",
    },
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
  },
}


M.config = function()
  local actions = require "telescope.actions"
  local telescope = require "telescope"
  local lga_actions = require "telescope-live-grep-args.actions"
  telescope.setup {
    defaults = {
      prompt_prefix = " ",
      selection_caret = " ",
      path_display = { "smart" },
      file_ignore_patterns = { ".git/", "node_modules" },
      mappings = {
        i = {
          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
    },
    extensions = {
      live_grep_args = {
        auto_quoting = true, -- enable/disable auto-quoting
        -- define mappings, e.g.
        mappings = { -- extend mappings
          i = {
            ["<C-k>"] = lga_actions.quote_prompt(),
            ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
          },
        },
        -- ... also accepts theme settings, for example:
        -- theme = "dropdown", -- use dropdown theme
        -- theme = { }, -- use own theme spec
        -- layout_config = { mirror=true }, -- mirror preview pane
      },
    },
  }
  telescope.load_extension "live_grep_args"
  telescope.load_extension "fzf"
end

return M
