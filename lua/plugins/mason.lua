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
      -- ここに書いた名前は自動でインストール & vim.lsp.enable() される
      ensure_installed = { "lua_ls" },
    },
  },
}
