-- set vim runtime paths for compatibility
vim.cmd [[
  set runtimepath^=~/.vim runtimepath+=~/.vim/after
  let &packpath = &runtimepath
]]

-- load legacy settings first
vim.cmd 'silent! source ~/.virc'
vim.cmd 'silent! source ~/.vimrc'

-- load lua settings
require('mynvim').load()
