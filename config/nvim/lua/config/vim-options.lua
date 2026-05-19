vim.keymap.set("n", "<c-k>", ":wincmd k<CR>")
vim.keymap.set("n", "<c-j>", ":wincmd j<CR>")
vim.keymap.set("n", "<c-h>", ":wincmd h<CR>")
vim.keymap.set("n", "<c-l>", ":wincmd l<CR>")

-- vim.keymap.set("n", "<Leader>nl", "<cmd>lua require'dap'.step_into()<CR>", { desc = "Debugger step into" })
-- vim.keymap.set("n", "<Leader>nj", "<cmd>lua require'dap'.step_over()<CR>", { desc = "Debugger step over" })
-- vim.keymap.set("n", "<Leader>nk", "<cmd>lua require'dap'.step_out()<CR>", { desc = "Debugger step out" })
-- vim.keymap.set("n", "<Leader>nc", "<cmd>lua require'dap'.continue()<CR>", { desc = "Debugger continue" })
-- vim.keymap.set(
-- 	"n",
-- 	"<Leader>nb",
-- 	"<cmd>lua require'dap'.toggle_breakpoint()<CR>",
-- 	{ desc = "Debugger toggle breakpoint" }
-- )
-- vim.keymap.set(
-- 	"n",
-- 	"<Leader>nd",
-- 	"<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
-- 	{ desc = "Debugger set conditional breakpoint" }
-- )
-- vim.keymap.set("n", "<Leader>ne", "<cmd>lua require'dap'.terminate()<CR>", { desc = "Debugger reset" })
-- vim.keymap.set("n", "<Leader>nr", "<cmd>lua require'dap'.run_last()<CR>", { desc = "Debugger run last" })
--
-- -- rustaceanvim
-- vim.keymap.set("n", "<Leader>nt", "<cmd>lua vim.cmd('RustLsp testables')<CR>", { desc = "Debugger testables" })
