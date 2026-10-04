-- Override the default top-level-only Python section motions.
local function jump_function(backward)
    local pattern = [[\C\v^\s*(async\s+)?def\s+]]
    local flags = backward and 'bW' or 'W'
    local count = vim.v.count1
    local start = vim.api.nvim_win_get_cursor(0)

    vim.cmd("normal! m'")
    -- Search from column zero so [[ skips the current definition line.
    vim.api.nvim_win_set_cursor(0, { start[1], 0 })
    local found = false
    for _ = 1, count do
        if vim.fn.search(pattern, flags) == 0 then
            break
        end
        found = true
    end
    if found then
        vim.cmd('normal! ^')
    else
        vim.api.nvim_win_set_cursor(0, start)
    end
end

vim.keymap.set({ 'n', 'x', 'o' }, ']]', function()
    jump_function(false)
end, { buffer = true, silent = true, desc = 'Next Python function or method' })

vim.keymap.set({ 'n', 'x', 'o' }, '[[', function()
    jump_function(true)
end, { buffer = true, silent = true, desc = 'Previous Python function or method' })
