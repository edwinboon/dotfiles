return {
	"edwinboon/azure.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local azure = require("azure")

		azure.setup({
			decrypt = true,
			keymaps = {
				fetch_app_settings = "<leader>fa",
			},
		})
	end,
}
