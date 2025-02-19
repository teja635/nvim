vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps

keymap.set("n", "<leader>nh", ":nohl<CR>") -- no highlighting

keymap.set("n", "x", '"_x') -- Do not copy deleted character into register

keymap.set("n", "<leader>+", "<C-a>") -- increment number on cword
keymap.set("n", "<leader>-", "<C-x>") -- decrement number on cword

keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window


keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") -- go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") -- go to previous tab

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>")

vim.keymap.set("n", "<leader>n", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>p", vim.diagnostic.goto_prev)

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>")
keymap.set("n", "<leader>f", ":NvimTreeFindFile<CR>")

-- telescope
keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>") -- find string in current working directory as you type
keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>") -- find string under cursor in current working directory
keymap.set("n", "<leader>fb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>fr", "<cmd>Telescope registers<cr>") -- list copy registers in current neovim instance
keymap.set("n", "<leader>fds", "<cmd>Telescope lsp_document_symbols<cr>") -- list copy registers in current neovim instance
keymap.set("n", "<leader>fh", "<cmd>Telescope oldfiles<cr>") -- list available help tags

keymap.set("n", "<leader>fg", "<cmd>Easypick<cr>") -- open easypick

keymap.set("n", '<leader>sf', ':?func<CR>n|v]M%', { noremap = true, silent = true })

-- errors
keymap.set('n', '<leader>ge', '<cmd>GenerateErrorHandlingErrors<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>gi', '<cmd>GenerateErrorHandlingInfo<CR>', { noremap = true, silent = true })
keymap.set('n', '<leader>gf', '<cmd>GenerateErrorHandlingFatal<CR>', { noremap = true, silent = true })
