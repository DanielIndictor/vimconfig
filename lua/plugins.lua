return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
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
      vim.g.code_action_menu_border_window = 'single'
      vim.keymap.set({ 'n', 'v' }, '<F4>', '<CMD>CodeActionMenu<CR>')
    end,
    cmd = 'CodeActionMenu'
  }
  use { 'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  }
  use { 'ggandor/leap-ast.nvim',
    requires = { 'ggandor/leap.nvim', 'nvim-treesitter/nvim-treesitter'},
    config = function()
      vim.keymap.set({'n', 'x', 'o'}, '<Leader>s', function() require'leap-ast'.leap() end, {})
    end
  }

  --	use 'gpanders/editorconfig.nvim'
end)
