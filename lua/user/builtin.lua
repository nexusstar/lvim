local M = {}

M.config = function()
  -- CMP
  -- =========================================
  lvim.builtin.cmp.sources = {
    { name = "nvim_lsp", max_item_count = 7 },
    { name = "cmp_tabnine", max_item_count = 3 },
    { name = "buffer", max_item_count = 3 },
    { name = "path", max_item_count = 3 },
    { name = "luasnip", max_item_count = 3 },
    { name = "nvim_lua" },
    { name = "calc" },
    { name = "emoji" },
    { name = "treesitter" },
    { name = "crates" },
  }
  lvim.builtin.cmp.documentation.border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

  lvim.builtin.cmp.experimental = {
    ghost_text = false,
    native_menu = false,
    custom_menu = true,
  }
  --lvim.builtin.cmp.formatting.kind_icons = require("user.lsp_kind").cmp_kind()
  lvim.builtin.cmp.formatting.source_names = {
    buffer = "(Buffer)",
    nvim_lsp = "(LSP)",
    luasnip = "(Snip)",
    treesitter = "",
    nvim_lua = "(NvLua)",
    spell = "暈",
    emoji = "",
    path = "",
    calc = "",
    cmp_tabnine = "ﮧ",
    ["vim-dadbod-completion"] = "𝓐",
  }
  if lvim.copilot then
    vim.g.copilot_no_tab_map = true
    vim.g.copilot_assume_mapped = true
    vim.g.copilot_tab_fallback = ""
    local cmp = require "cmp"
    lvim.builtin.cmp.mapping["<C-e>"] = function(fallback)
      cmp.mapping.abort()
      local copilot_keys = vim.fn["copilot#Accept"]()
      if copilot_keys ~= "" then
        vim.api.nvim_feedkeys(copilot_keys, "i", true)
      else
        fallback()
      end
    end
  end
  -- Dashboard
  -- =========================================
  lvim.builtin.dashboard.active = true
  lvim.builtin.terminal.active = true
  lvim.builtin.dashboard.custom_section["m"] = {
    description = { "  Marks              " },
    command = "Telescope marks",
  }

  -- LSP
  -- =========================================
  lvim.lsp.diagnostics.signs.values = {
    { name = "LspDiagnosticsSignError", text = " " },
    { name = "LspDiagnosticsSignWarning", text = "" },
    { name = "LspDiagnosticsSignHint", text = "" },
    { name = "LspDiagnosticsSignInformation", text = "" },
  }
  -- Lualine
  -- =========================================
  lvim.builtin.lualine.active = true
  lvim.builtin.lualine.sections.lualine_b = { "branch" }

  -- NvimTree
  -- =========================================
  lvim.builtin.nvimtree.setup.diagnostics = {
    enable = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  }
  lvim.builtin.nvimtree.setup.auto_open = 0
  lvim.builtin.nvimtree.hide_dotfiles = 0

  -- Project
  -- =========================================
  lvim.builtin.project.active = true

  -- Treesitter
  -- =========================================
  lvim.builtin.treesitter.context_commentstring.enable = true
  lvim.builtin.treesitter.highlight.disable = {}
  lvim.builtin.treesitter.ensure_installed = "maintained"
  lvim.builtin.treesitter.ignore_install = { "haskell" }
  lvim.builtin.treesitter.incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-r>",
    },
  }
  lvim.builtin.treesitter.indent = { enable = true, disable = { "yaml", "python" } } -- treesitter is buggy :(
  lvim.builtin.treesitter.matchup.enable = true
  -- lvim.treesitter.textsubjects.enable = true
  -- lvim.treesitter.playground.enable = true
  lvim.builtin.treesitter.query_linter = {
    enable = true,
    use_virtual_text = true,
    lint_events = { "BufWrite", "CursorHold" },
  }
  lvim.builtin.treesitter.on_config_done = function()
    local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
    parser_config.solidity = {
      install_info = {
        url = "https://github.com/JoranHonig/tree-sitter-solidity",
        files = { "src/parser.c" },
        requires_generate_from_grammar = true,
      },
      filetype = "solidity",
    }
    parser_config.jsonc.used_by = "json"
    parser_config.markdown = {
      install_info = {
        url = "https://github.com/ikatyang/tree-sitter-markdown",
        files = { "src/parser.c", "src/scanner.cc" },
      },
    }
  end

  -- Telescope
  -- =========================================

  lvim.builtin.telescope.defaults.path_display = { shorten = 10 }
  lvim.builtin.telescope.defaults.winblend = 6
  lvim.builtin.telescope.defaults.layout_strategy = "horizontal"
  lvim.builtin.telescope.defaults.layout_config = require("user.telescope").layout_config()
  lvim.builtin.telescope.defaults.mappings = {
    i = {
      ["<esc>"] = require("telescope.actions").close,
      ["<C-y>"] = require("telescope.actions").which_key,
    },
  }

  -- Terminal
  -- =========================================
  lvim.builtin.terminal.active = true
  lvim.builtin.terminal.execs = {
    { "lazygit", "gg", "LazyGit" },
  }

  -- WhichKey
  -- =========================================
  lvim.builtin.which_key.setup.window.winblend = 10
  lvim.builtin.which_key.setup.window.border = "none"
  lvim.builtin.which_key.on_config_done = function(wk)
    local keys = {
      ["ga"] = { "<cmd>lua require('user.telescope').code_actions()<CR>", "Code Action" },
      ["gR"] = { "<cmd>Trouble lsp_references<CR>", "Goto References" },
      ["gI"] = { "<cmd>lua require('user.telescope').lsp_implementations()<CR>", "Goto Implementation" },
    }

    -- better keybindings for ts and tsx files
    local langs = { "typescript", "typescriptreact" }
    local ftype = vim.bo.filetype
    if vim.tbl_contains(langs, ftype) then
      local ts_keys = {
        ["gA"] = { "<cmd>TSLspImportAll<CR>", "Import All" },
        ["gr"] = { "<cmd>TSLspRenameFile<CR>", "Rename File" },
        ["gS"] = { "<cmd>TSLspOrganize<CR>", "Organize Imports" },
      }
      wk.register(ts_keys, { mode = "n" })
    end
    wk.register(keys, { mode = "n" })
  end

  -- Corrects the spelling under the cursor with the first suggestion.
  lvim.builtin.which_key.mappings["z"] = { "<cmd>normal 1z=<CR>", "Speeling Fix" }

  -- Trouble to which keys
  lvim.builtin.which_key.mappings["t"] = {
    name = "+Trouble",
    r = { "<cmd>Trouble lsp_references<cr>", "References" },
    f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
    d = { "<cmd>Trouble lsp_document_diagnostics<cr>", "Diagnostics" },
    q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
    l = { "<cmd>Trouble loclist<cr>", "LocationList" },
    w = { "<cmd>Trouble lsp_workspace_diagnostics<cr>", "Diagnostics" },
  }
  -- ETC
  -- =========================================
  --   if lvim.builtin.lastplace.active == false then
  --     -- go to last loc when opening a buffer
  --     vim.cmd [[
  --   autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif
  -- ]]
  --   end
end

return M
