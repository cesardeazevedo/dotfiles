require 'options'
require 'autocmds'
require 'keymaps'
require 'neovide'

require('lazy').setup({
  { import = 'plugins' },
}, {
  ui = {
    icons = vim.g.have_nerd_font and {},
  },
})
