local M = { opts = {} }

local function hex(v)
  return v and (#v == 9 and v:sub(1, 7) or v)
end

function M.load()
  local f = io.open(M.opts.json_path or "", "r")
  if not f then return end
  local raw = f:read("*a"):gsub("/%*.-%*/", ""):gsub("([^:])//[^\n]*", "%1")
  f:close()

  local data = vim.json.decode(raw)
  local w = data and data["workbench.colorCustomizations"]
  if not w then return end

  local c = require("matugen.templates.palette").get_colors(function(k) return hex(w[k]) end)

  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") == 1 then vim.cmd("syntax reset") end
  vim.g.colors_name = "matugen"

  local hl = function(g, o) vim.api.nvim_set_hl(0, g, o) end
  for _, file in ipairs(vim.api.nvim_get_runtime_file("lua/matugen/templates/**/*.lua", true)) do
    local mod = file:match("lua/(matugen/templates/.*)%.lua$"):gsub("/", ".")
    package.loaded[mod] = nil
    local ok, template = pcall(require, mod)
    if ok and type(template) == "function" then template(c, hl) end
  end
end

function M.setup(opts)
  M.opts = opts or {}
  M.load()

  local signal = (vim.uv or vim.loop).new_signal()
  signal:start("sigusr1", vim.schedule_wrap(function()
    M.load()
    vim.notify("matugen: reloaded")
  end))

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lazy", "mason", "lspinfo", "null-ls-info", "checkhealth" },
    callback = function() vim.wo.winblend = 10 end,
  })
end

return M
