---@type LazyPluginSpec
return {
  {
    "mason-org/mason.nvim",
    opts = {},
  },
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = { "mason-org/mason.nvim" },
    opts = {
      ensure_installed = {
        "lua_ls",
        "html",       -- HTML
        "cssls",      -- CSS
        "ts_ls",      -- JavaScript / TypeScript / JSX / TSX
        "pyright",    -- Python
        "ruby_lsp",   -- Ruby
      },
    },
  },
}
