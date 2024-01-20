return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Packer can manage itself
  use {
    "nvim-treesitter/nvim-treesitter-textobjects",
    after = "nvim-treesitter",
    requires = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter.configs").setup {
        -- config stolen from https://raw.githubusercontent.com/nvim-treesitter/nvim-treesitter-textobjects/bd103502252027434ec42f628d2dbf54821d4ce6/scripts/minimal_init.lua
        -- A list of parser names, or "all"
        ensure_installed = {
          "python", "haskell", "rust", "go", "vim", "vimdoc", "bash",
          "cmake", "cpp"
        },

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
          additional_vim_regex_highlighting = true
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
              ["il"] = {
                query = "@class.inner",
                desc = "Select inner part of a class region"
              },
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
              ["is"] = "@statement.outer"
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
            include_surrounding_whitespace = false
          },
          swap = {
            enable = true,
            swap_next = {
              [")m"] = "@function.outer",
              [")c"] = "@comment.outer",
              [")a"] = "@parameter.inner",
              [")b"] = "@block.outer",
              [")C"] = "@class.outer"
            },
            swap_previous = {
              ["(m"] = "@function.outer",
              ["(c"] = "@comment.outer",
              ["(a"] = "@parameter.inner",
              ["(b"] = "@block.outer",
              ["(C"] = "@class.outer"
            }
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
              ["]f"] = "@call.outer",
              -- ["]d"] = "@conditional.outer",
              ["]o"] = "@loop.outer",
              ["]s"] = "@statement.outer",
              ["]a"] = "@parameter.outer",
              ["]c"] = "@comment.outer",
              ["]b"] = "@block.outer",
              ["]l"] = {
                query = "@class.outer",
                desc = "next class start"
              },
              ["]r"] = "@frame.outer",
              ["]t"] = "@attribute.outer",
              ["]e"] = "@scopename.outer",
              ["]]m"] = "@function.inner",
              ["]]f"] = "@call.inner",
              -- ["]]d"] = "@conditional.inner",
              ["]]o"] = "@loop.inner",
              ["]]a"] = "@parameter.inner",
              ["]]b"] = "@block.inner",
              ["]]l"] = {
                query = "@class.inner",
                desc = "next class start"
              },
              ["]]r"] = "@frame.inner",
              ["]]t"] = "@attribute.inner",
              ["]]e"] = "@scopename.inner"
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
              ["]F"] = "@call.outer",
              -- ["]D"] = "@conditional.outer",
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
              -- ["]]D"] = "@conditional.inner",
              ["]]O"] = "@loop.inner",
              ["]]A"] = "@parameter.inner",
              ["]]B"] = "@block.inner",
              ["]]L"] = "@class.inner",
              ["]]R"] = "@frame.inner",
              ["]]T"] = "@attribute.inner",
              ["]]E"] = "@scopename.inner"
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
              ["[f"] = "@call.outer",
              -- ["[d"] = "@conditional.outer",
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
              ["[[e"] = "@scopename.inner"
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
              ["[F"] = "@call.outer",
              -- ["[D"] = "@conditional.outer",
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
              -- ["[[D"] = "@conditional.inner",
              ["[[O"] = "@loop.inner",
              ["[[A"] = "@parameter.inner",
              ["[[B"] = "@block.inner",
              ["[[L"] = "@class.inner",
              ["[[R"] = "@frame.inner",
              ["[[T"] = "@attribute.inner",
              ["[[E"] = "@scopename.inner"
            }
          }
        }
      }

      -- Avoid this; flit covers repeatable moves for us.
      -- local ts_repeat_move = require "nvim-treesitter.textobjects.repeatable_move"
    end
  }
  use {
    'kylechui/nvim-surround',
    config = function() require('nvim-surround').setup({}) end
  }
  use {
    'neovimhaskell/haskell-vim',
    config = function()
      vim.g.haskell_enable_quantification = 1 -- enable highlighting of `forall`
      vim.g.haskell_enable_recursivedo = 1 -- enable highlighting of `mdo` and `rec`
      vim.g.haskell_enable_arrowsyntax = 1 -- enable highlighting of `proc`
      vim.g.haskell_enable_pattern_synonyms = 1 -- enable highlighting of `pattern`
      vim.g.haskell_enable_typeroles = 1 -- enable highlighting of type roles
      vim.g.haskell_enable_static_pointers = 1 -- enable highlighting of `static`
      vim.g.haskell_backpack = 1 -- enable highlighting of backpack keywords
    end
  }
  use {
    'anuvyklack/pretty-fold.nvim',
    config = function()
      require('pretty-fold').setup({fill_char = ' '})
    end
  }
  use {
    'Mofiqul/vscode.nvim',
    config = function()
      local vscode = require('vscode')
      vscode.setup({transparent=true})
      vscode.load()
    end
  }
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      {'neovim/nvim-lspconfig'}, {'williamboman/mason.nvim'},
      {'williamboman/mason-lspconfig.nvim'}, -- Autocompletion
      {'hrsh7th/nvim-cmp'}, {'hrsh7th/cmp-buffer'}, {'hrsh7th/cmp-path'},
      {'saadparwaiz1/cmp_luasnip'}, {'hrsh7th/cmp-nvim-lsp'},
      {'hrsh7th/cmp-nvim-lua'}, -- Snippets
      {'L3MON4D3/LuaSnip'}, {'rafamadriz/friendly-snippets'}
    },
    config = function()
      local lsp = require('lsp-zero').preset({
        float_border = 'single',
        call_servers = 'local',
        configure_diagnostics = true,
        setup_servers_on_start = true,
        set_lsp_keymaps = {
          preserve_mappings = false,
          omit = {'<CR>', '<F4>'}
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
  use {
    'willothy/nvim-cokeline',
    requires = {
      'nvim-lua/plenary.nvim' -- Required for v0.4.0+
    },
    config = function()
      local get_hex = require('cokeline/hlgroups').get_hl_attr
      local cokeline = require('cokeline')
      cokeline.setup({
        rendering = {
          max_buffer_width = 50 -- Buffer width truncated to this. default: `999`.
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
          bg = get_hex('Normal', 'bg')
        },
        components = {
          -- index
          {
            text = function(buffer)
              return ' ' .. buffer.index .. ' '
            end
          }, -- filename
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
            underline = function(buffer) return buffer.is_focused end,
          },
          {text = ' '}
        }
      })

      vim.keymap.set('n', '<Leader>n', '<Plug>(cokeline-focus-next)')
      vim.keymap.set('n', '<Leader>N', '<Plug>(cokeline-focus-prev)')
      for i = 1,9 do
        vim.keymap.set('n', ('<Leader>%s'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i),  { silent = true })
        vim.keymap.set('n', ('<C-%s>'):format(i), ('<Plug>(cokeline-focus-%s)'):format(i),  { silent = true })
      end

    end
  }
  use {
    'weilbith/nvim-code-action-menu',
    config = function()
      vim.g.code_action_menu_show_details = false
      vim.g.code_action_menu_show_diff = true
      vim.g.code_action_menu_show_action_kind = true
      vim.g.code_action_menu_border_cindoc = 'single'
      vim.keymap.set({'n', 'v'}, '<F4>', '<CMD>CodeActionMenu<CR>')
    end,
    cmd = 'CodeActionMenu'
  }
  use {
    'ggandor/leap.nvim',
    config = function()
      local leap = require('leap')
      leap.add_default_mappings()
      leap.opts.highlight_unlabeled_phase_one_targets = true
      leap.opts.safe_labels = {}
    end
  }
  use {
    'ggandor/flit.nvim',
    requires = {'ggandor/leap.nvim'},
    config = function()
      require('flit').setup()
    end
  }
  use {
    'ggandor/leap-spooky.nvim',
    requires = {'ggandor/leap.nvim'},
    config = function()
      require('leap-spooky').setup()
      vim.opt.timeout = false
      -- vim.opt.timeoutlen = 5000 -- Timeout on mapping after 3 seconds.
      -- vim.opt.ttimeoutlen = 5000 -- Timeout on keycode after 1 second.
    end
  }
  use {
    'ggandor/leap-ast.nvim',
    requires = {'ggandor/leap.nvim', 'nvim-treesitter/nvim-treesitter'},
    config = function()
      local leap_ast = require('leap-ast')
      vim.keymap.set({'n', 'x', 'o'}, '<Leader>s', leap_ast.leap, {})
    end
  }
  use {
    'nvim-telescope/telescope.nvim', tag = '0.1.x',
    requires = { {'nvim-lua/plenary.nvim'} },
    config = function ()
      -- https://github.com/nvim-telescope/telescope.nvim

      local builtin = require('telescope.builtin')
      vim.keymap.set('n', '<leader>ff', builtin.oldfiles, {})
      vim.keymap.set('n', '<leader>fF', builtin.find_files, {})
      vim.keymap.set('n', '<leader>fc', builtin.lsp_incoming_calls, {})
      vim.keymap.set('n', '<leader>fC', builtin.lsp_outgoing_calls, {})
      vim.keymap.set('n', '<leader>fr', builtin.lsp_references, {})
      vim.keymap.set('n', '<leader>fs', builtin.lsp_document_symbols, {})
      vim.keymap.set('n', '<leader>fS', builtin.lsp_dynamic_workspace_symbols, {})
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
      vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
      vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
    end
  }
  use {
    "nvimdev/guard.nvim",
    requires = { {'nvimdev/guard-collection'} },
    config = function()
      local ft = require('guard.filetype')
      ft('python'):fmt('ruff'):lint('ruff')
      vim.keymap.set({'n', 'v'}, 'gq', '<Cmd>GuardFmt<CR>')
      require('guard').setup({})
    end
  }
  use({
    "epwalsh/obsidian.nvim",
    tag = "*",  -- recommended, use latest release instead of latest commit
    requires = {
      -- Required.
      "nvim-lua/plenary.nvim",
      'nvim-telescope/telescope.nvim',
      -- see below for full list of optional dependencies
    },
    config = function()
      local obsidian = require("obsidian")
      obsidian.setup({
        workspaces = {
          {
            name = "daniel",
            path = "~/Documents/obsidian/daniel",
          },
        },
        mappings = {
          [ "gd" ] = {
            action = obsidian.util.gf_passthrough,
            opts = { noremap = false, expr = true, buffer = true },
          },
          [ "gf" ] = {
            action = obsidian.util.gf_passthrough,
            opts = { noremap = false, expr = true, buffer = true },
          },
          [ "<leader>ot" ] = {
            action = obsidian.util.toggle_checkbox,
            opts = { buffer = true },
          }
        },
        follow_url_func = function(url)
          -- vim.fn.jobstart({"open", url})  -- Mac OS
          vim.fn.jobstart({"xdg-open", url})  -- linux
        end,
        use_path_only = true,
        note_id_func = function(title)
          -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
          -- In this case a note with the title 'My new note' will be given an ID that looks
          -- like '1657296016-my-new-note', and therefore the file name '1657296016-my-new-note.md'
          local suffix = ""
          if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
          else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          -- return tostring(os.time()) .. "-" .. suffix
          return title
        end,
        -- see below for full list of options
      })
    end,
  })

end)
