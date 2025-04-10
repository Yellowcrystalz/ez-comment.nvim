local M = {}

function M.setup()
    vim.api.nvim_create_user_command("Test", function()
        print("Test!")
    end, {})
end

return M
