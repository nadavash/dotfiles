local allowed_hosts = {
  ["HQ-F472JY6XK0"] = true,
  ["nashkenazi-sovereign-linux-2"] = true,
}

if not allowed_hosts[vim.fn.hostname()] then
  return {}
end

local clangd_wrapper = vim.fn.stdpath("config") .. "/tools/clangd-wrapper"
local default_platform = vim.fn.has("mac") == 1 and "macos/arm64" or "linux/x86_64"
local targets = { "client", "studio", "common-tests" }

local function engine_root(source)
  local root = vim.fs.root(source, { "GameEngine.code-workspace" })
  if root then
    return root
  end
end

local function generate_compile_commands(opts)
  if #opts.fargs < 1 or #opts.fargs > 2 then
    vim.notify("Usage: :GameEngineCompileCommands <target> [platform]", vim.log.levels.ERROR)
    return
  end

  local target = opts.fargs[1]
  local platform = opts.fargs[2] or default_platform
  local root = engine_root(0)

  if not root then
    vim.notify("Not inside a game-engine repository", vim.log.levels.ERROR)
    return
  end

  local gobot = root .. "/Tools/Util/gobot"
  if vim.fn.executable(gobot) ~= 1 then
    vim.notify("gobot not found at " .. gobot, vim.log.levels.ERROR)
    return
  end

  vim.cmd("botright new")

  vim.fn.jobstart({
    gobot,
    "run",
    "buck2/compile_commands",
    target,
    platform,
  }, {
    cwd = root,
    term = true,

    on_exit = function(_, code)
      vim.schedule(function()
        if code == 0 then
          vim.notify("compile_commands.json generated")
          pcall(function()
            vim.cmd("LspRestart")
          end)
        else
          vim.notify("compile_commands generation failed", vim.log.levels.ERROR)
        end
      end)
    end,
  })

  vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("GameEngineCompileCommands", generate_compile_commands, {
  nargs = "+",
  desc = "Generate game-engine compile_commands.json",
  complete = function(arglead, cmdline)
    -- Only complete targets for the first argument.
    if #vim.split(cmdline, "%s+", { trimempty = true }) > (arglead == "" and 1 or 2) then
      return {}
    end
    return vim.tbl_filter(function(t)
      return vim.startswith(t, arglead)
    end, targets)
  end,
})

return {
  {
    "neovim/nvim-lspconfig",

    opts = {
      servers = {
        clangd = {
          -- Decided per root so files opened after startup still get the right binary.
          cmd = function(dispatchers, config)
            local cmd = { "clangd" }
            if config.root_dir and engine_root(config.root_dir) then
              cmd = { clangd_wrapper }
            end
            return vim.lsp.rpc.start(cmd, dispatchers, { cwd = config.root_dir })
          end,
        },
      },
    },
  },
}
