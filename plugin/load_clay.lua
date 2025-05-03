vim.api.nvim_create_user_command("ClayBrowse", function()
require("clay").ClayBrowse()
end, {})

vim.api.nvim_create_user_command("ClayWatch", function()
require("clay").ClayWatch()
end, {})

vim.api.nvim_create_user_command("ClayStart", function()
require("clay").ClayStart()
end, {})
