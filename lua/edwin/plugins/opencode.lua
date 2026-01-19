return {
	"NickvanDyke/opencode.nvim",
	dependencies = {
		---@module 'snacks'
		{ "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
	},
	config = function()
		---@type opencode.Opts
		vim.g.opencode_opts = {
			-- Your configuration, if any — see `lua/opencode/config.lua`, or "goto definition" on the type or field.
		}

		-- Required for `opts.events.reload`.
		vim.o.autoread = true

		-- Better keymaps with <leader>o prefix for "opencode"

		-- Toggle opencode window
		vim.keymap.set({ "n", "t" }, "<leader>ot", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode" })

		-- Ask opencode
		vim.keymap.set({ "n", "x" }, "<leader>oa", function()
			require("opencode").ask("@this: ", { submit = true })
		end, { desc = "Ask opencode" })

		-- Execute action/select
		vim.keymap.set({ "n", "x" }, "<leader>ox", function()
			require("opencode").select()
		end, { desc = "Execute opencode action" })

		-- Operator mappings (add range/line to opencode)
		vim.keymap.set({ "n", "x" }, "<leader>oo", function()
			return require("opencode").operator("@this ")
		end, { desc = "Add range to opencode", expr = true })

		vim.keymap.set("n", "<leader>ol", function()
			return require("opencode").operator("@this ") .. "_"
		end, { desc = "Add line to opencode", expr = true })

		-- Scroll opencode window
		vim.keymap.set("n", "<leader>ou", function()
			require("opencode").command("session.half. page.up")
		end, { desc = "Scroll opencode up" })

		vim.keymap.set("n", "<leader>od", function()
			require("opencode").command("session.half.page. down")
		end, { desc = "Scroll opencode down" })

		-- Quick access:  Still keep Ctrl-.  for quick toggle
		vim.keymap.set({ "n", "t" }, "<C-.>", function()
			require("opencode").toggle()
		end, { desc = "Toggle opencode (quick)" })
	end,
}
