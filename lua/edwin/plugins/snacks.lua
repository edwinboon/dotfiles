return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {},
        keys = {
            -- Lazy git
            { "<leader>lg", function() require("snacks").lazygit() end, desc = "lazygit" },
            { "<leader>gl", function() require("snacks").lazygit.log() end, desc = "lazygit logs" },

            -- File explorer
            { "<leader>ef", function() require("snacks").explorer() end, desc = "open snack file explorer"}

            -- File rename
            { "<leader>rN" function() require("snacks").rename.rename_file() end, desc = "fast rename current file" },

            -- Buffer
            { "<leader>dB", function() require("snacks").bufdelete() end, desc = "delete or close buffer  (confirm)" },
        },
    }
}
