local M = {}

require("conjure.main").main()
local eval = require("conjure.eval")
local extract = require("conjure.extract")

local function conj_eval(origin, code)
  eval["eval-str"]({
    origin = origin,
    code = code,
  })
end

local function try_conj_eval(origin, code)
  local ok, err = pcall(conj_eval, origin, code)
  if not ok then
    vim.notify("Clay eval error: " .. err, vim.log.levels.ERROR)
  end
end

M.setup = function(opts)
  opts = opts or {}
  vim.keymap.set("n", "<leader>cr", M.ClayMakeFile, { desc = "Clay: Start and Render" })
  -- etc...
end

local function get_source_path()
  return vim.fn.expand("%:p")
end

local function safe_get_form(opts)
  local ok, result = pcall(extract.form, opts)
  return ok and result.content or nil
end

local function require_wrapper(code)
  return string.format("(do (require '[scicloj.clay.v2.snippets]) %s)", code)
end

-- Evaluates current namespace and prints as hiccup.
-- Doesn't render page in the browser.
M.ClayPrintNamespaceToHiccup = function()
  local code = string.format('(scicloj.clay.v2.api/make-hiccup {:source-path "%s"})', get_source_path())
  try_conj_eval("clay-eval-ns-to-hiccup", code)
end

-- Require and evaluate clay.
-- Evaluates current form and renders it to browser.
M.ClayMakeFile = function()
  local code = require_wrapper(string.format("(scicloj.clay.v2.snippets/make-ns-html! \"%s\" {:ide :neovim})",
    get_source_path()))
  try_conj_eval("make-ns-html!", code)
end

M.ClayMakeFileQuarto = function()
  local code = require_wrapper(string.format("(scicloj.clay.v2.snippets/make-ns-quarto-html! \"%s\" {:ide :neovim})",
    get_source_path()))
  try_conj_eval("make-ns-quarto-html!", code)
end

M.ClayMakeFileRevealjs = function()
  local code = require_wrapper(string.format("(scicloj.clay.v2.snippets/make-ns-quarto-revealjs! \"%s\" {:ide :neovim})",
    get_source_path()))
  try_conj_eval("make-ns-quarto-revealjs!", code)
end

-- Require and evaluate clay.
-- Evaluates top level form and renders it to browser.
M.ClayMakeCurrentForm = function()
  local form_content = safe_get_form({ root = true })
  if not form_content then
    vim.notify("Could not extract form", vim.log.levels.ERROR)
    return
  end
  local code = require_wrapper(string.format(
    "(scicloj.clay.v2.snippets/make-form-html! (quote %s) \"%s\" {:ide :neovim})", form_content, get_source_path()))
  try_conj_eval("make-form-html!", code)
end

-- Require and evaluate clay.
-- Evaluates top level form and renders it to browser.
M.ClayMakeTopLevelForm = function()
  local form_content = safe_get_form({ root = true })
  if not form_content then
    vim.notify("Could not extract form", vim.log.levels.ERROR)
    return
  end
  local code = require_wrapper(string.format(
    "(scicloj.clay.v2.snippets/make-form-html! (quote %s) \"%s\" {:ide :neovim})", form_content, get_source_path()))
  try_conj_eval("make-form-html!", code)
end

M.ClayMakeCurrentFormQuarto = function()
  local form_content = safe_get_form({})
  if not form_content then
    vim.notify("Could not extract form", vim.log.levels.ERROR)
    return
  end
  local code = require_wrapper(string.format(
    "(scicloj.clay.v2.snippets/make-form-quarto-html! (quote %s) \"%s\" {:ide :neovim})",
    form_content, get_source_path()))
  try_conj_eval("make-current-form-quarto!", code)
end


M.ClayMakeTopLevelFormQuarto = function()
  local form_content = safe_get_form({ root = true })
  if not form_content then
    vim.notify("Could not extract form", vim.log.levels.ERROR)
    return
  end

  local code = require_wrapper(string.format(
    "(scicloj.clay.v2.snippets/make-form-quarto-html! (quote %s) \"%s\" {:ide :neovim})", form_content, get_source_path()))
  try_conj_eval("make-top-form-quarto!", code)
end

-- Require and evaluate clay.
-- Opens localhost page.
M.ClayBrowse = function()
  local code = require_wrapper("(scicloj.clay.v2.snippets/browse!)")
  try_conj_eval("browse!", code)
end

M.ClayWatch = function()
  local code = require_wrapper("(scicloj.clay.v2.snippets/watch! {:ide :neovim})")
  try_conj_eval("watch!", code)
end

return M
