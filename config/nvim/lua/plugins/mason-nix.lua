return {
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      local nix_provided = {
        clangd = true,
        codelldb = true,
        marksman = true,
        neocmakelsp = true,
      }
      opts.ensure_installed = vim.tbl_filter(function(tool)
        return not nix_provided[tool]
      end, opts.ensure_installed or {})
    end,
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      -- Never download DAP adapters via Mason on NixOS: dynamically linked
      -- Mason binaries fail with stub-ld (exit 127). Adapters come from Nix
      -- (system-wide codelldb wrapper + lldb in home.nix).
      automatic_installation = false,
      ensure_installed = {},
      handlers = {},
    },
  },
  {
    "nvim-lspconfig",
    opts = {
      servers = {
        clangd = {
          mason = false,
          cmd = {
            "clangd",
            "--background-index",
            "--clang-tidy",
            "--header-insertion=iwyu",
            "--completion-style=detailed",
            "--function-arg-placeholders=1",
            "--fallback-style=llvm",
            "--query-driver=/nix/store/*/bin/g++,/nix/store/*/bin/gcc,/nix/store/*/bin/c++,/nix/store/*/bin/cc,/nix/store/*/bin/clang++,/nix/store/*/bin/clang",
          },
        },
        neocmake = { mason = false },
        marksman = { mason = false },
      },
    },
  },
}
