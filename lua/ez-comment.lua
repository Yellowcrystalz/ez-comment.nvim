local M = {}


function M.setup()
    -- Place Holder Keybind
    vim.keymap.set({ "v" }, "<leader>cc", comment)
end


function comment()
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")

    local start_line = start_pos[2]
    local end_line = end_pos[2]

    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    for i = start_line, end_line do
        vim.api.nvim_buf_set_text(0, i - 1, 0, i - 1, 0, {"-- "})
    end
end


return M
