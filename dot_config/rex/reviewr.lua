local data_home = os.getenv("XDG_DATA_HOME") or os.getenv("HOME") .. "/.local/share"
local path = data_home .. "/nvim/lazy/reviewr.nvim/rex/reviewr/init.lua"
local ok, reviewr = pcall(dofile, path)
if ok then
  reviewr.setup()
end
