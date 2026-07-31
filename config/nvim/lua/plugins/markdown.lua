return {
  {
    "iamcco/markdown-preview.nvim",
    build = function()
      local app = vim.fn.stdpath("data") .. "/lazy/markdown-preview.nvim/app"
      vim.fn.system({ "npm", "install", "--prefix", app, "--omit=dev" })
      vim.fn.system({ "chmod", "a-x", app .. "/bin/markdown-preview-linux" })
    end,
  },
}
