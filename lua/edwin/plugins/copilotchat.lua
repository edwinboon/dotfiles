return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			{ "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		opts = {},
		keys = {
			{ "<leader>zc", ":CopilotChatOpen <CR>", mode = "n", desc = "Chat with Copilot" },
			{ "<leader>zC", ":CopilotChatClose<CR>", mode = "n", desc = "Close CopilotChat" },
			{ "<leader>zR", ":CopilotChatReset<CR>", mode = "n", desc = "Reset CopilotChat" },
			{ "<leader>za", ":CopilotChatAgents<CR>", mode = "n", desc = "List CopilotChat Agents" },
			{ "<leader>zm", ":CopilotChatModels<CR>", mode = "n", desc = "List CopilotChat Models" },
			{ "<leader>ze", ":CopilotChat explain<CR>", mode = "v", desc = "Explain code" },
			{ "<leader>zr", ":CopilotChat review<CR>", mode = "v", desc = "Review code" },
			{ "<leader>zf", ":CopilotChat fix<CR>", mode = "v", desc = "Fix code issues" },
			{ "<leader>zo", ":CopilotChat optimize<CR>", mode = "v", desc = "Optimize code" },
			{
				"<leader>zd",
				":CopilotChat generate docs for this function<CR>",
				mode = "v",
				desc = "Generate documentation",
			},
			{
				"<leader>zt",
				":CopilotChat generate a tests for this function<CR>",
				mode = "v",
				desc = "Generate tests",
			},
		},
	},
}
