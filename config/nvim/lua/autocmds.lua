-- ============================================================================
-- Autocommands
-- ============================================================================

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

local general = augroup("General", { clear = true })
local filetypes = augroup("Filetypes", { clear = true })

-- ============================================================================
-- Buffer Management
-- ============================================================================

-- Reload buffer when file changes on disk
vim.o.autoread = true
autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
    group = general,
    pattern = "*",
    command = "if mode() != 'c' | checktime | endif",
    desc = "Reload buffer when file changes on disk",
})

-- Restore cursor position when opening a file
autocmd("BufReadPost", {
    group = general,
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local lcount = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= lcount then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
    desc = "Restore cursor position",
})

-- ============================================================================
-- Line Numbers
-- ============================================================================

-- Use relative numbers in normal mode, absolute in insert mode
autocmd("InsertEnter", {
    group = general,
    callback = function()
        vim.opt.relativenumber = false
    end,
    desc = "Absolute line numbers in insert mode",
})

autocmd("InsertLeave", {
    group = general,
    callback = function()
        vim.opt.relativenumber = true
    end,
    desc = "Relative line numbers in normal mode",
})

-- ============================================================================
-- Cursorline
-- ============================================================================

-- Show cursorline only in active window
autocmd({ "InsertLeave", "WinEnter" }, {
    group = general,
    callback = function()
        local ok, cl = pcall(vim.api.nvim_win_get_var, 0, "auto-cursorline")
        if ok and cl then
            vim.wo.cursorline = true
            vim.api.nvim_win_del_var(0, "auto-cursorline")
        end
    end,
    desc = "Show cursorline in active window",
})

autocmd({ "InsertEnter", "WinLeave" }, {
    group = general,
    callback = function()
        local cl = vim.wo.cursorline
        if cl then
            vim.api.nvim_win_set_var(0, "auto-cursorline", cl)
            vim.wo.cursorline = false
        end
    end,
    desc = "Hide cursorline in inactive window",
})

-- ============================================================================
-- Yank Highlight
-- ============================================================================

autocmd("TextYankPost", {
    group = general,
    callback = function()
        vim.highlight.on_yank({ higroup = "Visual", timeout = 200 })
    end,
    desc = "Highlight text on yank",
})

-- ============================================================================
-- Filetype Settings
-- ============================================================================

-- Force markdown filetype on .md files
autocmd({ "BufNewFile", "BufRead" }, {
    group = filetypes,
    pattern = "*.md",
    command = "set filetype=markdown",
    desc = "Force markdown filetype",
})

-- Python: 4 spaces
autocmd("FileType", {
    group = filetypes,
    pattern = "python",
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 4
        vim.opt_local.shiftwidth = 4
        vim.opt_local.softtabstop = 4
    end,
    desc = "Python indentation (4 spaces)",
})

-- Lua, TeX: 2 spaces
autocmd("FileType", {
    group = filetypes,
    pattern = { "lua", "tex" },
    callback = function()
        vim.opt_local.expandtab = true
        vim.opt_local.tabstop = 2
        vim.opt_local.shiftwidth = 2
        vim.opt_local.softtabstop = 2
    end,
    desc = "Lua/TeX indentation (2 spaces)",
})

-- Spell checking for text files
autocmd("FileType", {
    group = filetypes,
    pattern = { "gitcommit", "gitrebase", "markdown", "text" },
    callback = function()
        vim.opt_local.spell = true
        vim.opt_local.spelllang = "en_us"
    end,
    desc = "Enable spell checking for text files",
})

-- ============================================================================
-- Autosave Command
-- ============================================================================

vim.g.autosave = false

autocmd({ "InsertLeave", "TextChanged" }, {
    group = general,
    nested = true,
    callback = function()
        if vim.g.autosave and #vim.api.nvim_buf_get_name(0) ~= 0 and vim.bo.buflisted then
            vim.cmd("silent w")
            vim.notify("Saved at " .. os.date("%I:%M %p"), vim.log.levels.INFO)
        end
    end,
    desc = "Autosave on text change",
})

vim.api.nvim_create_user_command("AsToggle", function()
    vim.g.autosave = not vim.g.autosave
    local status = vim.g.autosave and "enabled" or "disabled"
    vim.notify("Autosave " .. status, vim.log.levels.INFO)
end, { desc = "Toggle autosave" })
