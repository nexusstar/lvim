local M = {}

M.config = function()
  local status_ok, dap = pcall(require, "dap")
  if not status_ok then
    return
  end

  dap.adapters.lldb = {
    type = "executable",
    attach = { pidProperty = "pid", pidSelect = "ask" },
    command = "lldb-vscode",
    name = "lldb",
    env = { LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES" },
  }

  dap.configurations.cpp = {
    {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
      runInTerminal = false,
    },
  }

  dap.adapters.chrome = {
    type = "executable",
    command = "node",
    args = { os.getenv "HOME" .. "/github/vscode-chrome-debug/out/src/chromeDebug.js" }, -- TODO adjust
  }
  dap.configurations.javascriptreact = { -- change this to javascript if needed
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }

  dap.configurations.typescriptreact = { -- change to typescript if needed
    {
      type = "chrome",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}",
    },
  }
  dap.configurations.javascript = dap.configurations.javascriptreact
  dap.configurations.typescript = dap.configurations.typescriptreact
  dap.configurations.c = dap.configurations.cpp
  dap.configurations.rust = dap.configurations.cpp
end

return M
