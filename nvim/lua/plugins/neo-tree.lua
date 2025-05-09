return {
  {
    'nvim-neo-tree/neo-tree.nvim',
    lazy = false,
    branch = 'v3.x',
    cmd = 'Neotree',
    dependencies = {
      'nvim-lua/plenary.nvim',
      {
        'nvim-tree/nvim-web-devicons',
        opts = {
          override_by_extension = {
            rei = { icon = "", color = "#dd4b39", name = "ReasonReact" },
            re  = { icon = "", color = "#dd4b39", name = "Reason" },
          },
        },
      }, -- not strictly required, but recommended
      'MunifTanjim/nui.nvim',
    },
    keys = {
      {
        '<leader>fe',
        function()
          require('neo-tree.command').execute {
            toggle = true,
            reveal = true,
          }
          -- require("neo-tree.command").execute({ toggle = true, reveal = true  })
        end,
        desc = 'Explorer NeoTree (Root Dir)',
      },
      -- take this out, the cwd and root are always the same
      {
        '<leader>fE',
        function()
          require('neo-tree.command').execute { toggle = true, dir = vim.uv.cwd(), reveal = true }
        end,
        desc = 'Explorer NeoTree (cwd)',
      },
      { '<leader>e', '<leader>fe', desc = 'Explorer NeoTree (Root Dir)', remap = true },
      { '<leader>E', '<leader>fE', desc = 'Explorer NeoTree (cwd)',      remap = true },
      {
        '<leader>ge',
        function()
          require('neo-tree.command').execute { source = 'git_status', toggle = true }
        end,
        desc = 'Git explorer',
      },
      {
        '<leader>be',
        function()
          require('neo-tree.command').execute { source = 'buffers', toggle = true }
        end,
        desc = 'Buffer explorer',
      },
    },
    deactivate = function()
      vim.cmd [[Neotree close]]
    end,
    opts = {
      sources = { 'filesystem', 'buffers', 'git_status', 'document_symbols' },
      open_files_do_not_replace_types = { 'terminal', 'Trouble', 'trouble', 'qf', 'Outline' },
      filesystem = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        bind_to_cwd = false,
        cwd_target = {
          sidebar = 'none', -- sidebar is when position = left or right
          current = 'none', -- current is when position = current
        },
        use_libuv_file_watcher = true,
      },
      window = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        mappings = {
          -- ["o"] = nil,
          ['<space>'] = 'none',
          ['Y'] = function(state)
            local node = state.tree:get_node()
            local path = node:get_id()
            vim.fn.setreg('+', path, 'c')
          end,
        },
      },
      buffers = {
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        window = {
          mappings = {
            ['o'] = nil,
          },
        },
      },
      default_component_configs = {
        indent = {
          with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
          expander_collapsed = '',
          expander_expanded = '',
          expander_highlight = 'NeoTreeExpander',
        },
      },
    },
    config = function(_, opts)
      local function on_move(data)
        -- Util.lsp.on_rename(data.source, data.destination)
      end
      local events = require 'neo-tree.events'
      opts.event_handlers = opts.event_handlers or {}
      opts.window = {
        width = 35,
        position = 'left',
      }
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED,   handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })

      require('neo-tree').setup(opts)

      vim.api.nvim_create_autocmd('TermClose', {
        pattern = '*lazygit',
        callback = function()
          if package.loaded['neo-tree.sources.git_status'] then
            require('neo-tree.sources.git_status').refresh()
          end
        end,
      })
    end,
  },
}
