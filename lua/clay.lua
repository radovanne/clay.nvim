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

-- Evaluates current namespace and prints as hiccup.
-- Doesn't render page in the browser.
M.ClayPrintNamespaceToHiccup = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format('(scicloj.clay.v2.api/make-hiccup {:source-path "%s"})', source_path)
  conj_eval("clay-eval-ns-to-hiccup", code)
end

-- Require and evaluate clay.
-- Evaluates current form and renders it to browser.
M.ClayMakeFile = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format(
    '(do (require \'[scicloj.clay.v2.snippets]) (scicloj.clay.v2.snippets/make-ns-html! "%s" {:ide :neovim}))',
    source_path
  )
  conj_eval("make-ns-html!", code)
end

M.ClayMakeFileQuarto = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format(
    '(do (require \'[scicloj.clay.v2.snippets]) (scicloj.clay.v2.snippets/make-ns-quarto-html! "%s" {:ide :neovim}))',
    source_path
  )
  conj_eval("make-ns-quarto-html!", code)
end

M.ClayMakeFileRevealjs = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format(
    '(do (require \'[scicloj.clay.v2.snippets]) (scicloj.clay.v2.snippets/make-ns-quarto-revealjs! "%s" {:ide :neovim}))',
    source_path
  )
  conj_eval("make-ns-quarto-revealjs!", code)
end

-- Require and evaluate clay.
-- Evaluates top level form and renders it to browser.
M.ClayMakeCurrentForm = function()
  local form_content = extract.form({}).content
  local source_path = vim.fn.expand("%:p")
  local code = string.format(
    '(do (require \'[scicloj.clay.v2.snippets]) (scicloj.clay.v2.snippets/make-form-html! (quote %s) "%s" {:ide :neovim}))',
    form_content,
    source_path
  )
  conj_eval("make-form-html!", code)
end

-- Require and evaluate clay.
-- Evaluates top level form and renders it to browser.
M.ClayMakeTopLevelForm = function()
  local form_content = extract.form({ root = true }).content
  local source_path = vim.fn.expand("%:p")
  local code = string.format(
    '(do (require \'[scicloj.clay.v2.snippets]) (scicloj.clay.v2.snippets/make-form-html! (quote %s) "%s" {:ide :neovim}))',
    form_content,
    source_path
  )
  conj_eval("make-form-html!", code)
end

M.ClayMakeCurrentFormQuarto = function()
  local form_content = extract.form({}).content
  local source_path = vim.fn.expand("%:p")
  local code = string.format(
    '(do (clojure.core/require \'[scicloj.clay.v2.snippets]) (scicloj.clay.v2.snippets/make-form-quarto-html! (quote %s) "%s" {:ide :neovim}))',
    form_content,
    source_path
  )
  conj_eval("make-current-form-quarto!", code)
end


M.ClayMakeTopLevelFormQuarto = function()
  local form_content = extract.form({ root = true }).content
  local source_path = vim.fn.expand("%:p")
  local code = string.format(
    '(do (clojure.core/require \'[scicloj.clay.v2.snippets]) (scicloj.clay.v2.snippets/make-form-quarto-html! (quote %s) "%s" {:ide :neovim}))',
    form_content,
    source_path
  )
  conj_eval("make-top-form-quarto!", code)
end

-- Require and evaluate clay.
-- Opens localhost page.
M.ClayBrowse = function()
  local code =
    string.format("(do (clojure.core/require '[scicloj.clay.v2.snippets]) (scicloj.clay.v2.snippets/browse!))")
  conj_eval("browse!", code)
end

M.ClayWatch = function()
  local code = string.format(
    "(do (clojure.core/require '[scicloj.clay.v2.snippets]) (scicloj.clay.v2.snippets/watch! {:ide :neovim}))"
  )
  conj_eval("watch!", code)
end

return M
