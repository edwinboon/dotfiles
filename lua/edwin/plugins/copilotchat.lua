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
			{ "<leader>zc", ":CopilotChatOpen<CR>", mode = "n", desc = "Chat with Copilot" },
			{ "<leader>zq", ":CopilotChatClose<CR>", mode = "n", desc = "Close chat with Copilot" },
			{ "<leader>ze", ":CopilotChatEdit<CR>", mode = "v", desc = "Explain code" },
			{ "<leader>zr", ":CopilotChatReview<CR>", mode = "v", desc = "Review code" },
			{ "<leader>zf", ":CopilotChatFix<CR>", mode = "v", desc = "Fix code issues" },
			{ "<leader>zo", ":CopilotChatOptimize<CR>", mode = "v", desc = "Optimize code" },
			{ "<leader>zd", ":CopilotChatDocs<CR>", mode = "v", desc = "Generate documentation" },
			{ "<leader>zt", ":CopilotChatTest<CR>", mode = "v", desc = "Generate tests" },
			{ "<leader>zm", ":CopilotChatCommit<CR>", mode = "n", desc = "Generate commit message" },
			{ "<leader>zs", ":CopilotChatCommit<CR>", mode = "v", desc = "Generate commit message from selection" },
		},
	},
}
