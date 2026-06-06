return {
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = { enabled = false },
        nixd = {
          cmd = { "nixd" },
          filetypes = { "nix" },
        },
      },
    },
  },
}
