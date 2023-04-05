local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local should_not_eslint_for_diagonastic = function(matchFn)
  local not_have_eslint_configs = {
    "/Users/subhash/Documents/work/highlevel/workflow-vue3$",
  }

  for _, dir in ipairs(not_have_eslint_configs) do
    -- print(dir, matchFn(dir))
    if matchFn(dir) then
      return true
    end
  end
  return false
end

local get_autoformat_extension_regex = function(root)
  local auto_format_dirs = {
    { "/Users/subhash/Documents/work/highlevel/workflow$", "tsx" },
    { "/Users/subhash/Documents/work/highlevel/marketplace.backend$", "tsx" },
    { "/Users/subhash/Documents/work/highlevel/workflow.vue3$", "ts|vue" },
  }

  for _, dir in ipairs(auto_format_dirs) do
    if string.find(root, dir[1]) ~= nil then
      return dir[2]
    end
  end
  return nil
end

local use_eslint_as_formatter = function(matchFn)
  -- avoid folder or file name with - char
  local root_list = {
    "/Users/subhash/Documents/work/highlevel/workflow$",
    "/Users/subhash/Documents/work/highlevel/marketplace.backend$",
  }
  for _, dir in ipairs(root_list) do
    -- print(dir, matchFn(dir))
    if matchFn(dir) then
      return true
    end
  end
  return false
end

-- https://github.com/prettier-solidity/prettier-plugin-solidity
null_ls.setup {
  debug = true,
  sources = {
    formatting.prettier.with {
      extra_filetypes = { "toml" },
      extra_args = { "--single-quote", "--jsx-single-quote" },
      condition = function(utils)
        return not use_eslint_as_formatter(utils.root_matches)
      end,
    },
    formatting.eslint_d.with {
      condition = function(utils)
        -- print(vim.inspect(utils))
        -- print(utils.root_matches(use_eslint_as_formatter))
        return use_eslint_as_formatter(utils.root_matches)
      end,
    },
    formatting.black.with { extra_args = { "--fast" } },
    formatting.stylua,
    formatting.google_java_format,
    diagnostics.flake8,
    diagnostics.eslint_d.with {
      condition = function(utils)
        return should_not_eslint_for_diagonastic(utils.root_matches)
      end,
    },
  },

  on_attach = function(client, bufnr)
    local current_dir = client.workspaceFolders[1].name
    -- if current_dir == "/Users/subhash/Documents/work/highlevel/workflow" then
    --   require("null_ls.sources").disable("prettier")
    -- end

    -- print(bufnr)
    local autoformat_extension = get_autoformat_extension_regex(current_dir)
    if autoformat_extension ~= nil then
      if client.supports_method "textDocument/formatting" then
        vim.api.nvim_clear_autocmds { group = augroup, buffer = bufnr }
        vim.api.nvim_create_autocmd("BufWritePre", {
          group = augroup,
          buffer = bufnr,
          callback = function()
            local current_ext = vim.fn.expand "%:e"
            print(current_ext, autoformat_extension,string.find(autoformat_extension, current_ext) )
            if string.find(autoformat_extension, current_ext) ~= nil then
              vim.lsp.buf.format { async = false }
            end
          end,
        })
      end
    end
  end,
}
