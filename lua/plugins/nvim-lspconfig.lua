---@type LazyPluginSpec
return {
	"neovim/nvim-lspconfig",
	-- Bufferが読み込まれるときをトリガーに遅延ロードする
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- 1. お使いの言語サーバーを一括有効化
		vim.lsp.enable({
			"lua_ls",
			"html",
			"cssls",
			"ts_ls",
			"pyright",
			"ruby_lsp",
		})

		-- 2. 個別の詳細設定 (after/lsp/lua_ls.lua にあった内容をここに集約)
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
					},
				},
			},
		})

		-- 3. 言語サーバーがアタッチされた時に呼ばれる共通設定 (lua/config/lsp.lua から移植)
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("my.lsp", {}),
			callback = function(args)
				local client = assert(vim.lsp.get_client_by_id(args.data.client_id))
				local buf = args.buf

				if client:supports_method("textDocument/definition") then
					vim.keymap.set("n", "gd", vim.lsp.buf.definition,
						{ buffer = buf, desc = "Go to definition" })
				end

				if client:supports_method("textDocument/hover") then
					vim.keymap.set("n", "<leader>k",
						function() vim.lsp.buf.hover({ border = "single" }) end,
						{ buffer = buf, desc = "Show hover documentation" })
				end

				if client:supports_method("textDocument/completion") then
					vim.lsp.completion.enable(true, client.id, args.buf, { autTrigger = true })
				end

				-- Auto-format ("lint") on save.
				if not client:supports_method("textDocument/willSaveWaitUntil")
				    and client:supports_method("textDocument/formatting") then
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = vim.api.nvim_create_augroup("my.lsp", { clear = false }),
						buffer = args.buf,
						callback = function()
							vim.lsp.buf.format({ bufnr = args.buf, id = client.id, timeout_ms = 1000 })
						end,
					})
				end

				if client:supports_method("textDocument/inlineCompletion") then
					vim.lsp.inline_completion.enable(true, { bufnr = buf })
					vim.keymap.set("i", "<Tab>", function()
						if not vim.lsp.inline_completion.get() then
							return "<Tab>"
						end
						if vim.fn.pumvisible() == 1 then
							return "<C-e>"
						end
					end, {
						expr = true,
						buffer = buf,
						desc = "Accept the current inline completion",
					})
				end
			end,
		})
	end
}
