return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {},
        keys = {
            -- Lazy git
            { "<leader>lg", function() require("snacks").lazygit() end, desc = "lazygit" },
            { "<leader>lgl", function() require("snacks").lazygit.log() end, desc = "lazygit logs" },
            { "<leader>lgb", function() require("snacks").picker.git_branches({ layout = "select" }) end, desc = "pick and switch git branches" },

            -- File explorer
            { "<leader>ef", function() require("snacks").explorer() end, desc = "open snack file explorer" },

            -- File rename
            { "<leader>rN", function() require("snacks").rename.rename_file() end, desc = "fast rename current file" },

            -- Buffer
            { "<leader>dB", function() require("snacks").bufdelete() end, desc = "delete or close buffer  (confirm)" },

            -- Snacks Picker
            { "<leader>ff", function() require("snacks").picker.files() end, desc = "find files" },
            { "<leader>fc", function() require("snacks").picker.files({ cwd = "~/dotfiles/nvim/.config/nvim/lua" }) end, desc = "find nvim config files" },
            { "<leader>fs", function() require("snacks").picker.grep() end, desc = "grep word" },
            { "<leader>fws", function() require("snacks").picker.grep_word() end, desc = "search visual selection or word", mode = { "n", "x" } },
            { "<leader>fk", function() require("snacks").picker.keymaps({ layout = "ivy" }) end, desc = "search keymaps (snacks picker)" },

            { "<leader>vh", function() require("snacks").picker.help() end, desc = "help pages"}
        },
    }
}
