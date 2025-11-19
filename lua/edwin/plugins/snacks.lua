return {
    {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        opts = {
            explorer = {
                enabled = true,
                layout = {
                    cycle = false,
                },
            },
            quickfile = {
                enabled = true,
                exclude = { "latex" },
            },
            -- read picker docs @ https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
            picker = {
                enabled = true,
                matchers = {
                    frecency = true,
                    cwd_bonus = true,
                },
                formatters = {
                    file = {
                        filename_first = false,
                        filename_only = false,
                        icon_width = 2,
                    },
                },
                layout = {
                    preset = "telescope",
                    cycle = false,
                },
                layouts = {
                    select = {
                        preview = false,
                        layout = {
                            backdrop = false,
                            width = 0.6,
                            min_width = 80,
                            height = 0.4,
                            min_height = 10,
                            box = "vertical",
                            border = "rounded",
                            title = "{title}",
                            title_pos = "center",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                            { win = "preview", title = "{preview}", width = 0.6, height = 0.4, border = "top" },
                        },
                    },
                    telescope = {
                        reverse = true, -- set to false for search bar to be on top 
                        layout = {
                            box = "horizontal",
                            backdrop = false,
                            width = 0.8,
                            height = 0.9,
                            border = "none",
                            {
                                box = "vertical",
                                { win = "list", title = " Results ", title_pos = "center", border = "rounded" },
                                { win = "input", height = 1, border = "rounded", title = "{title} {live} {flags}", title_pos = "center" },
                            },
                            {
                                win = "preview",
                                title = "{preview:Preview}",
                                width = 0.50,
                                border = "rounded",
                                title_pos = "center",
                            },
                        },
                    },
                    ivy = {
                        layout = {
                            box = "vertical",
                            backdrop = false,
                            width = 0,
                            height = 0.4,
                            position = "bottom",
                            border = "top",
                            title = " {title} {live} {flags}",
                            title_pos = "left",
                            { win = "input", height = 1, border = "bottom" },
                            {
                                box = "horizontal",
                                { win = "list", border = "none" },
                                { win = "preview", title = "{preview}", width = 0.5, border = "left" },
                            },
                        },
                    },
                },
            },
            dashboard = {
                enabled = true,
                sections = {
                    { section = "header" },
                    { section = "keys", gap = 1, padding = 1 },
                    { section = "startup" },
                    -- {
                    --     section = "terminal",
                    --     cmd = "ascii-image-converter ~/Desktop/Others/profiles.JPG -C -c",
                    --     random = 15,
                    --     pane = 2,
                    --     indent = 15,
                    --     height = 20,
                    -- },
                },
            },
        },
        keys = {
            -- Lazy git
            { "<leader>lg",   function() require("snacks").lazygit() end, desc = "lazygit" },
            { "<leader>lgl",  function() require("snacks").lazygit.log() end, desc = "lazygit logs" },
            { "<leader>lgb",  function() require("snacks").picker.git_branches({ layout = "select" }) end, desc = "pick and switch git branches" },

            -- File explorer
            { "<leader>ef",   function() require("snacks").explorer() end, desc = "open snack file explorer" },

            -- File rename
            { "<leader>rN",   function() require("snacks").rename.rename_file() end, desc = "fast rename current file" },

            -- Buffer
            { "<leader>dB",   function() require("snacks").bufdelete() end, desc = "delete or close buffer  (confirm)" },

            -- Snacks Picker
            { "<leader>ff",   function() require("snacks").picker.files() end, desc = "find files" },
            { "<leader>fc",   function() require("snacks").picker.files({ cwd = "~/dotfiles/nvim/.config/nvim/lua" }) end, desc = "find nvim config files" },
            { "<leader>fs",   function() require("snacks").picker.grep() end, desc = "grep word" },
            { "<leader>fws",  function() require("snacks").picker.grep_word() end, desc = "search visual selection or word", mode = { "n", "x" } },
            { "<leader>fk",   function() require("snacks").picker.keymaps({ layout = "ivy" }) end, desc = "search keymaps (snacks picker)" },

            -- Help
            { "<leader>vh",   function() require("snacks").picker.help() end, desc = "help pages" },
        },
    },
    -- NOTE: todo comments w/ snacks
    {
        "folke/todo-comments.nvim",
        event = { "BufReadPre", "BufNewFile" },
        optional = true,
        keys = {
            { "<leader>pt", function() require("snacks").picker.todo_comments() end, desc = "All" },
            { "<leader>pT", function() require("snacks").picker.todo_comments({ keywords = { "TODO","FORGETNOT","FIXME" } }) end, desc = "mains" },
        },
    }
}
