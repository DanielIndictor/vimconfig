vim.cmd[[colorscheme wombat256mod_custom]]

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  use {
    'VonHeikemen/lsp-zero.nvim',
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
      local lsp = require('lsp-zero')
      lsp.preset('recommended')
      
      local cmp_mappings = lsp.defaults.cmp_mappings({ })
      -- disable confirm with Enter key
      cmp_mappings['<CR>'] = nil

      lsp.setup_nvim_cmp({mapping = cmp_mappings})
      lsp.setup()
    end
  }
  use {
    'noib3/nvim-cokeline',
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
            text = function(buffer) return ' ' .. buffer.number .. ' ' end,
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
  --	use 'gpanders/editorconfig.nvim'

end)

