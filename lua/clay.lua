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

M.setup = function()
  -- nothing yet
end

-- Starts clay session
-- Requires clay automatically into connected REPL without a need to
-- put [scicloj.clay.v2.api :as clay] in :require
M.ClayStart = function()
  local code = string.format("(require '[scicloj.clay.v2.api :as clay])")
  conj_eval("clay-start", code)
end

-- Starts, evaluates and renders html page in browser.
-- Requires clay automatically into connected REPL without a need to
-- put [scicloj.clay.v2.api :as clay] in :require + evaluates and renders html page in the browser.
M.ClayStartAndRender = function()
  local source_path = vim.fn.expand("%:p")
  local code =
    string.format('(do (require \'[scicloj.clay.v2.api :as clay]) (clay/make! {:source-path "%s"}))', source_path)
  conj_eval("clay-start-and-render", code)
end

-- Evaluates and renders current form in the browser.
M.ClayEvalForm = function()
  local form_content = extract.form({ root = true }).content
  local source_path = vim.fn.expand("%:p")
  local code =
    string.format('(scicloj.clay.v2.api/make! {:source-path "%s" :single-form %s})', source_path, form_content)
  conj_eval("clay-eval-form", code)
end

-- Evaluates and renders current namespace in browser.
M.ClayEvalNamespace = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format('(scicloj.clay.v2.api/make! {:source-path "%s"})', source_path)
  conj_eval("clay-eval-ns", code)
end

-- Evaluates current namespace and prints as hiccup.
-- Doesn't render page in the browser.
M.ClayEvalNamespaceToHiccup = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format('(scicloj.clay.v2.api/make-hiccup {:source-path "%s"})', source_path)
  conj_eval("clay-eval-ns-to-hiccup", code)
end

M.ClayMakeNamespaceHtml = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format('(scicloj.clay.v2.api.snippets/make-ns-html! "%s" {:ide :neovim})', source_path)
  conj_eval("make-ns-html!", code)
end

M.ClayMakeNamespaceQuartoHtml = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format('(scicloj.clay.v2.api.snippets/make-ns-quarto-html! "%s" {:ide :neovim})', source_path)
  conj_eval("make-ns-quarto-html!", code)
end

M.ClayMakeNamespaceQuartoRevealjs = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format('(scicloj.clay.v2.api.snippets/make-ns-quarto-revealjs! "%s" {:ide :neovim})', source_path)
  conj_eval("make-ns-quarto-revealjs!", code)
end

M.ClayMakeFormHtml = function()
  local form_content = extract.form({ root = true }).content
  local source_path = vim.fn.expand("%:p")
  local code = string.format(
    '(do (require \'[scicloj.clay.v2.snippets :as clay-snippets]) (clay-snippets/make-form-html! "%s" "%s" {:ide :neovim}))',
    form_content,
    source_path
  )
  conj_eval("make-form-html!", code)
end

M.MakeFormQuartoHtml = function()
  local form_content = extract.form({ root = true }).content
  local source_path = vim.fn.expand("%:p")
  local code = string.format(
    '(scicloj.clay.v2.snippets/make-form-quarto-html! "%s" "%s" {:ide :neovim})',
    form_content,
    source_path
  )
  conj_eval("make-form-quarto-html!", code)
end

M.ClayBrowse = function()
  local code = string.format("(do (clojure.core/require '[scicloj.clay.v2.snippets :as clay-snippets]) (clay-snippets/browse!))")
  conj_eval("browse!", code)
end

M.ClayWatch = function()
  local code =
    string.format("(do (clojure.core/require '[scicloj.clay.v2.snippets :as clay-snippets]) (clay-snippets/watch! {:ide :neovim}))")
  conj_eval("watch!", code)
end

return M
