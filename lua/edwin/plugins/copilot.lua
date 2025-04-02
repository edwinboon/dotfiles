return {
	"github/copilot.vim",
	config = function()
		vim.g.copilot_no_tab_map = true
		vim.keymap.set("i", "<C-a>", 'copilot#Accept("<CR>")', { expr = true, silent = true, script = true })
		vim.keymap.set("i", "<C-d>", "copilot#Dismiss()", { expr = true, silent = true, script = true })
	end,
}
