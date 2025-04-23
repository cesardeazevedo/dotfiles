return {
  { -- You can easily change to a different colorscheme.
    'folke/tokyonight.nvim',
    priority = 1000,
    init = function()
      -- vim.cmd.colorscheme 'tokyonight-night'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    lazy = false,
    config = function()
      require('github-theme').setup {
        groups = {
          all = {
            fugitiveUnstagedModified = { fg = '#FF0000' },
            fugitiveUnstagedDelete = { fg = '#FF0000' },
            fugitiveUnstagedAdd = { fg = '#FF0000' },
            fugitiveStagedModified = { fg = '#FF0000' },
            fugitiveStagedDelete = { fg = '#FF0000' },
            fugitiveStagedAdd = { fg = '#FF0000' },
          },
          github_dark_default = {
            CursorLine = { bg = '#29303d' },
          },
        },
      }
      vim.cmd.colorscheme 'github_dark_default'

      local minimal_white_mode = {
        normal = {
          a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
          b = { fg = nil, bg = nil },
          c = { fg = nil, bg = nil },
        },
        insert = {
          a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
        },
        visual = {
          a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
        },
        replace = {
          a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
        },
        command = {
          a = { fg = '#000000', bg = '#ffffff', gui = 'bold' },
        },
        inactive = {
          a = { fg = '#888888', bg = '#f5f5f5' },
          b = { fg = nil, bg = nil },
          c = { fg = nil, bg = nil },
        },
      }

      require('lualine').setup {
        options = {
          theme = minimal_white_mode,
        },
      }
    end,
  },

  { 'neanias/everforest-nvim' },

  { 'Mofiqul/dracula.nvim' },

  { 'scottmckendry/cyberdream.nvim' },
}
