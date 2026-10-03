-- NixOS-native C/C++ debugging (no Mason downloads).
-- Backend: system-wide `codelldb` wrapper from home.nix with `lldb-dap`
-- (from the `lldb` package) as fallback.
-- Requires: `lazyvim.plugins.extras.dap.core` in lazyvim.json (provides
-- mfussenegger/nvim-dap, dap-ui, virtual-text + <leader>d keymaps).
--
-- NOTE: never point these at Mason's bin/ on NixOS. Mason prepends its
-- bin/ to nvim's PATH, so a bare `command = "codelldb"` resolves to
-- ~/.local/share/nvim/mason/bin/codelldb, which is dynamically linked for
-- generic Linux and dies with stub-ld (exit 127). mason-nvim-dap is pinned
-- to automatic_installation = false in mason-nix.lua for the same reason.
return {
  {
    "mfussenegger/nvim-dap",
    opts = function(_, _)
      local dap = require("dap")

      -- Absolute NixOS per-user profile path: stable across rebuilds and
      -- immune to Mason's PATH shadowing. Falls back to PATH lookup
      -- (which finds the same wrapper once Mason's copy is uninstalled).
      local nix_codelldb = "/etc/profiles/per-user/rdwp/bin/codelldb"
      local codelldb_cmd = vim.fn.executable(nix_codelldb) == 1 and nix_codelldb or "codelldb"

      -- Primary: codelldb (best UX, LazyVim default). Started per-session
      -- on ${port}.
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          command = codelldb_cmd,
          args = { "--port", "${port}" },
        },
      }

      -- Fallback: LLVM's bundled DAP server, already on PATH as `lldb-dap`.
      dap.adapters.lldb = {
        type = "executable",
        command = "lldb-dap",
      }

      local function build_program()
        return vim.fn.getcwd() .. "/build/MainProgram"
      end

      local mine = {
        {
          name = "Launch MainProgram (codelldb)",
          type = "codelldb",
          request = "launch",
          program = build_program,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
        {
          name = "Launch MainProgram (lldb-dap)",
          type = "lldb",
          request = "launch",
          program = build_program,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
          initCommands = {
            "settings set target.x86-disassembly-flavor intel",
          },
        },
        {
          name = "Launch picked executable (codelldb)",
          type = "codelldb",
          request = "launch",
          program = function()
            return vim.fn.input("Executable: ", vim.fn.getcwd() .. "/build/", "file")
          end,
          cwd = "${workspaceFolder}",
          stopOnEntry = false,
        },
      }

      -- Append (don't overwrite): the clangd extra also defines c/cpp
      -- configs (Launch file / Attach to process) and spec merge order
      -- between the two is fragile.
      for _, lang in ipairs({ "c", "cpp" }) do
        local existing = dap.configurations[lang] or {}
        for i = #mine, 1, -1 do
          table.insert(existing, 1, mine[i])
        end
        -- De-duplicate the extra's "Launch file" prompt, ours covers it.
        dap.configurations[lang] = vim.tbl_filter(function(c)
          return c.name ~= "Launch file"
        end, existing)
      end
    end,
  },
}
