vim.cmd([[
autocmd FileType c,cpp setlocal equalprg=clang-format\ -style='file'
colorscheme wombat256mod_custom
set termguicolors
set number
]])

require('plugins')
