local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "bash",
    "prisma",
    "lua",
    "luau",
    "luap",
    "html",
    "css",
    "javascript",
    "typescript",
    "tsx",
    "c",
    "cpp",
    "c_sharp",
    "markdown",
    "markdown_inline",
    "vue",
    "scss",
    "json",
    "make",
    "rust",
    "yaml",
    "xml",
    "zig",
    "toml",
    "sql",
    "gitignore",
    "gitcommit",
    "gitattributes",
    "dockerfile",
  },
  indent = {
    enable = true,
    -- disable = {
    --   "python"
    -- },
  },
}

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
    "prettier",

    -- c/cpp stuff
    "clangd",
    "clang-format",

    -- rust
    "rust-analyzer",
  },
}

return M
