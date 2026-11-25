-- Rex terminals: newer Rex builds (0.1.0-preview.23+) set only REX_BLOCK, but
-- rex.nvim and reviewr.nvim still read REX_SESSION at runtime. Fill it in from
-- the block (one `rex` call at startup, only when it's missing), and report
-- whether Neovim is in a Rex terminal whose session is known.
local M = {}

local cached
function M.in_rex()
  if cached ~= nil then return cached end
  if (vim.env.REX_SESSION or "") == "" and (vim.env.REX_BLOCK or "") ~= "" and vim.fn.executable("rex") == 1 then
    local r = vim.system({ "rex", "block", "inspect", vim.env.REX_BLOCK, "--json" }, { text = true, timeout = 2000 }):wait()
    local ok, info = pcall(vim.json.decode, r.code == 0 and r.stdout or "")
    if ok and type(info) == "table" and type(info.session_id) == "string" and info.session_id ~= "" then
      vim.env.REX_SESSION = info.session_id
    end
  end
  cached = (vim.env.REX_SESSION or "") ~= ""
  return cached
end

return M
