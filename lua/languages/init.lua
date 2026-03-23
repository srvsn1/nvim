-- ============================================================================
-- Language Configurations Loader
-- ============================================================================
-- This file loads all language-specific configurations.
-- To add a new language: create a folder in lua/languages/ and add it here.
-- To remove a language: comment out the require line.
-- ============================================================================

-- List of enabled languages
local languages = {
  'languages.rust',  -- Rust support (rust-analyzer)
  'languages.lua',   -- Lua support (lua_ls) - for Neovim config editing
  'languages.toml',  -- TOML support (taplo) - for Cargo.toml, config files
  'languages.java',  -- Java support (jdtls) - eclipse.jdt.ls
  -- Add more languages here:
  -- 'languages.python',
  -- 'languages.typescript',
  -- 'languages.go',
}

-- Load each language configuration
for _, lang in ipairs(languages) do
  local ok, config = pcall(require, lang)
  if ok then
    -- if config.enabled ~= false then
    --   vim.notify(string.format('Loaded %s language support', config.name or lang), vim.log.levels.INFO)
    -- end
  else
    vim.notify(string.format('Failed to load %s: %s', lang, config), vim.log.levels.WARN)
  end
end

-- Export loaded languages for reference
return {
  languages = languages,
}

