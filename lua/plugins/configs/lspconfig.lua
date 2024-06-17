local M = {}
local utils = require("core.utils")
local servers = { "html", "tsserver", "clangd", "cssls" }
local lspconfig = require("lspconfig")

utils.load_mappings("lspconfig")

M.on_attach = function(client, bufnr)
  if client.server_capabilities.signatureHelpProvider then
    require("core.signature").setup(client)
  end

  if not require("core.config").ui.lsp_semantic_tokens and client.supports_method("textDocument/semanticTokens") then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

function CombineTable(table1, table2)
  local retVal = {}

  for i = 1, #table1 do
    table.insert(retVal, table1[i])
  end

  for i = 1, #table2 do
    table.insert(retVal, table2[i])
  end

  return retVal
end

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup({
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  })
end

require("lspconfig").lua_ls.setup({
  on_attach = M.on_attach,
  capabilities = M.capabilities,

  settings = {
    Lua = {
      diagnostics = {
        globals = {
          "vim",
          "MySQL",
          "QBCore",
          "ESX",
          "MySQL.Async",
          "MySQL.Sync",
        },
      },
      workspace = {
        library = CombineTable({
          vim.fn.expand("$VIMRUNTIME/lua"),
          vim.fn.expand("$VIMRUNTIME/lua/vim/lsp"),
          vim.fn.stdpath("data") .. "/lazy/ui/nvchad_types",
          vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy",
        }, require("nvchad_customdata").getPaths()),
        maxPreload = 100000,
        preloadFileSize = 10000,
      },
    },
  },
})

return M
