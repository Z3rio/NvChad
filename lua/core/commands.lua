-- normal commands
function OpenExplorer()
  vim.cmd("!explorer.exe .")
end

vim.api.nvim_create_user_command("Exp", OpenExplorer, {})
vim.api.nvim_create_user_command("Explorer", OpenExplorer, {})

-- auto commands
local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
local events = {"VimResized", "BufAdd", "BufDelete", "BufNew"}
for i = 1, #events do
  autocmd(events[i], {
    pattern = "*",
    command = "tabdo wincmd =",
  })
end