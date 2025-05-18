vim.api.nvim_create_user_command("ClayBrowse", function()
require("clay").ClayBrowse()
end, {})

vim.api.nvim_create_user_command("ClayWatch", function()
require("clay").ClayWatch()
end, {})

vim.api.nvim_create_user_command("ClayPrintNamespaceToHiccup", function()
require("clay").ClayPrintNamespaceToHiccup()
end, {})

vim.api.nvim_create_user_command("ClayMakeFile", function()
require("clay").ClayMakeFile()
end, {})

vim.api.nvim_create_user_command("ClayMakeFileQuarto", function()
require("clay").ClayMakeFileQuarto()
end, {})

vim.api.nvim_create_user_command("ClayMakeFileRevealjs", function()
require("clay").ClayMakeFileRevealjs()
end, {})

vim.api.nvim_create_user_command("ClayMakeCurrentForm", function()
require("clay").ClayMakeCurrentForm()
end, {})

vim.api.nvim_create_user_command("ClayMakeTopLevelForm", function()
require("clay").ClayMakeTopLevelForm()
end, {})

vim.api.nvim_create_user_command("ClayMakeCurrentFormQuarto", function()
require("clay").ClayMakeCurrentFormQuarto()
end, {})

vim.api.nvim_create_user_command("ClayMakeTopLevelFormQuarto", function()
require("clay").ClayMakeTopLevelFormQuarto()
end, {})
