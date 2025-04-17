local M = {}


local function check_comment(comment_symbol)
    local line_pos = vim.fn.getpos(".")
    local line_num = line_pos[2]

    local line = vim.api.nvim_buf_get_lines(0, line_num - 1, line_num, false)[1]
    local subline = line:sub(1, #comment_symbol)

    return subline == comment_symbol
end


local function check_language()
    local file_name = vim.api.nvim_buf_get_name(0)
    local ext = file_name:match("^.+%.([^.]+)$")

    local symbol_table = {
        c       = "// ",    -- c
        cc      = "// ",    -- c++
        cpp     = "// ",    -- c++
        cs      = "// ",    -- c#
        dart    = "// ",    -- dart
        go      = "// ",    -- go
        java    = "// ",    -- java
        js      = "// ",    -- javascript
        kt      = "// ",    -- kotlin
        lua     = "-- ",    -- lua
        m       = "// ",    -- objective c
        php     = "// ",    -- php
        pl      = "# ",     -- perl
        py      = "# ",     -- python
        r       = "# ",     -- r
        rb      = "# ",     -- ruby
        rs      = "// ",    -- rust
        sh      = "# ",     -- script
        scala   = "// ",    -- scala
        swift   = "// ",    -- swift
        ts      = "// ",    -- typescript
    }

    return symbol_table[ext]
end


local function comment(start_line, end_line, comment_symbol)
    for i = start_line, end_line do
        vim.api.nvim_buf_set_text(0, i - 1, 0, i - 1, 0, {comment_symbol})
    end
end


local function uncomment(start_line, end_line, comment_symbol)
    for i = start_line, end_line do
        vim.api.nvim_buf_set_text(0, i - 1, 0, i - 1, #comment_symbol, {""})
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

    local comment_symbol = check_language()

    if check_comment(comment_symbol) then
        uncomment(start_line, end_line, comment_symbol)
    else
        comment(start_line, end_line, comment_symbol)
    end
end


function M.setup()
    -- Place Holder Keybind
    vim.keymap.set({ "v" }, "<leader>/", ez_comment)
end


return M
