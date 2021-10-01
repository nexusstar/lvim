-- General
lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "onedarker"
lvim.lsp.diagnostics.virtual_text = false
lvim.number = "relativenumber"

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- Keymapping
require("user.keybindings").config()
-- Customization
lvim.builtin.lastplace = { active = true } -- change to false if you are jumping to future
lvim.builtin.tabnine = { active = true } -- change to false if you don't like tabnine
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
local _todayDate = os.date "%H:%M %Y today is %A, in %B"
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
lvim.lang.markdown = {}
lvim.lang.dockerfile.lsp.setup.root_dir = function(fname)
  return require("lspconfig").util.root_pattern ".git"(fname) or require("lspconfig").util.path.dirname(fname)
end
lvim.builtin.lspinstall.on_config_done = function()
  lvim.lang.tailwindcss.lsp.setup.filetypes = { "markdown" }
  lvim.lang.tailwindcss.lsp.active = true
  require("lsp").setup "tailwindcss"
end
lvim.lang.typescript.on_attach = function(client, _)
  require("nvim-lsp-ts-utils").setup_client(client)
end
lvim.lang.typescriptreact.on_attach = lvim.lang.typescript.on_attach
lvim.lsp.override = { "rust", "java", "dart" }
require("user.json_schemas").setup()
require("user.yaml_schemas").setup()

-- Additional Plugins
-- =========================================
-- require("user.plugins").config()

-- Additional Plugins
lvim.plugins = {
  -- themes
  -- -- they are configured to switch by time
  -- -- default is tokyonight
  {
    "folke/tokyonight.nvim",
  },
  {
    "NTBBloodbath/doom-one.nvim",
    config = function()
      vim.g.doom_one_italic_comments = true
      vim.cmd [[
      colorscheme doom-one
      ]]
    end,
    cond = function()
      local _time = os.date "*t"
      return (_time.hour >= 17 and _time.hour < 23)
    end,
  },
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      require("user/lsp_signature").config()
    end,
    event = "BufRead",
  },
  {
    "ethanholz/nvim-lastplace",
    config = function()
      require("nvim-lastplace").setup {}
    end,
    event = "BufWinEnter",
    disable = not lvim.builtin.lastplace.active,
  },
  {
    "folke/trouble.nvim",
    requires = "kyazdani42/nvim-web-devicons",
    config = function()
      require("trouble").setup()
    end,
    cmd = "Trouble",
  },
  {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
    config = function()
      require("todo-comments").setup()
    end,
    event = "BufRead",
  },
  {
    "IndianBoy42/hop.nvim",
    event = "BufRead",
    config = function()
      require("user.hop").config()
    end,
  },
  {
    "simrat39/symbols-outline.nvim",
    config = function()
      vim.g.symbols_outline.auto_preview = false
    end,
    cmd = "SymbolsOutline",
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    setup = function()
      require("user.indent_blankline").setup()
    end,
    event = "BufRead",
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("user.twilight").config()
    end,
    event = "BufRead",
  },
  {
    "kevinhwang91/nvim-bqf",
    config = function()
      require("user.bqf").config()
    end,
    event = "BufRead",
  },
  {
    "rcarriga/nvim-dap-ui",
    config = function()
      require("dapui").setup()
    end,
    ft = { "python", "rust", "go" },
    requires = { "mfussenegger/nvim-dap" },
    disable = not lvim.builtin.dap.active,
  },
  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },
  {
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
  },
  {
    "simrat39/rust-tools.nvim",
    config = function()
      require("user.rust_tools").config()
    end,
    ft = { "rust", "rs" },
  },
  {
    "folke/zen-mode.nvim",
    config = function()
      require("user.zen").config()
    end,
    event = "BufRead",
  },
  {
    "windwp/nvim-spectre",
    event = "BufRead",
    config = function()
      require("user.spectre").config()
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("user.colorizer").config()
    end,
    event = "BufRead",
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    module = "persistence",
    config = function()
      require("persistence").setup()
    end,
    disable = not lvim.builtin.persistence.active,
  },
  {
    "andweeb/presence.nvim",
    config = function()
      require("user.presence").config()
    end,
    disable = not lvim.builtin.presence.active,
  },
  {
    "kristijanhusak/orgmode.nvim",
    ft = { "org" },
    config = function()
      require("user.orgmode").setup {}
    end,
    disable = not lvim.builtin.orgmode.active,
  },
  {
    "danymat/neogen",
    config = function()
      require("neogen").setup {
        enabled = true,
      }
    end,
    event = "BufRead",
    requires = "nvim-treesitter/nvim-treesitter",
  },
  {
    "vim-test/vim-test",
    cmd = { "TestNearest", "TestFile", "TestSuite", "TestLast", "TestVisit" },
    keys = { "<localleader>tf", "<localleader>tn", "<localleader>ts" },
    config = function()
      require("user.vim_test").config()
    end,
    disable = not lvim.builtin.test_runner.active,
  },
  {
    "folke/lua-dev.nvim",
    config = function()
      require("user.lua_dev").config()
    end,
    ft = "lua",
    disable = not lvim.builtin.lua_dev.active,
  },
  {
    "jose-elias-alvarez/nvim-lsp-ts-utils",
    config = function()
      require("user.ts_utils").config()
    end,
    ft = {
      "javascript",
      "javascriptreact",
      "javascript.jsx",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  {
    "akinsho/bufferline.nvim",
    config = function()
      require("user.bufferline").config()
    end,
    requires = "nvim-web-devicons",
    disable = not lvim.builtin.fancy_bufferline.active,
  },
  {
    -- "ChristianChiarulli/vim-solidity",
    -- jdl[;warnjkw]
    "ilya-bobyr/vim-solidity",
  },
  {
    "rcarriga/vim-ultest",
    cmd = { "Ultest", "UltestSummary", "UltestNearest" },
    wants = "vim-test",
    requires = { "vim-test/vim-test" },
    run = ":UpdateRemotePlugins",
    disable = not lvim.builtin.test_runner.active,
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    run = "make",
    after = "telescope.nvim",
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },
  {
    "RishabhRD/nvim-cheat.sh",
    requires = "RishabhRD/popfix",
    config = function()
      vim.g.cheat_default_window_layout = "vertical_split"
    end,
    cmd = { "Cheat", "CheatWithoutComments", "CheatList", "CheatListWithoutComments" },
    disable = not lvim.builtin.cheat.active,
  },
  {
    "tzachar/cmp-tabnine",
    run = "./install.sh",
    requires = "hrsh7th/nvim-cmp",
    config = function()
      local tabnine = require "cmp_tabnine.config"
      tabnine:setup {
        max_lines = 1000,
        max_num_results = 10,
        sort = true,
      }
    end,
    -- disable = not lvim.builtin.tabnine.active,
  },
  { "ray-x/go.nvim" },
  { "tpope/vim-surround" },
}
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- - config
require("user.autocommands").config()
