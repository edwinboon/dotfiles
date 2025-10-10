return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "nvim-lua/plenary.nvim", branch = "master" },
		},
		build = "make tiktoken",
		opts = {
			model = "gpt-4.1",
			temperature = 0.1,
			window = {
				layout = "vertical",
				width = 0.2,
			},
			auto_insert_mode = true,
			headers = {
				user = "👤 Edwin",
				assistant = "🤖 Copilot",
				tool = "🔧 Tool",
			},
		},
		config = function()
			vim.keymap.set(
				"n",
				"<leader>co",
				":CopilotChat #buffer:active<CR>",
				{ desc = "CopilotChat AI with current buffer" }
			)
			vim.keymap.set("n", "<leader>cc", ":CopilotChatClose<CR>", { desc = "Close CopilotChat" })
			vim.keymap.set("n", "<leader>cr", ":CopilotChatReset<CR>", { desc = "Reset CopilotChat" })
		end,
	},
}
