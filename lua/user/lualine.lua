local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
  return
end

local lsp_status = require('lsp-status')

local hide_in_width = function()
  return vim.fn.winwidth(0) > 80
end

local diagnostics = {
  "diagnostics",
  sources = { "nvim_diagnostic" },
  sections = { "error", "warn" },
  symbols = { error = " ", warn = " " },
  colored = false,
  always_visible = true,
}

local diff = {
  "diff",
  colored = false,
  symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width,
}

local filetype = {
  "filetype",
  icons_enabled = false,
}

local location = {
  "location",
  padding = 0,
}

local spaces = function()
  return "spaces: " .. vim.api.nvim_buf_get_option(0, "shiftwidth")
end

local lsp_status_text = function()
  return "lsp: " .. lsp_status.status()
end

lualine.setup {
  options = {
    globalstatus = true,
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    -- lualine_c = { diagnostics },
    lualine_c = {
      {
        "filename",
        file_status = true, -- displays file status (readonly status, modified status)
        path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path
      },
    },
    lualine_x = { diff, spaces, "encoding", filetype, lsp_status_text },
    lualine_y = { location },
    lualine_z = { "progress" },
  },
}
