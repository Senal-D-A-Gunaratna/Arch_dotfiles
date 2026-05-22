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
  return {
    -- Core surfaces
    surface = hex("editor.background"), -- #121318
    surface_low = hex("sideBar.background"), -- #1b1b21
    surface_container = hex("statusBar.background"), -- #1f1f25
    surface_high = hex("sideBarSectionHeader.background"), -- #292a2f
    surface_highest = hex("terminal.inactiveSelectionBackground"), -- #34343a

    -- Text
    on_surface = hex("editor.foreground"), -- #e3e1e9
    on_surface_variant = hex("statusBar.foreground"), -- #c6c5d0
    outline = hex("editorLineNumber.foreground"), -- #90909a
    outline_variant = hex("editorWidget.border"), -- #46464f

    -- Primary (periwinkle blue)
    primary = hex("editorLineNumber.activeForeground"), -- #b9c3ff
    on_primary = hex("button.foreground"), -- #212c61
    primary_container = hex("editorSuggestWidget.selectedBackground"), -- #384379
    on_primary_container = hex("editorSuggestWidget.selectedForeground"), -- #dee1ff

    -- Secondary (cool grey-blue)
    secondary = hex("editorWidget.border") ~= hex("editorWarning.foreground") and hex("editorWarning.foreground")
      or "#c3c5dd", -- #c3c5dd
    secondary_container = hex("statusBarItem.remoteBackground"), -- #434659
    on_secondary_container = hex("statusBarItem.remoteForeground"), -- #dfe1f9

    -- Tertiary (dusty rose)
    tertiary = hex("editorInfo.foreground"), -- #e5bad8
    tertiary_container = hex("terminal.ansiBrightGreen"), -- #5d3c55

    -- Error
    error = hex("editorError.foreground"), -- #ffb4ab
    error_container = hex("terminal.ansiBrightRed"), -- #93000a

    -- Selection / highlights
    selection_bg = hex("editor.selectionBackground"), -- #b9c3ff33 → use primary + blend
    word_highlight = hex("editor.wordHighlightBackground"), -- secondary tint
    word_highlight_strong = hex("editor.wordHighlightStrongBackground"), -- tertiary tint

    -- Git
    git_added = hex("editorGutter.addedBackground"), -- #b9c3ff
    git_modified = hex("editorGutter.modifiedBackground"), -- #c3c5dd
    git_deleted = hex("editorGutter.deletedBackground"), -- #ffb4ab
  }
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
