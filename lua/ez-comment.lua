local M = {}


function M.setup()
    -- Place Holder Keybind
    vim.keymap.set({"n"}, "<leader>cc", comment)
end


function comment()
    local row = vim.api.nvim_win_get_cursor(0)[1]
    vim.api.nvim_buf_set_text(0, row - 1, 0, row - 1, 0, {"-- "})
end


return M
