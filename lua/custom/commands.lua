function OpenExplorer()
    vim.cmd "!explorer.exe . &"
end

vim.api.nvim_create_user_command("Exp", OpenExplorer, {})
vim.api.nvim_create_user_command("Explorer", OpenExplorer, {})