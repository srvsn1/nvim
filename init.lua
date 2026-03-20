require('general')
require('plugins')
require('events')
require('keymaps')

-- Load UI after VimEnter for faster startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    require('theme')
    require('cfg')
    require('ai')
  end,
})
