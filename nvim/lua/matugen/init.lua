-- matugen.nvim
-- Implementation of Material You colorscheme for Neovim based on matugen

local M = {}

M.opts = {
  json_path = vim.fn.expand("~/.config/matugen/themes/code-colors.jsonc"),
}

-- ---------------------------------------------------------------------------
-- Strip // line comments and /* block comments */ from JSONC
-- ---------------------------------------------------------------------------
local function strip_jsonc(str)
  -- Remove /* ... */ block comments (including multiline)
  str = str:gsub("/%*.-%*/", "")
  -- Remove // line comments, but not inside strings
  str = str:gsub("([^:])//[^\n]*", "%1")
  return str
end

-- ---------------------------------------------------------------------------
-- JSON parser (tiny, dependency-free)
-- ---------------------------------------------------------------------------
local function parse_json(str)
  local ok, result = pcall(vim.fn.json_decode, str)
  if not ok then
    vim.notify("matugen: failed to parse JSON", vim.log.levels.ERROR)
    return nil
  end
  return result
end

-- ---------------------------------------------------------------------------
-- Load colors from JSONC
-- ---------------------------------------------------------------------------
local function load_colors(json_path)
  local f = io.open(json_path, "r")
  if not f then
    vim.notify("matugen: cannot open " .. json_path, vim.log.levels.ERROR)
    return nil
  end
  local raw = f:read("*a")
  f:close()

  local data = parse_json(strip_jsonc(raw))
  if not data then
    return nil
  end

  local w = data["workbench.colorCustomizations"]
  if not w then
    vim.notify("matugen: unexpected JSON structure", vim.log.levels.ERROR)
    return nil
  end

  -- Strip alpha from 8-char hex → 6-char hex for vim highlight fg/bg
  local function hex(key)
    local v = w[key]
    if not v then
      return nil
    end
    -- 9-char (#RRGGBBAA) → take first 7 (#RRGGBB)
    if #v == 9 then
      return v:sub(1, 7)
    end
    return v
  end

  -- Build a clean color table mirroring M3 roles
  return require("matugen.colors").get_colors(hex)
end

-- ---------------------------------------------------------------------------
-- Helper: set highlight
-- ---------------------------------------------------------------------------
local function hl(group, opts)
  local ok, err = pcall(vim.api.nvim_set_hl, 0, group, opts)
  if not ok then
    vim.notify("matugen: hl error on " .. group .. ": " .. err, vim.log.levels.WARN)
  end
end

-- ---------------------------------------------------------------------------
-- Apply all templates from the templates directory
-- ---------------------------------------------------------------------------
local function apply_templates(c)
  local files = vim.api.nvim_get_runtime_file("lua/matugen/templates/**/*.lua", true)
  for _, file in ipairs(files) do
    -- We want to turn ".../lua/matugen/templates/foo/bar.lua" into "matugen.templates.foo.bar"
    -- Normalize separators for matching
    local normalized = file:gsub("\\", "/")
    local modname = normalized:match("lua/(matugen/templates/.*)%.lua$")
    if modname then
      modname = modname:gsub("/", ".")
      package.loaded[modname] = nil
      local ok, template = pcall(require, modname)
      if ok and type(template) == "function" then
        template(c, hl)
      end
    end
  end
end

-- ---------------------------------------------------------------------------
-- Apply all highlights
-- ---------------------------------------------------------------------------
local function apply(c)
  vim.cmd("highlight clear")
  if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.g.colors_name = "matugen"
  vim.o.termguicolors = true

  -- ── LAYER 5: Plugins (Automated Templates) ──────────────────────────────
  apply_templates(c)

  -- ── LAYER 6: winblend for floats ────────────────────────────────────────
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "lazy", "mason", "lspinfo", "null-ls-info", "checkhealth" },
    callback = function()
      vim.wo.winblend = 10
    end,
  })
end

-- ---------------------------------------------------------------------------
-- SIGUSR1 handler → hot reload
-- ---------------------------------------------------------------------------
local function setup_signal_handler()
  local ok = pcall(vim.loop.new_signal)
  if not ok then
    return
  end

  local signal = vim.loop.new_signal()
  signal:start(
    "sigusr1",
    vim.schedule_wrap(function()
      vim.notify("matugen: reloaded colorscheme", vim.log.levels.INFO)
      M.load()
    end)
  )
end

-- ---------------------------------------------------------------------------
-- Public API
-- ---------------------------------------------------------------------------
function M.load()
  local c = load_colors(M.opts.json_path)
  if not c then
    return
  end
  apply(c)
end

function M.setup(opts)
  M.opts = vim.tbl_deep_extend("force", M.opts, opts or {})
  M.load()
  setup_signal_handler()
end

return M
