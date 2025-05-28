
-- Treesitter configuration
require("nvim-treesitter.configs").setup({
  ensure_installed = { "dart", "lua", "markdown", "vimdoc", "cpp" },
  highlight = { enable = true },
})

-- LSP configuration
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Setup language servers
local mason_lspconfig = require("mason-lspconfig")

require("flutter-tools").setup {}
require("deno-nvim").setup{}
