-- Conversions from vim cmd to nvim: 
-- https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/

-- vim.cmd([[
-- autocmd FileType c,cpp setlocal equalprg=clang-format\ -style='file'
-- "colorscheme wombat256mod_custom
-- set termguicolors
-- set number
-- set autoindent
-- "set cindent
-- set smartindent
-- set expandtab
-- set smarttab
-- "set shiftwidth=2
-- "set softtabstop=2
-- "set tabstop=2
-- ]])

vim.o.smartindent = true
vim.o.termguicolors = true
vim.o.number = true
-- vim.o.cindent = true
vim.o.autoindent = true
vim.o.expandtab = true
vim.o.smarttab = true
vim.o.shiftwidth=2
vim.o.softtabstop=2
vim.o.tabstop=2

-- Trying papercolor theme in plugins.
-- vim.cmd[[colorscheme wombat256mod_custom]]

-- Make diagnostics not show up on the same line as code.
vim.diagnostic.config({ virtual_text=false })

vim.cmd [[
  syn sync minlines=2000
  " For neovimhaskell/haskell-vim to work right.
  filetype plugin indent on
  autocmd BufEnter *.hs :syn sync minlines=2000
]]

require('plugins')
