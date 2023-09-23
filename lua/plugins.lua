return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  use { "nvim-treesitter/nvim-treesitter-textobjects",
  after = "nvim-treesitter",
  requires = "nvim-treesitter/nvim-treesitter",
  config = function ()
    require("nvim-treesitter.configs").setup {
      -- config stolen from https://raw.githubusercontent.com/nvim-treesitter/nvim-treesitter-textobjects/bd103502252027434ec42f628d2dbf54821d4ce6/scripts/minimal_init.lua
      -- A list of parser names, or "all"
      ensure_installed = {"python", "haskell", "rust", "go", "vim", "vimdoc", "bash", "cmake", "cpp"},

      sync_install = true, -- Install parsers synchronously (only applied to `ensure_installed`)

      -- Automatically install missing parsers when entering buffer
      auto_install = true, -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally

      ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
      -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!
      -- parser_install_dir = "/some/path/to/store/parsers",

      highlight = {
        enable = true, -- `false` will disable the whole extension

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = true,
      },

      textobjects = {
        select = {
          enable = true,

          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,

          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["am"] = "@function.outer",
            ["im"] = "@function.inner",
            ["al"] = "@class.outer",
            -- You can optionally set descriptions to the mappings (used in the desc parameter of
            -- nvim_buf_set_keymap) which plugins like which-key display
            ["il"] = { query = "@class.inner", desc = "Select inner part of a class region" },
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
            ["ad"] = "@conditional.outer",
            ["id"] = "@conditional.inner",
            ["ao"] = "@loop.outer",
            ["io"] = "@loop.inner",
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@call.outer",
            ["if"] = "@call.inner",
            ["ac"] = "@comment.outer",
            ["ar"] = "@frame.outer",
            ["ir"] = "@frame.inner",
            ["at"] = "@attribute.outer",
            ["it"] = "@attribute.inner",
            ["ae"] = "@scopename.inner",
            ["ie"] = "@scopename.inner",
            ["as"] = "@statement.outer",
            ["is"] = "@statement.outer",
          },
          -- You can choose the select mode (default is charwise 'v')
          --
          -- Can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * method: eg 'v' or 'o'
          -- and should return the mode ('v', 'V', or '<c-v>') or a table
          -- mapping query_strings to modes.
          -- selection_modes = treesitter_selection_mode,
          -- if you set this to `true` (default is `false`) then any textobject is
          -- extended to include preceding or succeeding whitespace. succeeding
          -- whitespace has priority in order to act similarly to eg the built-in
          -- `ap`.
          --
          -- can also be a function which gets passed a table with the keys
          -- * query_string: eg '@function.inner'
          -- * selection_mode: eg 'v'
          -- and should return true of false
          include_surrounding_whitespace = false,
        },
        swap = {
          enable = true,
          swap_next = {
            [")m"] = "@function.outer",
            [")c"] = "@comment.outer",
            [")a"] = "@parameter.inner",
            [")b"] = "@block.outer",
            [")C"] = "@class.outer",
          },
          swap_previous = {
            ["(m"] = "@function.outer",
            ["(c"] = "@comment.outer",
            ["(a"] = "@parameter.inner",
            ["(b"] = "@block.outer",
            ["(C"] = "@class.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]f"] = "@call.outer",
            ["]d"] = "@conditional.outer",
            ["]o"] = "@loop.outer",
            ["]s"] = "@statement.outer",
            ["]a"] = "@parameter.outer",
            ["]c"] = "@comment.outer",
            ["]b"] = "@block.outer",
            ["]l"] = { query = "@class.outer", desc = "next class start" },
            ["]r"] = "@frame.outer",
            ["]t"] = "@attribute.outer",
            ["]e"] = "@scopename.outer",
            ["]]m"] = "@function.inner",
            ["]]f"] = "@call.inner",
            ["]]d"] = "@conditional.inner",
            ["]]o"] = "@loop.inner",
            ["]]a"] = "@parameter.inner",
            ["]]b"] = "@block.inner",
            ["]]l"] = { query = "@class.inner", desc = "next class start" },
            ["]]r"] = "@frame.inner",
            ["]]t"] = "@attribute.inner",
            ["]]e"] = "@scopename.inner",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]F"] = "@call.outer",
            ["]D"] = "@conditional.outer",
            ["]O"] = "@loop.outer",
            ["]S"] = "@statement.outer",
            ["]A"] = "@parameter.outer",
            ["]C"] = "@comment.outer",
            ["]B"] = "@block.outer",
            ["]L"] = "@class.outer",
            ["]R"] = "@frame.outer",
            ["]T"] = "@attribute.outer",
            ["]E"] = "@scopename.outer",
            ["]]M"] = "@function.inner",
            ["]]F"] = "@call.inner",
            ["]]D"] = "@conditional.inner",
            ["]]O"] = "@loop.inner",
            ["]]A"] = "@parameter.inner",
            ["]]B"] = "@block.inner",
            ["]]L"] = "@class.inner",
            ["]]R"] = "@frame.inner",
            ["]]T"] = "@attribute.inner",
            ["]]E"] = "@scopename.inner",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[f"] = "@call.outer",
            ["[d"] = "@conditional.outer",
            ["[o"] = "@loop.outer",
            ["[s"] = "@statement.outer",
            ["[a"] = "@parameter.outer",
            ["[c"] = "@comment.outer",
            ["[b"] = "@block.outer",
            ["[l"] = "@class.outer",
            ["[r"] = "@frame.outer",
            ["[t"] = "@attribute.outer",
            ["[e"] = "@scopename.outer",
            ["[[m"] = "@function.inner",
            ["[[f"] = "@call.inner",
            ["[[d"] = "@conditional.inner",
            ["[[o"] = "@loop.inner",
            ["[[a"] = "@parameter.inner",
            ["[[b"] = "@block.inner",
            ["[[l"] = "@class.inner",
            ["[[r"] = "@frame.inner",
            ["[[t"] = "@attribute.inner",
            ["[[e"] = "@scopename.inner",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[F"] = "@call.outer",
            ["[D"] = "@conditional.outer",
            ["[O"] = "@loop.outer",
            ["[S"] = "@statement.outer",
            ["[A"] = "@parameter.outer",
            ["[C"] = "@comment.outer",
            ["[B"] = "@block.outer",
            ["[L"] = "@class.outer",
            ["[R"] = "@frame.outer",
            ["[T"] = "@attribute.outer",
            ["[E"] = "@scopename.outer",
            ["[[M"] = "@function.inner",
            ["[[F"] = "@call.inner",
            ["[[D"] = "@conditional.inner",
            ["[[O"] = "@loop.inner",
            ["[[A"] = "@parameter.inner",
            ["[[B"] = "@block.inner",
            ["[[L"] = "@class.inner",
            ["[[R"] = "@frame.inner",
            ["[[T"] = "@attribute.inner",
            ["[[E"] = "@scopename.inner",
          },
        },
      },
    }

    -- Avoid this; flit covers repeatable moves for us.
    -- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
  end
}
use { 'kylechui/nvim-surround',
config = function()
  require('nvim-surround').setup({})
end
  }
  use { 'neovimhaskell/haskell-vim',
  config = function()
    vim.g.haskell_enable_quantification = 1   -- enable highlighting of `forall`
    vim.g.haskell_enable_recursivedo = 1      -- enable highlighting of `mdo` and `rec`
    vim.g.haskell_enable_arrowsyntax = 1      -- enable highlighting of `proc`
    vim.g.haskell_enable_pattern_synonyms = 1 -- enable highlighting of `pattern`
    vim.g.haskell_enable_typeroles = 1        -- enable highlighting of type roles
    vim.g.haskell_enable_static_pointers = 1  -- enable highlighting of `static`
    vim.g.haskell_backpack = 1                -- enable highlighting of backpack keywords
  end
}
use { 'anuvyklack/pretty-fold.nvim',
config = function()
  require('pretty-fold').setup({
    fill_char=' '
  })
end
  }
  use { 'tomasiser/vim-code-dark',
  config = function()
    vim.g.codedark_modern = 1
    vim.g.codedark_italics = 0
    vim.g.codedark_transparent = 1
    vim.cmd.colorscheme('codedark')
    vim.cmd.highlight('Folded', 'guibg=#111111', 'guifg=#A0A0A0')
  end
}
use { 'VonHeikemen/lsp-zero.nvim',
requires = {
  -- LSP Support
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/mason.nvim' },
  { 'williamboman/mason-lspconfig.nvim' },

  -- Autocompletion
  { 'hrsh7th/nvim-cmp' },
  { 'hrsh7th/cmp-buffer' },
  { 'hrsh7th/cmp-path' },
  { 'saadparwaiz1/cmp_luasnip' },
  { 'hrsh7th/cmp-nvim-lsp' },
  { 'hrsh7th/cmp-nvim-lua' },

  -- Snippets
  { 'L3MON4D3/LuaSnip' },
  { 'rafamadriz/friendly-snippets' },
},
config = function()
  local lsp = require('lsp-zero').preset({
    float_border = 'single',
    call_servers = 'local',
    configure_diagnostics = true,
    setup_servers_on_start = true,
    set_lsp_keymaps = {
      preserve_mappings = false,
      omit = { '<CR>', '<F4>' },
    },
    manage_nvim_cmp = {
      set_basic_mappings = true,
      set_extra_mappings = true,
      use_luasnip = true,
      set_format = true,
      documentation_window = true
    }
  })

  -- lsp.on_attach(function(client, bufnr)
  --   lsp.default_keymaps({buffer=bufnr, omit={'<CR>', '<F4>'}})
  -- end)
  lsp.setup()
end
  }
  use { 'willothy/nvim-cokeline',
  requires = {
    'nvim-lua/plenary.nvim',        -- Required for v0.4.0+
  },
  config = function()
    local get_hex = require('cokeline/utils').get_hex
    local cokeline = require('cokeline')
    cokeline.setup({
      rendering = {
        max_buffer_width = 50, -- Buffer width truncated to this. default: `999`.
      },
      -- The default highlight group values.
      -- The `fg` and `bg` keys are either colors in hexadecimal format or
      -- functions taking a `buffer` parameter and returning a color in
      -- hexadecimal format. Similarly, the `style` key is either a string
      -- containing a comma separated list of items in `:h attr-list` or a
      -- function returning one.
      default_hl = {
        -- default: `ColorColumn`'s background color for focused buffers,
        -- `Normal`'s foreground color for unfocused ones.
        fg = get_hex('Normal', 'fg'),
        bg = get_hex('Normal', 'bg'),
      },
      components = {
        -- index
        {
          text = function(buffer) return ' ' .. buffer.index .. ' ' end,
        },
        -- filename
        {
          text = function(buffer)
            return buffer.unique_prefix .. buffer.filename
          end,
          fg = function(buffer)
            if buffer.diagnostics.errors ~= 0 then
              return get_hex('ErrorMsg', 'fg')
            elseif buffer.diagnostics.warnings ~= 0 then
              return get_hex('WarningMsg', 'fg')
            end
            return nil
          end,
          style = function(buffer)
            return buffer.is_focused and 'underline' or 'NONE'
          end
        },
        { text = ' ' },
      }
    })

    -- TODO: Choose keymaps.
    -- vim.keymap.set('n', '<Ctrl-S-Tab>', '<Plug>(cokeline-focus-prev)')
    -- vim.keymap.set('n', '<Ctrl-Tab>',  '<Plug>(cokeline-focus-next)')
    -- vim.keymap.set('n', '<Leader>p', '<Plug>(cokeline-switch-prev)')
    -- vim.keymap.set('n', '<Leader>n', '<Plug>(cokeline-switch-next)')
    -- for i = 1,9 do
    --   vim.keymap.set('n', ('<C-%s>'):format(i),      ('<Plug>(cokeline-focus-%s)'):format(i),  { silent = true })
    --   -- map('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-switch-%s)'):format(i), { silent = true })
    -- end

  end
}
use { 'weilbith/nvim-code-action-menu',
config = function()
  vim.g.code_action_menu_show_details = false
  vim.g.code_action_menu_show_diff = true
  vim.g.code_action_menu_show_action_kind = true
  vim.g.code_action_menu_border_cindoc = 'single'
  vim.keymap.set({ 'n', 'v' }, '<F4>', '<CMD>CodeActionMenu<CR>')
end,
cmd = 'CodeActionMenu'
  }
  use { 'ggandor/leap.nvim',
  config = function()
    require('leap').add_default_mappings()
  end
}
use { 'ggandor/flit.nvim',
requires = {'ggandor/leap.nvim'},
config = function() require('flit').setup() end
  }
  use { 'ggandor/leap-spooky.nvim',
  requires = {'ggandor/leap.nvim'},
  config = function() 
    require('leap-spooky').setup()
    vim.opt.timeout = false 
    -- vim.opt.timeoutlen = 5000 -- Timeout on mapping after 3 seconds.
    -- vim.opt.ttimeoutlen = 5000 -- Timeout on keycode after 1 second.
  end
}
use { 'ggandor/leap-ast.nvim',
requires = { 'ggandor/leap.nvim', 'nvim-treesitter/nvim-treesitter'},
config = function()
  local leap_ast = require('leap-ast')
  vim.keymap.set({'n', 'x', 'o'}, '<Leader>s', leap_ast.leap, {})
end
  }

  --	use 'gpanders/editorconfig.nvim'
end)
