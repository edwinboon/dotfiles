return {
	"edwinboon/azure.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local azfetch = require("azfetch")

		azfetch.setup({
			decrypt = true,
			keymaps = {
				fetch_app_settings = "<leader>af",
			},
		})

		-- Optionally, add a command or keymap for checking the version
		vim.keymap.set("n", "<leader>azv", function()
			azfetch.get_version()
		end, { desc = "Check azfetch.nvim version" })
	end,
}
