return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim', 'nvim-telescope/telescope.nvim' },
  config = function()
    require('harpoon'):setup {
      settings = {},
    }
  end,
  keys = {
    {
      '<leader>a',
      function()
        require('harpoon'):list():add()
      end,
      desc = 'Harpoon Add Buffer',
    },
    {
      '<leader>d',
      function()
        require('harpoon'):list():remove()
      end,
      desc = 'Harpoon Delete Buffer',
    },
    {
      '<C-`>',
      function()
        local harpoon = require 'harpoon'
        local conf = require('telescope.config').values
        local function toggle_telescope(harpoon_files)
          local file_paths = {}
          for index, item in ipairs(harpoon_files.items) do
            table.insert(file_paths, { tostring(index), item.value })
          end

          require('telescope.pickers')
            .new({}, {
              initial_mode = 'normal',
              prompt_title = 'Harpoon 🔱',
              finder = require('telescope.finders').new_table {
                results = file_paths,
                entry_maker = function(entry)
                  return {
                    value = entry[2],
                    display = entry[1] .. ' - ' .. entry[2],
                    ordinal = entry[1] .. entry[2],
                  }
                end,
              },
              previewer = conf.file_previewer {},
              sorter = conf.generic_sorter {},
            })
            :find()
        end
        -- Without telescope
        -- harpoon.ui:toggle_quick_menu(harpoon:list())
        -- Telescope
        toggle_telescope(harpoon:list())
      end,
    },
    {
      '<D-1>',
      function()
        require('harpoon'):list():select(1)
      end,
    },
    {
      '<D-2>',
      function()
        require('harpoon'):list():select(2)
      end,
    },
    {
      '<D-3>',
      function()
        require('harpoon'):list():select(3)
      end,
    },
    {
      '<D-4>',
      function()
        require('harpoon'):list():select(4)
      end,
    },
    {
      '<D-5>',
      function()
        require('harpoon'):list():select(5)
      end,
    },
    {
      '<D-6>',
      function()
        require('harpoon'):list():select(6)
      end,
    },
    {
      '<D-7>',
      function()
        require('harpoon'):list():select(7)
      end,
    },
    {
      '<D-8>',
      function()
        require('harpoon'):list():select(8)
      end,
    },
    {
      '<D-9>',
      function()
        require('harpoon'):list():select(9)
      end,
    },
    {
      '<C-S-P>',
      function()
        require('harpoon'):list():prev()
      end,
    },
    {
      '<C-S-N>',
      function()
        require('harpoon'):list():next()
      end,
    },
  },
}
