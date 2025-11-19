local opts = { noremap = true, silent = true }
local keymap = vim.keymap

vim.g.mapleader = " "
vim.g.maplocalleader = " "

keymap.set("i", "jk", "<ESC>", { desc = "exit insert mode with jk"})

keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "clear search highlights" })

keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual mode" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "moves lines up in visual mode" })

keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in the buffer with the cursor centered" })
keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in the buffer with the cursor centered" })

keymap.set("n", "n", "nzzzv", { desc = "center cursor properly when moving to the next search result" })
keymap.set("n", "N", "Nzzzv", { desc = "center cursor properly when moving to the previous search result" })

keymap.set("v", "<", "<gv", opts, { desc = "indent line to the left" })
keymap.set("v", ">", ">gv", opts, { desc = "indent line to the right" })

-- Clipboard thingies
keymap.set("x", "<leader>p", [["_dP]], { desc = "paste without replacing the clipboard content" })
keymap.set("v", "p", '"_dp', opts, { desc = "prevent pasting from replacing the clipboard in visual mode" })
keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "delete without copying to the clipboard" })
keymap.set("n", "x", '"_x', opts, { desc = "delete a single character without copying to the clipboard" })

keymap.set("n", "<leader>f", vim.lsp.buf.format, { desc = "format code" })

keymap.set("n", "<leader>s", [[:%s/\<<C-R><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], { desc = "replace word cursor is on globally" })

-- Tab thingies
keymap.set("n", "<leader>to", "<cmd><tabnew<CR>", { desc = "open new tab" })
keymap.set("n", "<leader>tx", "<cmd><tabclose<CR>", { desc = "close current tab" })
keymap.set("n", "<leader>tn", "<cmd><tabn<CR>", { desc = "go to next tab" })
keymap.set("n", "<leader>tp", "<cmd><tabp<CR>", { desc = "go to previous tab" })
keymap.set("n", "<leader>tf", "<cmd><tabnew%<CR>", { desc = "open current tab in new tab" })

-- Split window thingies
keymap.set("n", "<leaer>sv", "<C-w>v", { desc = "split window vertically" })
keymap.set("n", "<leaer>sh", "<C-w>s", { desc = "split window horizontally" })
keymap.set("n", "<leaer>sv", "<C-w>>=", { desc = "make splits equal size" })
keymap.set("n", "<leaer>sx", "<cmd>close<CR>", { desc = "close the current split" })

-- Copy filepath to the clipboard
keymap.set("n", "<leader>fp", function()
    local filePath = vim.fn.expand("%:~") -- Gets the file path relative to the home directory
    vim.fn.setreg("+", filePath) -- Copy the file path to the clipboard register
    print("File path copied to clipboard: " .. filePath)
end, { desc = "copy file path to clipboard" })

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})


