local M = {}

M.config = function()
  local status_ok, copilot = pcall(require, "copilot")
  if not status_ok then
    return
  end
end

return M
