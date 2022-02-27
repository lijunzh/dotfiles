M = {}

M.neoscroll = function()
    pcall(
        function()
            require("neoscroll").setup()
        end
    )
end

return M
