---@param opts? {cwd:false, subdirectory: true, parent: true, other: true, icon?:string}
function root_dir(opts)
  opts = vim.tbl_extend('force', {
    cwd = true,
    subdirectory = true,
    parent = true,
    other = true,
    icon = '',
    -- color = Util.ui.fg 'Special',
  }, opts or {})

  local function get()
    local cwd = vim.fn.getcwd()
    local root = cwd
    --local root = Util.root.get { normalize = true }
    local name = vim.fs.basename(root)

    if root == cwd then
      -- root is cwd
      return opts.cwd and name
    elseif root:find(cwd, 1, true) == 1 then
      -- root is subdirectory of cwd
      return opts.subdirectory and name
    elseif cwd:find(root, 1, true) == 1 then
      -- root is parent directory of cwd
      return opts.parent and name
    else
      -- root and cwd are not related
      return opts.other and name
    end
  end

  return {
    function()
      return (opts.icon and opts.icon .. ' ') .. get()
    end,
    cond = function()
      return type(get()) == 'string'
    end,
    color = opts.color,
  }
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  event = 'VeryLazy',
  opts = function()
    local lualine_require = require 'lualine_require'
    lualine_require.require = require
    local icons = require('ui').icons
    return {
      options = {
        theme = 'auto',
        globalstatus = true,
        disabled_filetypes = { statusline = { 'dashboard', 'alpha', 'ministarter', 'snacks_dashboard' } },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          {
            'diagnostics',
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warn,
              info = icons.diagnostics.Info,
              hint = icons.diagnostics.Hint,
            },
          },
          root_dir(),
          { 'filetype', icon_only = true, separator = '', padding = { left = 2, right = 0 } },
          { 'filename', path = 1 },
        },
        lualine_x = {
          -- Snacks.profiler.status(),
          {
            function()
              return require('noice').api.status.command.get()
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.command.has()
            end,
            -- color = function()
            --   return { fg = Snacks.util.color 'Statement' }
            -- end,
          },
          {
            function()
              return require('noice').api.status.mode.get()
            end,
            cond = function()
              return package.loaded['noice'] and require('noice').api.status.mode.has()
            end,
            -- color = function()
            --   return { fg = Snacks.util.color 'Statement' }
            -- end,
          },
          {
            function()
              return '  ' .. require('dap').status()
            end,
            cond = function()
              return package.loaded['dap'] and require('dap').status() ~= ''
            end,
            -- color = function()
            --   return { fg = Snacks.util.color 'Debug' }
            -- end,
          },
          {
            require('lazy.status').updates,
            cond = require('lazy.status').has_updates,
            -- color = function()
            --   return { fg = Snacks.util.color 'Special' }
            -- end,
          },
          {
            'diff',
            symbols = {
              added = icons.git.added,
              modified = icons.git.modified,
              removed = icons.git.removed,
            },
            source = function()
              local gitsigns = vim.b.gitsigns_status_dict
              if gitsigns then
                return {
                  added = gitsigns.added,
                  modified = gitsigns.changed,
                  removed = gitsigns.removed,
                }
              end
            end,
          },
        },
        lualine_y = {
          { 'progress', separator = ' ',                  padding = { left = 1, right = 0 } },
          { 'location', padding = { left = 0, right = 1 } },
        },
        lualine_z = {
          function()
            return ' ' .. os.date '%R'
          end,
        },
      },
      extensions = { 'neo-tree', 'lazy', 'fzf' },
    }
  end,
}
