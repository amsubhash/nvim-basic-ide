local M = {
  "theprimeagen/harpoon",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
}

function M.config()
  local harpoon_mark = require "harpoon.mark"
  local harpoon_ui = require "harpoon.ui"

  vim.keymap.set("n", "<leader>a", harpoon_mark.add_file)
  vim.keymap.set("n", "<leader>h", harpoon_ui.toggle_quick_menu)

  vim.keymap.set("n", "<leader><leader>", function()
    harpoon_ui.nav_next()
  end)
  -- vim.keymap.set("n", "<S-h>", function()
  --   harpoon_ui.nav_file(1)
  -- end)
  -- vim.keymap.set("n", "<S-t>", function()
  --   harpoon_ui.nav_file(2)
  -- end)
  -- vim.keymap.set("n", "<S-n>", function()
  --   harpoon_ui.nav_file(3)
  -- end)
  -- vim.keymap.set("n", "<S-s>", function()
  --   harpoon_ui.nav_file(4)
  -- end)
end

return M
