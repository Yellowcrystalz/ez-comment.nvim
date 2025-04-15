local M = {}


function M.setup()
    -- Place Holder Keybind
    vim.keymap.set({ "v" }, "<leader>/", ez_comment)
end


local function check_comment()
    local line_pos = vim.fn.getpos(".")
    local line_num = line_pos[2]

    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
    local subline = line:sub(1, 3)

    if subline == "-- " then
        return true
    else
        return false
    end
end


local function comment(start_line, end_line)
    for i = start_line, end_line do
        vim.api.nvim_buf_set_text(0, i - 1, 0, i - 1, 0, {"-- "})
    end
end


local function uncomment(start_line, end_line)
    for i = start_line, end_line do
        vim.api.nvim_buf_set_text(0, i - 1, 0, i - 1, 3, {""})
    end
end


function ez_comment()
    local start_pos = vim.fn.getpos("v")
    local end_pos = vim.fn.getpos(".")

    local start_line = start_pos[2]
    local end_line = end_pos[2]

    if start_line > end_line then
        start_line, end_line = end_line, start_line
    end

    if check_comment() then
        uncomment(start_line, end_line)
    else
        comment(start_line, end_line)
    end
end


return M
