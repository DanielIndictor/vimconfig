" Vundle {{{

set rtp+=~/.vim/vundle.vim
call vundle#begin()
Plugin 'gmarik/vundle'

Plugin 'scrooloose/nerdtree'
Plugin 'bling/vim-airline'
Plugin 'bkad/CamelCaseMotion'
Plugin 'tpope/vim-fugitive'
Plugin 'kristijanhusak/vim-multiple-cursors'
Plugin 'joom/vim-commentary'
Plugin 'vim-scripts/Align'
Plugin 'valloric/MatchTagAlways'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
"Plugin 'jiangmiao/auto-pairs'
Plugin 'wesQ3/vim-windowswap'
Plugin 'tpope/vim-surround'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'ervandew/supertab'
Plugin 'ConradIrwin/vim-bracketed-paste'
Plugin 'gcmt/wildfire.vim'
Plugin 'ap/vim-buftabline'
Plugin 'vim-pandoc/vim-pandoc'
Plugin 'vim-pandoc/vim-pandoc-syntax'
Plugin 'ycm-core/YouCompleteMe'
Plugin 'rdnetto/YCM-Generator'
Plugin 'kana/vim-operator-user'
Plugin 'rhysd/vim-clang-format'
Plugin 'idanarye/vim-vebugger'

"Front End
Plugin 'pangloss/vim-javascript'
Plugin 'ap/vim-css-color'
Plugin 'miripiruni/CSScomb-for-Vim'
Plugin 'dense-analysis/ale'


call vundle#end()            " required
" }}}

" Plugin Settings {{{
let g:windowswap_map_keys = 0 "prevent default bindings
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git'
" }}}

" ale Settings {{{
let b:ale_linters = {'python': ['pylint'], 'systemverilog': ['verilator']}
let b:ale_fixers = ['autopep8']
autocmd FileType py map <buffer>= <Plug>(operator-clang-format)
let g:airline#extensions#ale#enabled = 1
" }}}
"

" vim-clang-format Settings {{{
autocmd FileType c,cpp,objc map <buffer>= <Plug>(operator-clang-format)
let g:clang_format#auto_format = 1
" }}}

" YouCompleteMe Settings {{{
" " Enable debugging
" let g:ycm_keep_logfiles = 1
" let g:ycm_log_level = 'debug'
" Make preview autolose.
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_autoclose_preview_window_after_completion = 1
nnoremap <leader>g :YcmCompleter GoToDefinitionElseDeclaration<CR>
"let &rtp .= ',' . expand( '<sfile>:p:h' )
"
" }}}

" YouCompleteMe Settings {{{
let g:buftabline_numbers = 1
" }}}

" Airline {{{
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0 "change 0 to 1 if you have a powerline font
set laststatus=2
set t_Co=256
" }}}

" NERDTree {{{
let g:NERDTreeMapChangeRoot =  "`"

nmap <Leader>] :NERDTreeTabsToggle<CR>
nnoremap <Space>c :NERDTreeCWD<CR>
let NERDTreeMinimalUI=1
let NERDTreeDirArrows=0
let NERDTreeQuitOnOpen = 1
let NERDTreeIgnore=['\.pyc$', '\~$']
let NERDTreeShowLineNumbers = 1
let NERDTreeWinSize = 25

function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
"                     1BufNo  2Mods.     3File           4LineNo
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()
" }}}

" General {{{

set nocompatible
filetype off
set foldmethod=syntax
set foldnestmax=1

set linebreak

set number

syntax on
set mouse=a

filetype plugin indent on

set encoding=utf-8
set fileencodings=utf-8

set autoindent
set smartindent
"set cindent
set smartindent
set background=dark
set expandtab
set smarttab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set wildignore=*.pyc
set ignorecase
set smartcase
set hlsearch
set incsearch
set shiftround
set history=1000
set undolevels=1000
set noswapfile
set nobackup
set number
set linespace=3
set backspace=indent,eol,start

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
" }}}

" Some Useful Key Mappings {{{

"Split swap
nmap <Tab> :CtrlPBuffer<CR>
nmap <Leader>f :CtrlPLine<CR>
nnoremap <silent> <Leader>sw :call WindowSwap#EasyWindowSwap()<CR>
nmap <Leader>` :call WindowSwap#EasyWindowSwap()<CR><Leader>[:call WindowSwap#EasyWindowSwap()<CR>

"for unhighlighing the selections
nmap <Space>x :let @/=''<CR>

"split switch
nnoremap <Leader>[ <C-W>w

"System clipboard
vmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

"Keep the cursor in the same place after yank
vmap y ygv<Esc>

"Reload vimrc
nmap <F5> :source ~/.vimrc<CR>

"New Tab
nmap <Leader>n :tabnew<CR>

"Paste mode toggle
set pastetoggle=<F5><F5>

"Keep selection after indent
vnoremap > ><CR>gv
vnoremap < <<CR>gv

" "Camel case motion (with shift)
map <Space>w <Plug>CamelCaseMotion_w
map <Space>b <Plug>CamelCaseMotion_b
map <Space>e <Plug>CamelCaseMotion_e
" }}}

" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

colorscheme wombat256mod_custom

