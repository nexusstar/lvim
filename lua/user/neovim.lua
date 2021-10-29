local M = {}

M.config = function()
  vim.opt.relativenumber = true
  vim.opt.wrap = true
  vim.opt.timeoutlen = 200
  vim.o.foldmethod = "expr"
  vim.o.foldexpr = "nvim_treesitter#foldexpr()"
  vim.o.foldlevel = 4
  vim.o.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' (' . (v:foldend - v:foldstart + 1) . ' lines)']]
  vim.opt.fillchars = {
    vert = "▕", -- alternatives │
    fold = " ",
    eob = " ", -- suppress ~ at EndOfBuffer
    diff = "╱", -- alternatives = ⣿ ░ ─
    msgsep = "‾",
    foldopen = "▾",
    foldsep = "│",
    foldclose = "▸",
  }
  vim.opt.listchars = {
    eol = nil,
    tab = "│ ",
    extends = "›", -- Alternatives: … »
    precedes = "‹", -- Alternatives: … «
    trail = "•", -- BULLET (U+2022, UTF-8: E2 80 A2)
  }
  vim.o.foldnestmax = 3
  vim.o.foldminlines = 1
  vim.opt.guifont = "FiraCode Nerd Font:h14"
  vim.opt.cmdheight = 1
  vim.g.dashboard_enable_session = 0
  vim.g.dashboard_disable_statusline = 0
  vim.opt.pumblend = 10
  vim.opt.joinspaces = false
  vim.opt.list = true
  vim.opt.confirm = true -- make vim prompt me to save before doing destructive things
  vim.opt.autowriteall = true -- automatically :write before running commands and changing files
  vim.opt.clipboard = { "unnamedplus" }
  vim.opt.formatoptions = {
    ["1"] = true,
    ["2"] = true, -- Use indent from 2nd line of a paragraph
    q = true, -- continue comments with gq"
    c = true, -- Auto-wrap comments using textwidth
    r = true, -- Continue comments when pressing Enter
    n = true, -- Recognize numbered lists
    t = false, -- autowrap lines using text width value
    j = true, -- remove a comment leader when joining lines.
    -- Only break if the line was not longer than 'textwidth' when the insert
    -- started and only at a white character that has been entered during the
    -- current insert command.
    l = true,
    v = true,
  }

  if vim.g.neovide then
    vim.g.neovide_cursor_animation_length = 0.01
    vim.g.neovide_cursor_trail_length = 0.05
    vim.g.neovide_cursor_antialiasing = true
    vim.g.neovide_remember_window_size = true
    vim.cmd [[set guifont=FiraCode\ Nerd\ Font:h14]]
  end
  if vim.g.nvui then
    -- Configure nvui here
    vim.cmd [[NvuiCmdFontFamily FiraCode Nerd Font]]
    vim.cmd [[set linespace=1]]
    vim.cmd [[set guifont=FiraCode\ Nerd\ Font:h14]]
    vim.cmd [[NvuiPopupMenuDefaultIconFg white]]
    vim.cmd [[NvuiCmdBg #1e2125]]
    vim.cmd [[NvuiCmdFg #abb2bf]]
    vim.cmd [[NvuiCmdBigFontScaleFactor 1.0]]
    vim.cmd [[NvuiCmdPadding 10]]
    vim.cmd [[NvuiCmdCenterXPos 0.5]]
    vim.cmd [[NvuiCmdTopPos 0.0]]
    vim.cmd [[NvuiCmdFontSize 20.0]]
    vim.cmd [[NvuiCmdBorderWidth 5]]
    vim.cmd [[NvuiPopupMenuIconFg variable #56b6c2]]
    vim.cmd [[NvuiPopupMenuIconFg function #c678dd]]
    vim.cmd [[NvuiPopupMenuIconFg method #c678dd]]
    vim.cmd [[NvuiPopupMenuIconFg field #d19a66]]
    vim.cmd [[NvuiPopupMenuIconFg property #d19a66]]
    vim.cmd [[NvuiPopupMenuIconFg module white]]
    vim.cmd [[NvuiPopupMenuIconFg struct #e5c07b]]
    vim.cmd [[NvuiCaretExtendTop 15]]
    vim.cmd [[NvuiCaretExtendBottom 8]]
    vim.cmd [[NvuiTitlebarFontSize 12]]
    vim.cmd [[NvuiTitlebarFontFamily Arial]]
    vim.cmd [[NvuiCursorAnimationDuration 0.1]]
    -- vim.cmd [[NvuiToggleFrameless]]
    vim.cmd [[NvuiOpacity 0.99]]
  end
end

return M
