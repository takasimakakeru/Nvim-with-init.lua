return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		lazy = false, -- 起動時に必ず読み込む
		priority = 1000, -- カラースキームを最優先で適用
		config = function()
			-- スタイルの好みに合わせて変更可能（'main' / 'moon' / 'dawn'）
			require("rose-pine").setup({
				variant = "moon", -- メインのダーク（moonを選ぶと少し明るいダーク、dawnはライトテーマ）
				styles = {
					italic = true, -- キーワードなどを斜体にする（垢抜けポイント！）
					transparency = false, -- ターミナルの背景を透かす場合は true に
				},
			})

			-- カラースキームを適用
			vim.cmd("colorscheme rose-pine")
		end,
	}
}
