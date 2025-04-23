-- neovide settings https://neovide.dev/faq.html
if vim.g.neovide then
  vim.o.guifont = 'Monaco Nerd Font Mono:h18'
  vim.g.neovide_text_gamma = 0.5
  vim.g.neovide_cursor_trail_size = 0.3
  vim.g.neovide_cursor_animation_length = 0.04 -- 0.02
  vim.g.neovide_scroll_animation_length = 0.09 -- 0.08
  -- neovide background image (fork https://github.com/neovide/neovide/pull/3067)
  vim.g.neovide_opacity = 0.8
  vim.g.neovide_bgimage_opacity = 1
  vim.g.neovide_background_image = '~/.config/backgrounds/cyberpunk.png'
end
