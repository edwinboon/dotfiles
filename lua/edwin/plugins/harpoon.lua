return {
	"thePrimeagen/harpoon",
	enabled = true,
	branch = "harpoon2",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},

	config = function()
		local harpoon = require("harpoon")

		harpoon.setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
			},
		})

		--Harpoon Nav Interface
		vim.keymap.set("n", "<leader>h", function()
			harpoon:list():add()
		end, { desc = "harpoon add file" })
		vim.keymap.set("n", "<C-e>", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end)

		--Harpoon marked files
		vim.keymap.set("n", "<C-y>", function()
			harpoon:list():select(1)
		end)
		vim.keymap.set("n", "<C-i>", function()
			harpoon:list():select(2)
		end)
		vim.keymap.set("n", "<C-n>", function()
			harpoon:list():select(3)
		end)
		vim.keymap.set("n", "<C-s>", function()
			harpoon:list():select(4)
		end)

		vim.keymap.set("n", "<leader>hr", function()
			local list = harpoon:list()
			local current_file = vim.api.nvim_buf_get_name(0)

			-- zoek het indexnummer van het huidige bestand in de Harpoon-list
			local idx = nil
			for i, entry in ipairs(list.items) do
				if entry.value == current_file then
					idx = i
					break
				end
			end

			if idx then
				list:remove(idx)
				print("Bestand verwijderd uit Harpoon: " .. current_file)
			else
				print("Huidig bestand staat niet in Harpoon")
			end
		end, { desc = "verwijder huidig bestand uit Harpoon" })

		-- Toggle previous & next buffers stored within Harpoon list
		vim.keymap.set("n", "<C-S-P>", function()
			harpoon:list():prev()
		end)
		vim.keymap.set("n", "<C-S-N>", function()
			harpoon:list():next()
		end)
	end,
}
