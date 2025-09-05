-- bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
require("lazy").setup({
  -- LSP + tools
  "neovim/nvim-lspconfig",
  "williamboman/mason.nvim",
  "williamboman/mason-lspconfig.nvim",

  -- Completion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
    },
  },

  --theme
  { "folke/tokyonight.nvim", lazy = false, priority = 1000, opts = {} },
})

-- mason setup (language server installer)
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {
    "clangd",   -- C / C++
    "pyright",  -- Python
    "texlab",   -- LaTeX
  },
}

-- keymaps for LSP
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
end

-- LSP setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require("lspconfig")

-- C / C++
lspconfig.clangd.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

-- Python
lspconfig.pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities,
}

--LaTeX
lspconfig.texlab.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  }


-- nvim-cmp setup (autocompletion)
local cmp = require("cmp")
cmp.setup {
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
  }),
}

-- format on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.cpp", "*.h", "*.c", "*.py" },
  callback = function() vim.lsp.buf.format() end
})

--
--make pretty
--

--numbering
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.wrap = false

--theme
vim.cmd[[colorscheme tokyonight]]

