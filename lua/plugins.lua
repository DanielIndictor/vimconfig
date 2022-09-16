return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim' -- Packer can manage itself
	use {
		'ojroques/nvim-hardline',
		config = function()
			require('hardline').setup {
				bufferline = true,  -- enable bufferline
				bufferline_settings = {
					exclude_terminal = false,  -- don't show terminal buffers in bufferline
					show_index = false,        -- show buffer indexes (not the actual buffer numbers) in bufferline
				},
				theme = 'default',   -- change theme
				-- define sections
				sections = {
					{class = 'mode', item = require('hardline.parts.mode').get_item},
					{class = 'high', item = require('hardline.parts.git').get_item, hide = 100},
					{class = 'med', item = require('hardline.parts.filename').get_item},
					'%<',
					{class = 'med', item = '%='},
					{class = 'low', item = require('hardline.parts.wordcount').get_item, hide = 100},
					{class = 'error', item = require('hardline.parts.lsp').get_error},
					{class = 'warning', item = require('hardline.parts.lsp').get_warning},
					{class = 'warning', item = require('hardline.parts.whitespace').get_item},
					{class = 'high', item = require('hardline.parts.filetype').get_item, hide = 60},
					{class = 'mode', item = require('hardline.parts.line').get_item},
				},
			}
		end
	}
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
			lsp.setup()
		end
	}

end)

