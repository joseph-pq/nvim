local builtin = require('telescope.builtin')

vim.keymap.set('n', '<leader>tF', builtin.find_files, {})
vim.keymap.set('n', '<leader>tB', builtin.buffers, {})
vim.keymap.set('n', '<leader>tl', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tH', builtin.help_tags, {})
vim.keymap.set('n', '<leader>tD', builtin.diagnostics, {})
vim.keymap.set('n', '<leader>tG', function()
    builtin.git_files({ recurse_submodules = true })
end, {})
vim.keymap.set('n', '<leader>tg', function()
    builtin.grep_string({ search = vim.fn.input("Grep > ") });
end)

-- telescope config files
vim.keymap.set("n", "<leader>tc", function()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        print("Not inside a Git repository")
        return
    end
    require("telescope.builtin").find_files({
        cwd = git_root .. "/configs",
        no_ignore = true
    })
end, { desc = "Find files in config directory" })
vim.keymap.set("n", "<leader>tC", function()
    local git_root = vim.fn.systemlist("git rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        print("Not inside a Git repository")
        return
    end
    require("telescope.builtin").find_files({
        cwd = git_root,
        search_file = ".env*",
        no_ignore = true
    })
end)
