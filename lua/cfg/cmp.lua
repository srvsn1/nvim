local cmp = require('cmp')
local luasnip = require('luasnip')

-- Setup luasnip with friendly snippets path
luasnip.setup({
    -- Add your custom snippet paths here
    -- Example: paths = { '~/.config/nvim/snippets', ... }
})

-- Load VSCode-style snippets from custom location if it exists
local snippet_path = vim.fn.stdpath('config') .. '/snippets'
if vim.fn.isdirectory(snippet_path) == 1 then
    require('luasnip.loaders.from_vscode').lazy_load({ paths = { snippet_path } })
end

-- Configure nvim-cmp
cmp.setup({
    -- Snippet engine configuration
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },

    -- Keymaps for completion menu
    mapping = cmp.mapping.preset.insert({
        -- Navigate through completion items with Tab/Shift+Tab
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { 'i', 's' }),

        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { 'i', 's' }),

        -- Confirm selection with Enter
        ['<CR>'] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),

        -- Additional useful keymaps
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
    }),

    -- Completion sources (ordered by priority)
    sources = cmp.config.sources(
        {
            { name = 'luasnip', priority = 100 },       -- Snippets have highest priority
            { name = 'nvim_lsp', priority = 90 },       -- LSP completions
            { name = 'path', priority = 80 },           -- File paths
        },
        {
            { name = 'buffer', priority = 50 },         -- Buffer completions (lower priority)
        }
    ),

    -- Completion formatting
    formatting = {
        fields = { 'kind', 'abbr', 'menu' },
        format = function(entry, vim_item)
            -- Customize completion menu item appearance
            local kind_icons = {
                Text = "󰉿",
                Method = "󰆧",
                Function = "󰊕",
                Constructor = "",
                Field = "󰜢",
                Variable = "󰀫",
                Class = "󰌗",
                Interface = "",
                Module = "",
                Property = "󰜢",
                Unit = "󰑭",
                Value = "󰎠",
                Enum = "",
                Keyword = "󰌋",
                Snippet = "",
                Color = "󰏘",
                File = "󰈙",
                Reference = "󰈇",
                Folder = "󰉋",
                EnumMember = "",
                Constant = "󰏿",
                Struct = "󰙅",
                Event = "",
                Operator = "󰆕",
                TypeParameter = "",
            }

            vim_item.kind = string.format('%s', kind_icons[vim_item.kind] or '')
            vim_item.menu = ({
                nvim_lsp = '  LSP',
                luasnip = '  Snippet',
                buffer = '  Buffer',
                path = '  Path',
                cmdline = '  Cmd',
            })[entry.source.name]

            return vim_item
        end,
    },

    -- Window styling
    window = {
        completion = {
            border = 'rounded',
            winhighlight = 'Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None',
            scrollbar = '║',
            col_offset = -3,
            side_padding = 1,
        },
        documentation = {
            border = 'rounded',
            winhighlight = 'Normal:Pmenu,FloatBorder:PmenuBorder',
            scrollbar = '║',
            max_width = 80,
            max_height = 20,
        },
    },

    -- Performance settings
    performance = {
        -- max_view_entries = 15,
        debounce = 60,
        throttle = 30,
        async_budget = 1,
    },

    -- Experimental features
    experimental = {
        ghost_text = false, -- Set to true if you want ghosttext (preview)
    },
})

-- Setup for command mode completion
cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'cmdline' },
        { name = 'path' },
    },
    formatting = {
        fields = { 'abbr' },
    },
    window = {
        completion = {
            border = 'rounded',
            winhighlight = 'Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None',
            scrollbar = '║',
            side_padding = 1,
        },
    },
})

-- Setup for search completion
cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = 'buffer' },
    },
    formatting = {
        fields = { 'abbr' },
    },
    window = {
        completion = {
            border = 'rounded',
            winhighlight = 'Normal:Pmenu,FloatBorder:PmenuBorder,CursorLine:PmenuSel,Search:None',
            scrollbar = '║',
            side_padding = 1,
        },
    },
})
