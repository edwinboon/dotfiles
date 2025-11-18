return {
	"yetone/avante.nvim",
	event = "VeryLazy",
	version = false,
	opts = {
		instructions_file = "avante.md",
		provider = "claude",
		providers = {
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-sonnet-4-20250514",
				timeout = 30000,
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 20480,
				},
			},
			moonshot = {
				endpoint = "https://api.moonshot.ai/v1",
				model = "kimi-k2-0711-preview",
				timeout = 30000,
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 32768,
				},
			},
		},
		mappings = {
			["<leader>a"] = { "<cmd>AvanteMenu<cr>", desc = "Avante: Open menu" },
			["<leader>as"] = { "<cmd>AvanteSession<cr>", desc = "Avante: Save session" },
			["<leader>al"] = { "<cmd>AvanteLoadSession<cr>", desc = "Avante: Load session" },
			["<leader>bb"] = { "<cmd>AvanteBuffers<cr>", desc = "Avante: List buffers" },
			["<leader>bd"] = { "<cmd>AvanteCloseBuffer<cr>", desc = "Avante: Close buffer" },
			["<leader>ff"] = { "<cmd>AvanteFiles<cr>", desc = "Avante: Find files" },
			["<leader>fr"] = { "<cmd>AvanteRecentFiles<cr>", desc = "Avante: Recent files" },
			["<leader>gg"] = { "<cmd>AvanteGit<cr>", desc = "Avante: Git status" },
			["<leader>gb"] = { "<cmd>AvanteGitBranches<cr>", desc = "Avante: Git branches" },
			["<leader>gc"] = { "<cmd>AvanteGitCommits<cr>", desc = "Avante: Git commits" },
			["<leader>/"] = { "<cmd>AvanteLiveGrep<cr>", desc = "Avante: Live grep" },
			["<leader>fh"] = { "<cmd>AvanteHelpTags<cr>", desc = "Avante: Help tags" },
			["<leader>mm"] = { "<cmd>AvanteMarks<cr>", desc = "Avante: List marks" },
			["<leader>:"] = { "<cmd>AvanteCommands<cr>", desc = "Avante: Commands" },
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-mini/mini.pick",
		"nvim-telescope/telescope.nvim",
		"hrsh7th/nvim-cmp",
		"ibhagwan/fzf-lua",
		"stevearc/dressing.nvim",
		"folke/snacks.nvim",
		"nvim-tree/nvim-web-devicons",
		"zbirenbaum/copilot.lua",
		{
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					use_absolute_path = true,
				},
			},
		},
		{
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
