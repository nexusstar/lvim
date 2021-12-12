-- General
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker" -- on load just to prevent lvim from crashing
lvim.lsp.diagnostics.virtual_text = false
require("user.neovim").config()

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- Keymapping
require("user.keybindings").config()
-- Customization
lvim.builtin.copilot_runner = true -- if you want microsoft to abuse your soul
lvim.builtin.lastplace = { active = true } -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = false } -- change to false if you don't like tabnine
lvim.builtin.persistence = { active = true } -- change to false if you don't want persistence
lvim.builtin.presence = { active = false } -- change to true if you want discord presence
lvim.builtin.orgmode = { active = false } -- change to true if you want orgmode.nvim
lvim.builtin.dap.active = true -- change this to enable/disable debugging
lvim.builtin.fancy_statusline = { active = false } -- change this to enable/disable fancy statusline
lvim.builtin.fancy_bufferline = { active = false } -- change this to enable/disable fancy bufferline
lvim.builtin.lua_dev = { active = true } -- change this to enable/disable folke/lua_dev
lvim.builtin.test_runner = { active = true } -- change this to enable/disable vim-test, ultest
lvim.builtin.cheat = { active = true } -- enable cheat.sh integration
lvim.lsp.diagnostics.virtual_text = false -- remove this line if you want to see inline errors
lvim.builtin.latex = {
  view_method = "okular", -- change to zathura document viewer maybe
}
-- Custom dashboard header
local _todayDate = os.date "%H:%M %d/%m/%Y today is %A, in %B"
lvim.builtin.dashboard.custom_header = {
  "╭ LunarVim",
  "╰ " .. _todayDate .. "",
}

require("user.builtin").config()

-- StatusLine
if lvim.builtin.fancy_statusline.active then
  require("user.lualine").config()
end

-- Debugging
if lvim.builtin.dap.active then
  require("user.dap").config()
end

-- Language Specific
-- =========================================
local custom_servers = { "dockerls", "sumneko_lua", "texlab", "tsserver", "jsonls", "gopls" }
vim.list_extend(lvim.lsp.override, { "rust_analyzer" })
vim.list_extend(lvim.lsp.override, custom_servers)
require("user.null_ls").config()

-- Additional Plugins
-- =========================================
require("user.plugins").config()

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- - config
require("user.autocommands").config()
