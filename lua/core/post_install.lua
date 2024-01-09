local api = vim.api
local opt_local = vim.opt_local

local function screen()
  local text_on_screen = {
    "enjoy neovim lol",
  }

  local buf = api.nvim_create_buf(false, true)

  vim.opt_local.filetype = "post_bootstrap"
  api.nvim_buf_set_lines(buf, 0, -1, false, text_on_screen)

  local nvpostscreen = api.nvim_create_namespace("nvpostscreen")

  for i = 1, #text_on_screen do
    api.nvim_buf_add_highlight(buf, nvpostscreen, "LazyCommit", i, 0, -1)
  end

  api.nvim_win_set_buf(0, buf)

  -- buf only options
  opt_local.buflisted = false
  opt_local.modifiable = false
  opt_local.number = false
  opt_local.list = false
  opt_local.relativenumber = false
  opt_local.wrap = false
  opt_local.cul = false
end

-- install mason pkgs & show notes on screen after it
return function()
  api.nvim_buf_delete(0, { force = true }) -- close previously opened lazy window

  vim.schedule(function()
    vim.cmd("MasonInstallAll")

    -- Keep track of which mason pkgs get installed
    local packages = table.concat(vim.g.mason_binaries_list, " ")

    require("mason-registry"):on("package:install:success", function(pkg)
      packages = string.gsub(packages, pkg.name:gsub("%-", "%%-"), "") -- rm package name

      -- run above screen func after all pkgs are installed.
      if packages:match("%S") == nil then
        vim.schedule(function()
          api.nvim_buf_delete(0, { force = true })
          vim.cmd("echo '' | redraw") -- clear cmdline
          screen()
        end)
      end
    end)
  end)
end

