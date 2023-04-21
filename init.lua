vim.cmd([[
autocmd FileType c,cpp setlocal equalprg=clang-format\ -style='file'
colorscheme wombat256mod_custom
set termguicolors
set number
set autoindent
"set cindent
set smartindent
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
]])


vim.diagnostic.config({ virtual_text=false })

require('plugins')
