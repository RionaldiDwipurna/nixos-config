return {
  "nickjvandyke/opencode.nvim",
  version = "*",
  dependencies = {
    {
      "folke/snacks.nvim",
      optional = true,
      opts = {
        input = {},
        picker = {
          actions = {
            opencode_send = function(...)
              return require("opencode").snacks_picker_send(...)
            end,
          },
          win = {
            input = {
              keys = {
                ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
              },
            },
          },
        },
      },
    },
  },
  config = function()
    vim.g.opencode_opts = {}
    vim.o.autoread = true

    vim.api.nvim_create_autocmd(
      { "FocusGained", "BufEnter", "CursorHold", "CursorHoldI", "WinEnter", "InsertLeave" },
      {
        pattern = "*",
        callback = function() vim.cmd("checktime") end,
      }
    )

    vim.keymap.set({ "n", "x" }, "<leader>oa", function()
      require("opencode").ask("@this: ", { submit = true })
    end, { desc = "opencode: Ask about current line/selection" })

    vim.keymap.set({ "n", "x" }, "<leader>oo", function()
      require("opencode").select()
    end, { desc = "opencode: Action picker" })

    vim.keymap.set({ "n", "t" }, "<leader>ot", function()
      require("opencode").toggle()
    end, { desc = "opencode: Toggle terminal" })
  end,
}
