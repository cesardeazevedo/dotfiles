return {
  'rmagatti/auto-session',
  lazy = false,
  ---enables autocomplete for opts
  ---@module "auto-session"
  ---@type AutoSession.Config
  opts = {
    auto_create = true,
    auto_restore = false,
    enabled = true,
    session_lens = {
      previewer = true,
      theme_conf = {
        border = true,
      },
    },
    suppressed_dirs = {},
  },
}
