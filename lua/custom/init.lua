local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Misc
function OpenExplorer()
  vim.cmd "!explorer.exe . &"
end

vim.api.nvim_create_user_command("Exp", OpenExplorer, {})
vim.api.nvim_create_user_command("Explorer", OpenExplorer, {})

vim.wo.relativenumber = true

vim.g.dap_virtual_text = true

vim.g.netrw_browse_split = 0
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 25