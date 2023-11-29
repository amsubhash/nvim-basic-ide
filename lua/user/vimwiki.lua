local M = {
  "vimwiki/vimwiki",
  event = "VimEnter",
  cond = false,
}

function M.setOption()
  vim.g.vimwiki_list = {{path = '~/Documents/work/personal/wiki/', syntax = 'markdown', ext = '.md'}}
  vim.g.vimwiki_global_ext = 0
end

return M
