local M = {
  "theprimeagen/harpoon",
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  cond = not vim.g.vscode,
}

function M.config()
  local harpoon_mark = require "harpoon.mark"
  local harpoon_ui = require "harpoon.ui"

  vim.keymap.set("n", "<leader>ha", harpoon_mark.add_file)
  vim.keymap.set("n", "<leader>hh", harpoon_ui.toggle_quick_menu)

  vim.keymap.set("n", "<leader><leader>", function()
    harpoon_ui.nav_next()
  end)
  vim.keymap.set("n", "<leader>h1", function()
    harpoon_ui.nav_file(1)
  end)
  vim.keymap.set("n", "<leader>h1", function()
    harpoon_ui.nav_file(2)
  end)
  vim.keymap.set("n", "<leader>h1", function()
    harpoon_ui.nav_file(3)
  end)
  vim.keymap.set("n", "<leader>h1", function()
    harpoon_ui.nav_file(4)
  end)
end

return M
