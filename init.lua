-- 1. lazy.nvim の自動インストール
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- 2. リーダーキーの設定
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 3. 外部設定ファイルの読み込み
require("config.lazy")
require("config.lsp")

vim.opt.number = true

vim.opt.clipboard = "unnamedplus"
