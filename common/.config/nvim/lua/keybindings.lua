
-- Remap leader key
vim.cmd 'let mapleader=" "'

-- Set paste toggle
vim.o.pastetoggle = '<F2>'

-- Smart Home key
vim.cmd [[
noremap  <expr> <Home> col('.') == match(getline('.'), '\S') + 1 ? "\<Home>" : "^"
inoremap <expr> <Home> col('.') == match(getline('.'), '\S') + 1 ? "\<Home>" : "\<C-O>^"
]]

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

-- Move lines around in visual mode
vim.cmd [[
vmap <unique> <A-k>    <Plug>SchleppUp
vmap <unique> <A-j>    <Plug>SchleppDown
vmap <unique> <A-h>    <Plug>SchleppLeft
vmap <unique> <A-l>    <Plug>SchleppRight
vmap <unique> <C-k>    <Plug>SchleppDupUp
vmap <unique> <C-j>    <Plug>SchleppDupDown
vmap <unique> <C-h>    <Plug>SchleppDupLeft
vmap <unique> <C-l>    <Plug>SchleppDupRight
]]

local mappings = {
  i = { -- Insert mode

    -- Autocomplete
    -- FIXME: Doesn't work
    { '<esc>', [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, silent = true, noremap = true }},
    { '<c-c>', [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, silent = true, noremap = true }},
    { '<Tab>', [[pumvisible() ? "<c-n>" : "<Tab>"]], { expr = true, silent = true, noremap = true}},
    { '<S-Tab>', [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, silent = true, noremap = true}},

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
    { "<F8>", "<cmd>TagbarToggle<CR>" },
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
    { "<leader>gd", "<cmd>Telescope lsp_definitions<cr>" },
    { "<leader>gi", "<cmd>Telescope lsp_implementations<cr>" },
    { "<leader>gr", "<cmd>Telescope lsp_references<cr>" },
    { "<leader>ggl", "<cmd>Telescope git_commits<cr>" },
    { "<leader>ggc", "<cmd>Telescope git_bcommits<cr>" },
    { "<leader>ggb", "<cmd>Telescope git_branches<cr>" },
    { "<leader>ggs", "<cmd>Telescope git_status<cr>" },

    -- Document actions
    { "<leader>aa", "<cmd>lua vim.lsp.buf.code_action()<cr>" },
    { "<leader>ar", "<cmd>lua vim.lsp.buf.rename()<cr>"},
    { "<leader>af", "<cmd>lua vim.lsp.buf.formatting()<cr>" },

    --  Find
    --  Symbols
    { "<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>" },
    { "<leader>fws", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>" },
    { "<leader>fdd", "<cmd>Telescope diagnostics bufnr=0<cr>" },
    { "<leader>fdl", "<cmd>Telescope loclist<cr>" },
    { "<leader>fwd", "<cmd>Telescope diagnostics<cr>" },
    --  Files
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>" },

    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>" },
    { "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>" },
    { "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>" },
    { "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>" },
    { "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>" },

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
