local function url(route)
    return 'https://github.com/' .. route
end

vim.pack.add({
    { src = url('catppuccin/nvim') },
    { src = url('stevearc/oil.nvim') }, -- uses mini.icons
    { src = url('folke/which-key.nvim') },
    { src = url('nvim-telescope/telescope.nvim'), version = '0.1.8' }, -- uses plenary.nvim
    { src = url('nvim-lua/plenary.nvim') },
    { src = url('lewis6991/gitsigns.nvim') },
    { src = url('echasnovski/mini.hipatterns') },
    { src = url('echasnovski/mini.icons') },
    { src = url('echasnovski/mini.comment') },
    { src = url('echasnovski/mini.pairs') },
    { src = url('echasnovski/mini.statusline') },
    { src = url('echasnovski/mini.surround') },
    { src = url('echasnovski/mini.move') },
    { src = url('echasnovski/mini.trailspace') },
    { src = url('hrsh7th/nvim-cmp') },
    { src = url('L3MON4D3/LuaSnip') },
    { src = url('hrsh7th/cmp-nvim-lsp') },
    { src = url('hrsh7th/cmp-buffer') },
    { src = url('hrsh7th/cmp-path') },
    { src = url('hrsh7th/cmp-cmdline') },
    { src = url('saadparwaiz1/cmp_luasnip') }

})
