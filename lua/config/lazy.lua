require('lazy').setup({
	{ 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' }, config = true },
	--{
	--	"monkoose/neocodeium",
	--	event = "VeryLazy",
	--	config = function()
	--		local neocodeium = require("neocodeium")
	--		neocodeium.setup()
	--		vim.keymap.set("i", "<A-f>", neocodeium.accept)
	--	end,
	--},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("bufferline").setup({
				options = {
					mode = "buffers",
					diagnostics = "nvim_lsp",
					always_show_bufferline = true,
					offsets = {
						{
							filetype = "NvimTree",
							text = "File Explorer",
							text_align = "left",
							separator = true
						}
					},
				}
			})

			-- キーマップ設定
			vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "前のバッファ" })
			vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "次のバッファ" })
			vim.keymap.set("n", "<leader>w", "<cmd>bdelete<CR>", { desc = "バッファを閉じる" })
		end
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("everforest").setup({
				-- Your config here
				background = 'soft',
			})
			vim.cmd([[colorscheme everforest]])
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		version = "*",
		lazy = false,
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup {}
			vim.keymap.set('n', '<leader>n', ':NvimTreeToggle<CR>', { silent = true })
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<M-l>", -- Tabは他で使ってるので別キーにするのが安全
					},
				},
				panel = { enabled = false }, -- パネルは使わないならこのままでOK
				copilot_node_command = 'node'
			})
		end,
	},
	{
		"L3MON4D3/LuaSnip",
		version = "v2.*",
		build = "make install_jsregexp",
		config = function()
			require("luasnip.loaders.from_lua").load()
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
		},
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		}
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
			{ "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {
			debug = true, -- Enable debugging
			show_help = "yes",
			prompts = {
				Explain = {
					prompt = "/COPILOT_EXPLAIN コードを日本語で説明してください",
					mapping = '<leader>ce',
					description = "コードの説明をお願いする",
				},
				Review = {
					prompt = '/COPILOT_REVIEW コードを日本語でレビューしてください。',
					mapping = '<leader>cr',
					description = "コードのレビューをお願いする",
				},
				Fix = {
					prompt = "/COPILOT_FIX このコードには問題があります。バグを修正したコードを表示してください。説明は日本語でお願いします。",
					mapping = '<leader>cf',
					description = "コードの修正をお願いする",
				},
				Optimize = {
					prompt = "/COPILOT_REFACTOR 選択したコードを最適化し、パフォーマンスと可読性を向上させてください。説明は日本語でお願いします。",
					mapping = '<leader>co',
					description = "コードの最適化をお願いする",
				},
				Docs = {
					prompt = "/COPILOT_GENERATE 選択したコードに関するドキュメントコメントを日本語で生成してください。",
					mapping = '<leader>cd',
					description = "コードのドキュメント作成をお願いする",
				},
				Tests = {
					prompt = "/COPILOT_TESTS 選択したコードの詳細なユニットテストを書いてください。説明は日本語でお願いします。",
					mapping = '<leader>ct',
					description = "テストコード作成をお願いする",
				},
				FixDiagnostic = {
					prompt = 'コードの診断結果に従って問題を修正してください。修正内容の説明は日本語でお願いします。',
					mapping = '<leader>cD', -- Docsと重複していたため変更
					description = "コードの修正をお願いする",
					selection = function(source)
						return require('CopilotChat.select').diagnostics(source)
					end,
				},
				Commit = {
					prompt =
					'実装差分に対するコミットメッセージを日本語で記述してください。',
					mapping = '<leader>cco',
					description = "コミットメッセージの作成をお願いする",
					selection = function(source)
						return require('CopilotChat.select').gitdiff(source)
					end,
				},
				CommitStaged = {
					prompt =
					'ステージ済みの変更に対するコミットメッセージを日本語で記述してください。',
					mapping = '<leader>cs',
					description = "ステージ済みのコミットメッセージの作成をお願いする",
					selection = function(source)
						return require('CopilotChat.select').gitdiff(source, true)
					end,
				},
			},
		},
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
				copilot_node_command = '/usr/sbin/node'
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end
	},
	{
		'windwp/nvim-autopairs',
		event = "InsertEnter",
		config = true
	},
	{
		"windwp/nvim-ts-autotag",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-ts-autotag").setup()
		end,
	},
	{
		'Wansmer/treesj',
		keys = { '<space>m', '<space>j', '<space>s' },
		dependencies = { 'nvim-treesitter/nvim-treesitter' },
		config = function()
			require('treesj').setup({})
		end,
	},
	{
		'nvim-telescope/telescope.nvim',
		version = '*',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
		}
	},
	{
		"github/copilot.vim",
		lazy = false,
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			-- Only one of these is needed.
			"sindrets/diffview.nvim", -- optional
			"esmuellert/codediff.nvim", -- optional

			-- For a custom log pager
			"m00qek/baleia.nvim", -- optional

			-- Only one of these is needed.
			"nvim-telescope/telescope.nvim", -- optional
			"ibhagwan/fzf-lua", -- optional
			"nvim-mini/mini.pick", -- optional
			"folke/snacks.nvim", -- optional
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" }
		}
	},
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({})
		end
	},
	{
		'akinsho/toggleterm.nvim',
		version = "*",
		config = true
	},
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					-- Tabキー:候補選択 → 候補がなければLuaSnipのジャンプ
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.locally_jumpable(1) then
							luasnip.jump(1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.locally_jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),

					["<C-p>"] = cmp.mapping.select_prev_item(),
					["<C-n>"] = cmp.mapping.select_next_item(),
					["<C-d>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),

					-- Enter:候補選択中はLuaSnip展開 or 確定、それ以外は暴発防止
					["<CR>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if luasnip.expandable() then
								luasnip.expand()
							else
								cmp.confirm({ select = false })
							end
						else
							fallback()
						end
					end),
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = 'copilot' },
					{ name = "luasnip" },
				}, {
					{ name = "buffer" },
					{ name = "path" },
				}),
			})
		end,
	},
	{
		"j-hui/fidget.nvim",
		opts = {
			-- options
		},
	},
	-- ★追加: ブログの構成(lua/plugins/)にあるプラグイン設定を自動で読み込む
	{ import = "plugins" }
})

-- Telescopeのキーマップ設定
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
