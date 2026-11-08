-- ==========================================
-- Neovim 2026 Autumn Edition
-- ==========================================

-- Leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- ==========================================
-- Options
-- ==========================================

local opt = vim.opt

-- 行番号
opt.number = true
opt.relativenumber = false

-- インデント
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- 検索
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

-- 表示
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = "yes"
opt.wrap = false
opt.scrolloff = 8
opt.sidescrolloff = 8

-- 編集
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- 分割ウィンドウ
opt.splitright = true
opt.splitbelow = true

-- その他
opt.updatetime = 250
opt.timeoutlen = 400
opt.completeopt = { "menu", "menuone", "noselect" }

-- ==========================================
-- Keymaps
-- ==========================================

local map = vim.keymap.set

-- 保存・終了
map("n", "<leader>w", "<cmd>write<CR>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<CR>", { desc = "Quit" })
map("n", "<leader>Q", "<cmd>quitall<CR>", { desc = "Quit all" })

-- ウィンドウ移動
map("n", "<C-h>", "<C-w>h", { desc = "Move left" })
map("n", "<C-j>", "<C-w>j", { desc = "Move down" })
map("n", "<C-k>", "<C-w>k", { desc = "Move up" })
map("n", "<C-l>", "<C-w>l", { desc = "Move right" })

-- ウィンドウサイズ
map("n", "<C-Up>", "<cmd>resize +2<CR>")
map("n", "<C-Down>", "<cmd>resize -2<CR>")
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>")

-- 検索ハイライト解除
map("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- ターミナル
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- ==========================================
-- Autocmds
-- ==========================================

local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- ヤンク時にハイライト
augroup("YankHighlight", { clear = true })

autocmd("TextYankPost", {
    group = "YankHighlight",
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- ファイルを開いたときに前回のカーソル位置へ
augroup("LastPosition", { clear = true })

autocmd("BufReadPost", {
    group = "LastPosition",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)

if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- ==========================================
-- Plugins
-- ==========================================

-- Plugin configurations will be added here.

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end

vim.opt.rtp:prepend(lazypath)

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- Initialize lazy.nvim
require("lazy").setup({
    -- プラグインのダウンロードと設定をここにまとめる
    {
        "rebelot/kanagawa.nvim",
        config = function()
            require('kanagawa').setup({
                compile = false,             -- enable compiling the colorscheme
                undercurl = true,            -- enable undercurls
                commentStyle = { italic = true },
                functionStyle = {},
                keywordStyle = { italic = true},
                statementStyle = { bold = true },
                typeStyle = {},
                transparent = false,         -- do not set background color
                dimInactive = false,         -- dim inactive window `:h hl-NormalNC`
                terminalColors = true,       -- define vim.g.terminal_color_{0,17}
                colors = {                   -- add/modify theme and palette colors
                    palette = {},
                    theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
                },
                overrides = function(colors) -- add/modify highlights
                    return {}
                end,
                theme = "wave",              -- Load "wave" theme
                background = {               -- map the value of 'background' option to a theme
                    dark = "dragon",           -- try "dragon" !
                    light = "lotus"
                },
            })

            -- setupの後にカラースキームを適用
            vim.cmd("colorscheme kanagawa")
        end
    },
{'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
{
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' }
},
{
    "nvim-tree/nvim-web-devicons", -- アイコン表示用（オプションですが推奨）
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      -- コピペしたい設定内容（config）をここに記述します
      ---@type nvim_tree.config
      local config = {
        sort = {
          sorter = "case_sensitive",
        },
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = true,
        },
      }

      -- 最後にsetupを実行（1回だけでOKです）
      require("nvim-tree").setup(config)
    end,
  },
{
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
},
{
  'Wansmer/treesj',
  keys = { '<space>m', '<space>j', '<space>s' },
  dependencies = { 'nvim-treesitter/nvim-treesitter' }, -- if you install parsers with `nvim-treesitter`
  config = function()
    require('treesj').setup({--[[ your config ]]})
  end,
},
{
    'nvim-telescope/telescope.nvim', version = '*',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- optional but recommended
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    }
},
{
  'nvim-treesitter/nvim-treesitter',
  lazy = false,
  build = ':TSUpdate'
},

})
