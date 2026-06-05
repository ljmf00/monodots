-- bootstrap M global variable
local M = {}

-- set echo utility
M.echo = function(str)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

-- load myvim module and bootstrap all settings, plugins and keybinds
M.load = function()
  -- enable treesitter highlighting for all filetypes
  vim.api.nvim_create_autocmd('FileType', {
    callback = function(args)
      local ft = vim.bo[args.buf].filetype
  
      local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
      if ok and lang then
        pcall(vim.treesitter.start, args.buf)
      end
    end,
  })

  local install_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(install_path) then
    --------- lazy.nvim ---------------
    M.echo "  Installing lazy.nvim & plugins ..."
    local repo = "https://github.com/folke/lazy.nvim.git"
    vim.fn.system { "git", "clone", "--filter=blob:none", "--branch=stable", repo, install_path }
  end

  -- add lazy to the plugins path
  vim.opt.rtp:prepend(install_path)

  -- install plugins
  require('lazy')
    .setup({
    -- lazy nvim plugin
    {
      dir = '~/monodots/dist/3rdparty/nvim/lazy.nvim',
      lazy = false,
      priority = 1000,
    },

    -- buffer line
    {
      dir = '~/monodots/dist/3rdparty/nvim/barbar.nvim',
      dependencies = {
        'lewis6991/gitsigns.nvim',
      },
      init = function() vim.g.barbar_auto_setup = false end,
      opts = {
        icons = {
          button   = 'x',
          inactive = { button = 'x' },
          filetype = {
            enabled = false,
          },
          separator = { left = '|', right = '' },
          modified  = { button = '*' },
        }
      },
    },

    -- light line
    {
      'itchyny/lightline.vim',
      lazy = false,
      init = function()
        vim.g['lightline'] = {
              colorscheme = 'simple',
              active = {
                    left = {
                          { 'mode', 'paste' },
                          { 'gitbranch', 'readonly', 'filename', 'modified' }
                    }
              },
              component_function = {
                gitbranch = 'FugitiveHead'
              },
        }
      end,
    },

    -- Tagbar
    {
      'preservim/tagbar',
      cmd = "TagbarToggle",
      tag = 'v3.0.0',
      init = function()
        vim.g['tagbar_autofocus'] = 1
      end,
    },

    -- move lines around
    {
      dir = '~/monodots/dist/3rdparty/vim/schlepp',
      init = function()
        vim.cmd [[
          silent! vmap <unique> <A-k> <Plug>SchleppUp
          silent! vmap <unique> <A-j> <Plug>SchleppDown
          silent! vmap <unique> <A-h> <Plug>SchleppLeft
          silent! vmap <unique> <A-l> <Plug>SchleppRight
          silent! vmap <unique> <C-k> <Plug>SchleppDupUp
          silent! vmap <unique> <C-j> <Plug>SchleppDupDown
          silent! vmap <unique> <C-h> <Plug>SchleppDupLeft
          silent! vmap <unique> <C-l> <Plug>SchleppDupRight
        ]]
      end,
    },

    ---- surround fast change
    {
      dir = '~/monodots/dist/3rdparty/vim/surround',
      event = "InsertEnter",
    },

    ---- auto indentation
    {
      dir = '~/monodots/dist/3rdparty/vim/sleuth',
      event = "BufRead",
    },

    -- text colorizer
    "NvChad/nvim-colorizer.lua",

    -- comments
    "numToStr/Comment.nvim",

    -- Indent guidelines
    {
      "lukas-reineke/indent-blankline.nvim",
      config = function()
        require("ibl").setup()
      end,
    },

    -- which keys popup plugin
    {
      'folke/which-key.nvim',
      event = "VeryLazy",
      opts = {},
    },

    {
      "nvim-tree/nvim-tree.lua",
      cmd = { "NvimTreeOpen", "NvimTreeClose", "NvimTreeToggle", "NvimTreeFocus" },
      opts = function()
        return {
          filters = {
            dotfiles = false,
            exclude = { vim.fn.stdpath "config" .. "/lua/custom" },
          },
          disable_netrw = true,
          hijack_netrw = true,
          hijack_cursor = true,
          hijack_unnamed_buffer_when_opening = false,
          sync_root_with_cwd = true,
          update_focused_file = {
            enable = true,
            update_root = false,
          },
          view = {
            adaptive_size = false,
            side = "left",
            width = 30,
            preserve_window_proportions = true,
            side = 'left',
            number = false,
            relativenumber = false
          },
          git = {
            enable = true,
            ignore = true,
            timeout = 500,
          },
          filesystem_watchers = {
            enable = true,
          },
          actions = {
            open_file = {
              resize_window = true,
              quit_on_open = true,
            },
          },
          renderer = {
            root_folder_label = true,
            highlight_git = true,
            highlight_opened_files = "none",

            indent_markers = {
              enable = false,
            },

            icons = {
              show = {
                file = true,
                folder = true,
                folder_arrow = true,
                git = true,
              },

              glyphs = {
                default = "F",
                symlink = "S",
                folder = {
                  default = "D",
                  open = "D",
                  empty = "E",
                  empty_open = "E",
                  symlink = "S",
                  symlink_open = "S",
                  arrow_open = "",
                  arrow_closed = "",
                },
                git = {
                  unstaged = "*",
                  staged = "+",
                  unmerged = "%",
                  renamed = ">",
                  untracked = "?",
                  deleted = "-",
                  ignored = "!",
                },
              },
            },
          },
        }
      end,
      config = function(_, opts)
        require("nvim-tree").setup(opts)
        vim.g.nvimtree_side = opts.view.side
      end,
    },

    -- Autopairs
    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      opts = function()
        return {
          map_bs = false,
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        }
      end,
    },

    -- Git Support
    { dir = '~/monodots/dist/3rdparty/vim/fugitive' },

    {
      'lewis6991/gitsigns.nvim',
      ft = { "gitcommit", "diff" },
      tag = 'v0.5',
      dependencies = {
        { dir = '~/monodots/dist/3rdparty/nvim/plenary' },
      },
      init = function()
        -- load gitsigns only when a git file is opened
        vim.api.nvim_create_autocmd({ "BufRead" }, {
          group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
          callback = function()
            vim.fn.system("git -C " .. '"' .. vim.fn.expand "%:p:h" .. '"' .. " rev-parse")
            if vim.v.shell_error == 0 then
              vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
              vim.schedule(function()
                require("lazy").load { plugins = { "gitsigns.nvim" } }
              end)
            end
          end,
        })
      end,
      opts = function()
        return {
          current_line_blame = true,
          current_line_blame_opts = {
            virt_text = true,
            virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
            delay = 1000,
            ignore_whitespace = false,
          },
        }
      end,
    },

    -- LSP Support
    {
      dir = '~/monodots/dist/3rdparty/nvim/lspconfig',
      event = "BufRead",
      dependencies = {
        'hrsh7th/cmp-nvim-lsp',
      },
      config = function()
        local capabilities = require('cmp_nvim_lsp').default_capabilities({
          snippetSupport = true
        })

        local lspc = require('lspconfig')

        lspc.vimls.setup({ capabilities = capabilities })
        lspc.clangd.setup({ capabilities = capabilities })
        lspc.serve_d.setup({ capabilities = capabilities })
        lspc.jedi_language_server.setup({ capabilities = capabilities })
      end,
    },

    {
      "williamboman/mason-lspconfig.nvim",
      dependencies = {
        "williamboman/mason.nvim",
      },
      cmd = { "LspInstall", "LspUninstall" },
      lazy = true,
    },

    {
      "williamboman/mason.nvim",
      cmd = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog" },
      build = ":MasonUpdate",
      opts = function()
        return {
          ensure_installed = {
            "lua-language-server",
            "serve-d",
            "shellcheck",
            "tree-sitter-cli",
            "typescript-language-server",
            "jedi-language-server",
          },

          PATH = "skip",

          ui = {
            icons = {
              package_pending = " ",
              package_installed = "󰄳 ",
              package_uninstalled = " 󰚌",
            },

            keymaps = {
              toggle_server_expand = "<CR>",
              install_server = "i",
              update_server = "u",
              check_server_version = "c",
              update_all_servers = "U",
              check_outdated_servers = "C",
              uninstall_server = "X",
              cancel_installation = "<C-c>",
            },
          },

          max_concurrent_installers = 10,
        }
      end,
    },

    -- Autocomplete
    {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
        "windwp/nvim-autopairs",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
      },
      config = function()
        local cmp = require'cmp'

        cmp.setup{
          sources = {
            {name = 'path'},
            {name = 'nvim_lsp', keyword_length = 3},
            {name = 'buffer', keyword_length = 3},
          },
          window = {
            documentation = cmp.config.window.bordered()
          },
          formatting = {
            fields = {'menu', 'abbr', 'kind'},
            format = function(entry, item)
              local menu_icon = {
                nvim_lsp = 'λ',
                luasnip = '⋗',
                buffer = 'Ω',
                path = '🖫',
              }

              item.menu = menu_icon[entry.source.name]
              return item
            end,
          },
          mapping = cmp.mapping.preset.insert({
            ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
            ['<Down>'] = cmp.mapping.select_next_item(select_opts),

            ['<C-p>'] = cmp.mapping.select_prev_item(select_opts),
            ['<C-n>'] = cmp.mapping.select_next_item(select_opts),
            ['<C-Space>'] = cmp.mapping.complete(),
            ['<C-e>'] = cmp.mapping.abort(),
            ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
            ['<Tab>'] = cmp.mapping(function(fallback)
              local col = vim.fn.col('.') - 1

              if cmp.visible() then
                cmp.select_next_item(select_opts)
              elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
              else
                cmp.complete()
              end
            end, {'i', 's'}),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item(select_opts)
              else
                fallback()
              end
            end, {'i', 's'}),
          }),
        }

        -- setup cmp for autopairs
        local cmp_autopairs = require "nvim-autopairs.completion.cmp"
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end,
    },

    -- telescope fuzzy finder
    {
      dir = '~/monodots/dist/3rdparty/nvim/telescope',
      cmd = "Telescope",

      dependencies = {
        { dir = '~/monodots/dist/3rdparty/nvim/plenary' },
        'nvim-lua/popup.nvim',
        'BurntSushi/ripgrep',

        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        { 'nvim-telescope/telescope-media-files.nvim' },
      },

      config = function()
        local telescope = require('telescope')
        local telescopeConfig = require("telescope.config")

        -- Clone the default Telescope configuration
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.git/*")

        telescope.setup{
          defaults = {
            vimgrep_arguments = vimgrep_arguments,
            prompt_prefix = "> ",
            selection_caret = "> ",
            entry_prefix = "  ",
            initial_mode = "insert",
            selection_strategy = "reset",
            sorting_strategy = "descending",
            layout_strategy = "horizontal",
            layout_config = {
              horizontal = {
                mirror = false,
              },
              vertical = {
                mirror = false,
              },
            },
            file_sorter =  require'telescope.sorters'.get_fuzzy_file,
            file_ignore_patterns = {},
            generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
            winblend = 0,
            border = {},
            borderchars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' },
            color_devicons = true,
            use_less = true,
            path_display = {},
            set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
            file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
            grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
            qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

            -- Developer configurations: Not meant for general override
            buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
          },
          pickers = {
            find_files = {
              -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
              find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
            },
          },
          extensions = {
            fzf = {
              fuzzy = true,                    -- false will only do exact matching
              override_generic_sorter = true,  -- override the generic sorter
              override_file_sorter = true,     -- override the file sorter
              case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                                              -- the default case_mode is "smart_case"
            }
          }
        }

        telescope.load_extension('fzf')
      end,
    },

    -- zettelkasten
    {
      'renerocksai/telekasten.nvim',
      dependencies = {'nvim-telescope/telescope.nvim'},
      config = function()
        require('telekasten').setup({
          home = vim.fn.expand("~/zettelkasten"),
        })
      end,
    },

    -- github copilot
    { 'github/copilot.vim' },

    -- Treesitter
    {
      'nvim-treesitter/nvim-treesitter',
      cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      event = "BufRead",
      build = ":TSUpdate",
      opts = function()
        return {
          ensure_installed = {
            "bash",
            "c",
            "c_sharp",
            "cmake",
            "cpp",
            "css",
            "d",
            "go",
            "javascript",
            "json",
            "kotlin",
            "latex",
            "llvm",
            "lua",
            "make",
            "ninja",
            "php",
            "proto",
            "r",
            "ruby",
            "rust",
            "scala",
            "scss",
            "toml",
            "verilog",
            "vim",
            "vue",
            "yaml",
            "zig",
          },
          sync_install = false,
          auto_install = true,

          autopairs = {
            enable = true,
          },

          highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
          },
        }
      end,
    },
  })

  -- load lua-based keybinds
  vim.cmd [[
    function! QuickFixToggle()
      if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
      else
        cclose
      endif
  endfunction
  ]]

  _G.MUtils= {}

  local hasnpairs,npairs = pcall(require,"nvim-autopairs")

  if hasnpairs then
    MUtils.CR = function()
      if vim.fn.pumvisible() ~= 0 then
        if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
          return npairs.esc('<c-y>')
        else
          return npairs.esc('<c-e>') .. npairs.autopairs_cr()
        end
      else
        return npairs.autopairs_cr()
      end
    end
    vim.api.nvim_set_keymap('i', '<cr>', 'v:lua.MUtils.CR()', { expr = true, noremap = true })

    MUtils.BS = function()
      if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ 'mode' }).mode == 'eval' then
        return npairs.esc('<c-e>') .. npairs.autopairs_bs()
      else
        return npairs.autopairs_bs()
      end
    end
    vim.api.nvim_set_keymap('i', '<bs>', 'v:lua.MUtils.BS()', { expr = true, noremap = true })
  end

  local mappings = {
    i = { -- Insert mode

      { "<A-j>", "<ESC><cmd>m .+1<CR>==gi" },
      { "<A-k>", "<ESC><cmd>m .-2<CR>==gi" },

      -- Save while writing
      { "<C-s>", "<ESC><C-s>", { noremap = false }},
    },
    n = { -- Normal mode

      -- Remove trailing whitespaces and save
      { "<C-s>", "<cmd>%s/\\s\\+$//e<cr><cmd>w<cr>" },

      -- Toggle spell
      { "<F1>", "<cmd>set spell!<CR>" },

      -- Toggle Highlighted search
      { "<F3>", "<cmd>set hlsearch!<CR>" },
      -- Build
      { "<F5>", "<cmd>make<cr>" },
      -- Toogle Tagbar
      { "<F8>", "<cmd>TagbarToggle<cr>" },
      -- Float Terminal
      { "<F12>", "<cmd>FloatermToggle<cr>", { silent = true, noremap = true } },

      -- Make d(elete) and similar actually delete
      { "\\d", "\"_d" },
      { "\\D", "\"_D" },
      { "\\x", "\"_x" },
      { "\\c", "\"_c" },

      -- Navigation

      --  Tree
      { "<leader>vt", "<cmd>NvimTreeToggle<cr>" },

      -- Command palette
      { "<leader>vp", "<cmd>Telescope<cr>" },
      -- View Telekasten panel
      { "<leader>vz", "<cmd>Telekasten panel<cr>" },


      -- View
      --  Reset view
      { "<leader>vr",
        table.concat({
          "<cmd>NvimTreeOpen<cr>",
          "<cmd>windo set nonumber<cr>",
          "<cmd>windo set norelativenumber<cr>",
          "<cmd>windo set nolist<cr>",
          "<cmd>NvimTreeClose<cr>",
          "<cmd>tabdo windo set number<cr>",
          "<cmd>tabdo windo set list<cr>",
          "<cmd>tabdo windo set colorcolumn=80<cr>",
          }, ''
        );
      },

      --  Buffers
      { "<C-n>b", "<cmd>bn<cr>" },
      { "<C-p>b", "<cmd>bp<cr>" },

      --  Diagnostics
      { "<C-p>d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>" },
      { "<C-n>d", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>" },

      --  LSP Hover description
      { "<C-Space>", "<cmd>lua vim.lsp.buf.hover()<cr>" },
      { "<A-Space>", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>" },

      --  Goto symbol
      { "<leader>gD", "<cmd>lua vim.lsp.buf.declaration()<cr>" },
      { "<leader>gdd", "<cmd>Telescope lsp_definitions<cr>" },
      { "<leader>gdt", "<cmd>Telescope lsp_type_definitions<cr>" },
      { "<leader>gi", "<cmd>Telescope lsp_implementations<cr>" },
      { "<leader>gr", "<cmd>Telescope lsp_references<cr>" },

      -- Git
      { "<leader>GC", "<cmd>Telescope git_commits<cr>" },
      { "<leader>Gc", "<cmd>Telescope git_bcommits<cr>" },
      { "<leader>Gb", "<cmd>Telescope git_branches<cr>" },
      { "<leader>Gs", "<cmd>Telescope git_status<cr>" },

      -- Document actions
      { "<leader>aa", "<cmd>lua vim.lsp.buf.code_action()<cr>" },
      { "<leader>ar", "<cmd>lua vim.lsp.buf.rename()<cr>"},
      { "<leader>af", "<cmd>lua vim.lsp.buf.formatting()<cr>" },

      --  Find
      { "<leader>ff", "<cmd>Telescope find_files<cr>" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
      { "<leader>fd", "<cmd>Telescope lsp_document_symbols<cr>" },
      { "<leader>fw", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" },
      { "<leader>fs", "<cmd>Telescope grep_string<cr>" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>" },
      { "<leader>fp", "<cmd>Telescope diagnostics bufnr=0<cr>" },
      { "<leader>fP", "<cmd>Telescope diagnostics<cr>" },
      { "<leader>fH", "<cmd>Telescope help_tags<cr>" },

      { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>" },
      { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>" },
      { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>" },
      { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>" },
      { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>" },
      { "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>" },
      { "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>" },
      { "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>" },
      { "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>" },

      -- Telekasten
      { "<leader>zf", "<cmd>Telekasten find_notes<cr>" },
      { "<leader>zg", "<cmd>Telekasten search_notes<cr>" },
      { "<leader>zd", "<cmd>Telekasten goto_today<cr>" },
      { "<leader>zn", "<cmd>Telekasten new_note<cr>" },
      { "<leader>zc", "<cmd>Telekasten show_calendar<cr>" },
      { "<leader>zb", "<cmd>Telekasten show_backlinks<cr>" },
      { "<leader>zi", "<cmd>Telekasten insert_link<cr>" },
      { "<leader>zI", "<cmd>Telekasten insert_img_link<cr>" },

      --  Move lines up and down
      { "<A-j>", "<cmd>m .+1<CR>=="},
      { "<A-k>", "<cmd>m .-2<CR>=="},
    },

    v = {
      -- Delete to void register
      { "\\d", "\"_d" },
      { "\\c", "\"_c" },
      { "\\p", "\"_dp" },
      { "\\P", "\"_dP" },
      { "\\/", "\"fy/<C-R>f", { silent = false }},
      { "<C-a>", "<ESC>ggVG"},

      -- Keep visual mode on Tab and S-Tab
      { "<Tab>", ">gv" },
      { "<S-Tab>", "<gv" },
    },
    t = {
      -- Toggle float terminal
      { "<F12>", "<C-\\><C-n><cmd>FloatermToggle<cr>", { silent = true, noremap = true } },
    },
    [""] = {
      -- Toggle the QuickFix window
      { "<C-q>", "<cmd>call QuickFixToggle()<CR>" },
    },
  }

  -- register the set mappings
  local function register_mappings(mappings, default_options)
    for mode, mode_mappings in pairs(mappings) do
      for _, mapping in pairs(mode_mappings) do
        local options = #mapping == 3 and table.remove(mapping) or default_options
        local prefix, cmd = unpack(mapping)
        pcall(vim.api.nvim_set_keymap, mode, prefix, cmd, options)
      end
    end
  end

  register_mappings(mappings, { silent = true, noremap = true })
end

return M
