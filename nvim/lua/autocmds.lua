vim.api.nvim_create_autocmd("InsertLeave", {
    pattern = "*",
    command = "silent! write",
})

vim.api.nvim_create_autocmd("TextYankPost", {
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 })
    end,
})
