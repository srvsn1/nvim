local function url(route)
    return 'https://github.com/' .. route
end

vim.pack.add({
    { src = url('catppuccin/nvim') },
    { src = url('stevearc/oil.nvim') },
    { src = url('folke/which-key.nvim') },
    { src = url('nvim-mini/mini.icons') }
})
