print("LOADED CLAY") -- Will stay here until plugin is ready for main branch

local M = {}
local eval = require("conjure.eval")
local extract = require("conjure.extract")

local function conj_eval(origin, code)
  eval["eval-str"]({
    origin = "custom-clay-wrapper",
    code = code,
  })
end

M.setup = function()
  -- nothing yet
end

M.start = function()
  local code = string.format("(require '[scicloj.clay.v2.api :as clay])")
  conj_eval("custom-clay-wrapper", code)
end

M.start_and_render = function()
  local source_path = vim.fn.expand("%:p")
  local code =
    string.format('(do (require \'[scicloj.clay.v2.api :as clay]) (clay/make! {:source-path "%s"}))', source_path)
  conj_eval("custom-clay-wrapper", code)
end

M.eval_form = function()
  local form_content = extract.form({ root = true }).content
  local source_path = vim.fn.expand("%:p")
  local code =
    string.format('(scicloj.clay.v2.api/make! {:source-path "%s" :single-form %s})', source_path, form_content)

  conj_eval("custom-clay-wrapper", code)
end

M.eval_ns = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format('(scicloj.clay.v2.api/make! {:source-path "%s"})', source_path)
  conj_eval("custom-clay-wrapper", code)
end

M.eval_ns_to_hiccup = function()
  local source_path = vim.fn.expand("%:p")
  local code = string.format('(scicloj.clay.v2.api/make-hiccup {:source-path "%s"})', source_path)
  conj_eval("custom-clay-wrapper", code)
end

return M
