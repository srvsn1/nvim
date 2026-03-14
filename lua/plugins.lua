local function url(route)
    return 'https://github.com/' .. route
end

vim.pack.add({
    { src = url('catppuccin/nvim') },
    { src = url('stevearc/oil.nvim') }, -- uses mini.icons
    { src = url('folke/which-key.nvim') },
    { src = url('nvim-mini/mini.icons') },
    { src = url('nvim-telescope/telescope.nvim'), version = '0.1.8' }, -- uses plenary.nvim
    { src = url('nvim-lua/plenary.nvim') },
    { src = url('lewis6991/gitsigns.nvim') },
})
