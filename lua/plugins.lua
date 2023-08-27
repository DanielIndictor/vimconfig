return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  use {'neovimhaskell/haskell-vim',
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
  use {'NLKNguyen/papercolor-theme',
    config = function()
      vim.o.background = 'dark'
      vim.o.t_Co=256
      vim.g.PaperColor_Theme_Options = {
        language = {
          python = { highlight_builtins = 1 },
          cpp = { highlight_standard_library = 1 },
          c = { highlight_builtins = 1 }
        },
        theme = {
          ["default.dark"] = {
            transparent_background = 1,
            allow_bold = 0,
            override = {
              color00 = { "#000000", "000" },
              linenumber_bg = { "#000000", "000" },
              cursor_bg = {'#000000', '000'},
              cursorlinenr_bg = {'#000000', '000'},
              popupmenu_bg = {'#000000', '000'},
              linenumber_bg = {'#000000', '000'},
              vertsplit_bg = { '#000000', '000'},
              statusline_active_bg = { '#000000', '000'},
              statusline_inactive_bg = { '#000000', '000'},
              todo_bg = { '#000000', '000'},
              error_bg = { '#000000', '000'},
              -- matchparen_bg = { '#000000', '000'},
              -- visual_bg = { '#000000', '000'},
              folded_bg = { '#000000', '000'},
              wildmenu_bg = {'#000000', '000'},
              tabline_bg = {'#000000', '000'},
              tabline_active_bg = {'#000000', '000'},
              tabline_inactive_bg = {'#000000', '000'},
              buftabline_bg = {'#000000', '000'},
              buftabline_current_bg = {'#000000', '000'},
              buftabline_active_bg = {'#000000', '000'},
              buftabline_inactive_bg = {'#000000', '000'}
            }
          }
        }
      }

      vim.cmd [[ 
      syntax enable
      colorscheme PaperColor
      hi clear SignColumn
      ]]
    end
  }
  use { 'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},
      {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'},

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},
      {'hrsh7th/cmp-buffer'},
      {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'},
      {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'},

      -- Snippets
      {'L3MON4D3/LuaSnip'},
      {'rafamadriz/friendly-snippets'},
    },
    config = function()
      local lsp = require('lsp-zero').preset({
        float_border = 'single',
        call_servers = 'local',
        configure_diagnostics = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = {
          preserve_mappings = false,
          omit = {'<CR>', '<F4>'},
        },
        manage_nvim_cmp = {
          set_basic_mappings = true,
          set_extra_mappings = true,
          use_luasnip = true,
          set_format=true,
          documentation_window=true
        }
      })

      -- lsp.on_attach(function(client, bufnr)
      --   lsp.default_keymaps({buffer=bufnr, omit={'<CR>', '<F4>'}})
      -- end)
      lsp.setup()
    end
  }
  use {'willothy/nvim-cokeline',
    requires = {
      "nvim-lua/plenary.nvim",        -- Required for v0.4.0+
    },
    config = function()
      local get_hex = require("cokeline/utils").get_hex
      require('cokeline').setup({
        rendering = {
          -- The maximum number of characters a rendered buffer is allowed to take
          -- up. The buffer will be truncated if its width is bigger than this
          -- value.
          -- default: `999`.
          max_buffer_width = 50,
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
          fg = get_hex("Normal", "fg"),
          bg = get_hex("Normal", "bg"),
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
                return get_hex("ErrorMsg", "fg")
              elseif buffer.diagnostics.warnings ~= 0 then
                return get_hex("WarningMsg", "fg")
              end
              return nil
            end,
            style = function(buffer) 
              return buffer.is_focused and "underline" or "NONE" 
            end
          },
          {
            text = " "
          },
        }
      })
    end
  }
  use {'weilbith/nvim-code-action-menu',
    config = function ()
      vim.g.code_action_menu_show_details = false
      vim.g.code_action_menu_show_diff= true
      vim.g.code_action_menu_show_action_kind = true
      vim.g.code_action_menu_border_window = 'single'
    end,
    cmd = 'CodeActionMenu'
  }

  --	use 'gpanders/editorconfig.nvim'

end)

