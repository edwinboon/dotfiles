return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	event = "VeryLazy",
	version = false, -- Never set this value to "*"! Never!
	---@module 'avante'
	---@type avante.Config
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		instructions_file = "avante.md",
		-- for example
		provider = "claude",
		providers = {
			claude = {
				endpoint = "https://api.anthropic.com",
				model = "claude-3-haiku-20240307",
				timeout = 30000, -- Timeout in milliseconds
				api_key_name = "AVANTE_ANTHROPIC_API_KEY", -- Your environment variable
				temperature = 0.75,
				max_tokens = 4096,
			},
		},
		-- Explicit file selector provider (fzf-lua is already in dependencies)
		file_selector = "fzf",
		-- Context excludes: prevent sensitive files and build artifacts from being included
		-- Note: The exact config key may vary by Avante version. Adjust if needed.
		-- Common patterns: behaviour.context_excludes, exclude_patterns, or file_ignore_patterns
		behaviour = {
			-- Exclude patterns for files/directories that should not be included in context
			auto_suggestions = false, -- Keep this setting
			context_excludes = {
				-- Version control
				".git/",
				-- Dependencies
				"node_modules/",
				"vendor/",
				".venv/",
				"venv/",
				-- Build artifacts
				"dist/",
				"build/",
				"target/",
				"__pycache__/",
				"*.pyc",
				-- Lock files
				"*.lock",
				"package-lock.json",
				"yarn.lock",
				"pnpm-lock.yaml",
				-- Minified files
				"*.min.js",
				"*.min.css",
				"*.min.*",
				-- Secrets and keys (IMPORTANT: never include these)
				".env",
				".env.*",
				"*.pem",
				"*.key",
				"id_rsa",
				"id_rsa.pub",
				"id_ed25519",
				"id_ed25519.pub",
				-- Other common excludes
				".DS_Store",
				"*.log",
				"*.tmp",
			},
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-mini/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		"zbirenbaum/copilot.lua", -- for providers='copilot'
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
