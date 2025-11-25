return {
    "nvim-telescope/telescope.nvim",
    branch = "master", -- using master to fix issues with deprecated to definition warnings. use '0.1.x' for stable ver.
    dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
	},

    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")
        local builtin = require("telescope.builtin")

        telescope.setup({
            defaults = {
                path_display = { "smart" },
                mappings = {
                    i = {
                        ["<C-k>"] = actions.move_selection_previous,
						["<C-j>"] = actions.move_selection_next,
                    },
                },
            },
        })

        -- Keymap
        vim.keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "juzzy find recent files" })
        vim.keymap.set("n", "<leader>fWs", function()
			local word = vim.fn.expand("<cWORD>")
			builtin.grep_string({ search = word })       
        end, { desc = "find connected words under cursor" })
        
    end
}
