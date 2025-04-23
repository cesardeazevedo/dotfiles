return {
  {
    'nanozuki/tabby.nvim',
    event = 'VimEnter',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      {
        '<leader><tab>r',
        function()
          vim.ui.input({
            prompt = 'Rename Tab',
            telescope = require('telescope.themes').get_cursor(),
          }, function(selected)
            require('tabby').tab_rename(selected)
          end)
        end,
        desc = 'Rename Tab',
      },
    },
    config = function()
      local theme = {
        fill = 'Normal',
        head = 'Cursor',
        current_tab = 'Cursor',
        win = 'Cursor',
      }
      require('tabby.tabline').set(function(line)
        return {
          {
            { '  ', hl = theme.head },
          },
          line.tabs().foreach(function(tab)
            local hl = tab.is_current() and theme.current_tab or theme.fill
            return {
              tab.is_current() and ' ' or ' ',
              margin = ' ',
              tab.name(),
              tab.close_btn '',
              line.sep('', hl, theme.fill),
              hl = hl,
            }
          end),
          line.spacer(),
          line.wins_in_tab(line.api.get_current_tab()).foreach(function(win)
            return {
              line.sep('', theme.win, theme.fill),
              win.is_current() and ' ' or ' ',
              win.buf_name(),
              line.sep('', theme.win, theme.fill),
              hl = theme.win,
            }
          end),
          {
            line.sep('', theme.current_tab, theme.fill),
            { '  ', hl = theme.current_tab },
          },
          hl = theme.fill,
        }
      end)
    end,
  },
}
