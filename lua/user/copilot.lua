local M = {}

M.config = function()
  vim.api.nvim_set_keymap("i", "<C-J>", ":copilot#Accept('/<CR>')", { silent = true })
end

return M
