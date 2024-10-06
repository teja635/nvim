-- import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

mason.setup()

-- import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

mason_lspconfig.setup({
  ensure_installed = {
    "gopls",
    "golangci_lint_ls",
    "lua_ls",
  },
  automatic_installation = true,
})
