-- ============================================================================
-- TOML Language Configuration
-- ============================================================================
-- This file contains TOML LSP configuration using taplo.
-- Essential for Rust development (Cargo.toml) and other TOML files.
-- To disable TOML support, comment out the require in lua/languages/init.lua
-- ============================================================================

vim.lsp.config('taplo', {
  cmd = { 'taplo', 'lsp', 'stdio' },
  filetypes = { 'toml' },
  root_markers = {
    'Cargo.toml',
    'pyproject.toml',
    '.taplo.toml',
    'taplo.toml',
    '.git',
  },
  settings = {
    evenBetterToml = {
      schema = {
        enabled = true,
        -- Automatically fetch schemas from schemastore
        associations = {
          ["Cargo.toml"] = "https://json.schemastore.org/cargo.json",
          ["rustfmt.toml"] = "https://json.schemastore.org/rustfmt.json",
          [".rustfmt.toml"] = "https://json.schemastore.org/rustfmt.json",
          ["pyproject.toml"] = "https://json.schemastore.org/pyproject.json",
        },
      },
      formatter = {
        -- Formatting options
        alignEntries = false,
        alignComments = true,
        arrayTrailingComma = true,
        arrayAutoExpand = true,
        arrayAutoCollapse = true,
        compactArrays = true,
        compactInlineTables = false,
        columnWidth = 80,
        indentTables = false,
        indentEntries = false,
        trailingNewline = true,
        reorderKeys = false,
      },
      syntax = {
        -- Enable semantic tokens
        semanticTokens = true,
      },
    },
  },
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
    },
  },
})

-- TOML-specific autocommands
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'toml',
  callback = function(args)
    local bufnr = args.buf

    -- Set TOML-specific options
    vim.bo[bufnr].commentstring = '# %s'

    -- Add TOML-specific keybindings (optional)
    vim.keymap.set('n', '<leader>tf', '<cmd>lua vim.lsp.buf.format()<cr>', {
      buffer = bufnr,
      desc = '[T]oml [F]ormat'
    })
  end,
})

-- Cargo.toml specific features
vim.api.nvim_create_autocmd('BufRead', {
  pattern = 'Cargo.toml',
  callback = function(args)
    local bufnr = args.buf

    -- Quick jump to dependencies section
    vim.keymap.set('n', '<leader>cd', function()
      vim.fn.search('\\[dependencies\\]', 'w')
    end, {
      buffer = bufnr,
      desc = '[C]argo [D]ependencies'
    })

    -- Quick jump to dev-dependencies
    vim.keymap.set('n', '<leader>cD', function()
      vim.fn.search('\\[dev-dependencies\\]', 'w')
    end, {
      buffer = bufnr,
      desc = '[C]argo [D]ev-dependencies'
    })

    -- Quick jump to package section
    vim.keymap.set('n', '<leader>cp', function()
      vim.fn.search('\\[package\\]', 'w')
    end, {
      buffer = bufnr,
      desc = '[C]argo [P]ackage'
    })
  end,
})

return {
  name = 'toml',
  lsp = 'taplo',
  enabled = true,
}
