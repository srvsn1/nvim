require('copilot').setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<M-CR>",
      refresh = "gr",
      open = false
    },
    layout = {
      position = "bottom", -- | top | left | right | bottom |
      ratio = 0.4
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = true,
    hide_during_completion = false,
    debounce = 15,
    trigger_on_accept = true,
    keymap = {
      accept = "<C-y>",        -- accept full suggestion (multi-line)
      accept_word = "<C-l>",   -- accept word-by-word
      accept_line = "<C-j>",   -- accept line-by-line
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-e>",
      toggle_auto_trigger = false,
    },
  },
  nes = {
    enabled = false, -- requires copilot-lsp as a dependency
    auto_trigger = false,
    keymap = {
      accept_and_goto = false,
      accept = false,
      dismiss = false,
    },
  },
  auth_provider_url = nil, -- URL to authentication provider, if not "https://github.com/"
  logger = {
    file = vim.fn.stdpath("log") .. "/copilot-lua.log",
    file_log_level = vim.log.levels.OFF,
    print_log_level = vim.log.levels.WARN,
    trace_lsp = "off", -- "off" | "debug" | "verbose"
    trace_lsp_progress = false,
    log_lsp_messages = false,
  },
  copilot_node_command = 'node', -- Node.js version must be > 22
  workspace_folders = {},
  copilot_model = "",
  disable_limit_reached_message = false,  -- Set to `true` to suppress completion limit reached popup
  root_dir = function()
    return vim.fs.dirname(vim.fs.find(".git", { upward = true })[1])
  end,
  should_attach = function(buf_id, _)
    local ft = vim.bo[buf_id].filetype
    local disabled_filetypes = {
      "TelescopePrompt",
      "oil",
      "minifiles",
      "NvimTree",
      "neo-tree",
      "lazy",
      "mason",
      "help",
      "qf",
      "fugitive",
      "DressingInput",
      "WhichKey",
    }
    if vim.tbl_contains(disabled_filetypes, ft) then
      return false
    end

    if not vim.bo[buf_id].buflisted then
      return false
    end

    if vim.bo[buf_id].buftype ~= "" then
      return false
    end

    return true
  end,
  server = {
    type = "nodejs", -- "nodejs" | "binary"
    custom_server_filepath = nil,
  },
  server_opts_overrides = {},
})

-- CopilotChat: inline prompting for code generation, review, and refactoring
require('CopilotChat').setup({
  model = 'gpt-4o',
  window = {
    layout = 'float',
    border = 'rounded',
    width = 0.8,
    height = 0.6,
  },
  mappings = {
    complete = { insert = '<Tab>' },
    close = { normal = 'q', insert = '<C-c>' },
    reset = { normal = '<C-r>', insert = '<C-r>' },
    accept_diff = { normal = '<leader>ay', insert = '<C-y>' },
  },
})
