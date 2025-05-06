vim.api.nvim_create_user_command("ClayBrowse", function()
require("clay").ClayBrowse()
end, {})

vim.api.nvim_create_user_command("ClayWatch", function()
require("clay").ClayWatch()
end, {})

vim.api.nvim_create_user_command("ClayStart", function()
require("clay").ClayStart()
end, {})

vim.api.nvim_create_user_command("MakeFormQuartoHtml", function()
require("clay").MakeFormQuartoHtml()
end, {})

vim.api.nvim_create_user_command("ClayMakeFormHtml", function()
require("clay").ClayMakeFormHtml()
end, {})

vim.api.nvim_create_user_command("ClayMakeNamespaceQuartoRevealjs", function()
require("clay").ClayMakeNamespaceQuartoRevealjs()
end, {})

vim.api.nvim_create_user_command("ClayMakeNamespaceQuartoHtml", function()
require("clay").ClayMakeNamespaceQuartoHtml()
end, {})

vim.api.nvim_create_user_command("ClayMakeNamespaceHtml", function()
require("clay").ClayMakeNamespaceHtml()
end, {})
