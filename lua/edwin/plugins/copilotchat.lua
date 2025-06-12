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
			{ "<leader>zc", ":CopilotChat<CR>", mode = "n", desc = "Chat with Copilot" },
			{ "<leader>ze", ":CopilotChat explain<CR>", mode = "v", desc = "Explain code" },
			{ "<leader>zR", ":CopilotChatReset<CR>", mode = "n", desc = "Reset CopilotChat" },
			{ "<leader>zr", ":CopilotChat review<CR>", mode = "v", desc = "Review code" },
			{ "<leader>zf", ":CopilotChat fix<CR>", mode = "v", desc = "Fix code issues" },
			{ "<leader>zo", ":CopilotChat optimize<CR>", mode = "v", desc = "Optimize code" },
			{ "<leader>zd", ":CopilotChat docs<CR>", mode = "v", desc = "Generate documentation" },
			{ "<leader>zt", ":CopilotChat tests<CR>", mode = "v", desc = "Generate tests" },
			{ "<leader>zm", ":CopilotChat generate_commit_message<CR>", mode = "n", desc = "Generate commit message" },
			{
				"<leader>zs",
				":CopilotChat generate_commit_message<CR>",
				mode = "v",
				desc = "Generate commit message from selection",
			},
		},
	},
}
