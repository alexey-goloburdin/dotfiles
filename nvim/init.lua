
vim.opt.mouse = "a" -- Enable mouse support
vim.opt.encoding = "utf-8"       -- Общая кодировка (необязательно, по умолчанию UTF-8)
vim.opt.fileencoding = "utf-8"  -- Кодировка файлов
vim.opt.number = true -- Show line numbers
vim.opt.cursorline = false -- Disable highlight current cursor's line
vim.opt.swapfile = false -- Disable .swp files 
vim.opt.scrolloff = 7 -- Number of lines left visible above/below the cursor when scrolling
vim.opt.tabstop = 4 -- Spaces instead of one tab
vim.opt.softtabstop = 4 -- Spaces instead of one tab
vim.opt.shiftwidth = 4 -- Spaces for auto indent
vim.opt.expandtab = true -- Replace tab with spaces
vim.opt.autoindent = true -- Save indent on new line
vim.opt.fileformat = "unix"
vim.opt.smartindent = true
vim.opt.splitbelow = true -- horizontal split open below and right
vim.opt.splitright = true
vim.g.mapleader = ',' -- Leader key
vim.opt.termguicolors = true -- 24-bit colors

-- Keymaps for programming languages
vim.api.nvim_create_autocmd('FileType', {

    pattern = 'python',
    callback = function()

        vim.opt.colorcolumn = '88'
        vim.keymap.set('n', '<C-h>', ':w<CR>:!python3.11 %<CR>', { buffer = true, silent = true })
        vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!python3.11 %<CR>', { buffer = true, silent = true })
    end
})


vim.api.nvim_create_autocmd('FileType', {
    pattern = 'c',
    callback = function()
        vim.keymap.set('n', '<C-h>', ':w<CR>:!gcc % -o out; ./out<CR>', { buffer = true, silent = true })
        vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!gcc % -o out; ./out<CR>', { buffer = true, silent = true })
    end
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = {'sh', 'go'},
    callback = function()
        vim.keymap.set('n', '<C-h>', ':w<CR>:!%<CR>', { buffer = true, silent = true })
        vim.keymap.set('i', '<C-h>', '<Esc>:w<CR>:!%<CR>', { buffer = true, silent = true })
    end
})

--


-- Common keymaps
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })
vim.keymap.set('n', ',<Space>', ':nohlsearch<CR>', { noremap = true })
vim.keymap.set('n', 'H', 'gT', { noremap = true }) -- Переключение вкладок
vim.keymap.set('n', 'L', 'gt', { noremap = true })
vim.keymap.set('n', ',f', ':Telescope find_files<CR>', { noremap = true })
vim.keymap.set('n', ',g', ':Telescope live_grep<CR>', { noremap = true })
vim.keymap.set('n', 'gw', ':bp|bd #<CR>', { noremap = true, silent = true })

-- Plugins with packer.nvim
require('packer').startup(function(use)

    use 'wbthomason/packer.nvim'

    use 'nvim-lua/plenary.nvim' -- For Telescope plugin
    use 'neovim/nvim-lspconfig' -- LSP
    use 'hrsh7th/nvim-cmp' -- Autocomplete
    use 'hrsh7th/cmp-nvim-lsp'
    use 'saadparwaiz1/cmp_luasnip'
    use 'L3MON4D3/LuaSnip' -- Сниппеты
    use 'nvim-treesitter/nvim-treesitter' -- Подсветка синтаксиса

    use 'morhetz/gruvbox' -- Color schemes
    use 'ayu-theme/ayu-vim'
    --[[
    use({
      'rose-pine/neovim',
      as = 'rose-pine',
      config = function()
        require('rose-pine').setup({
          dark_variant = 'main', -- Variants: 'main', 'moon', 'dawn'
          disable_background = true, -- Disable background
          disable_float_background = false, -- Disable background for windows
        })
        vim.cmd('colorscheme rose-pine')
      end,
    })
    --]]
    use 'sainnhe/gruvbox-material'
    use 'rebelot/kanagawa.nvim'

    -- Comment/uncomment by gcc for current line of gc for seleted lines
    use {
      'numToStr/Comment.nvim',
      config = function()
        require('Comment').setup({
            -- Включить/отключить добавление пробела после символа комментария
            padding = true,
            -- Переназначаем ключевые привязки
            toggler = {
                line = ',cc',  -- Закомментировать строку (вместо 'gcc')
                block = ',cb', -- Закомментировать блок (вместо 'gbc')
            },
            opleader = {
                line = ',c',   -- Закомментировать строки в визуальном режиме (вместо 'gc')
                block = ',b',  -- Закомментировать блоки в визуальном режиме (вместо 'gb')
            },
        })
      end
    }

    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzf-native.nvim'
    use 'Pocco81/auto-save.nvim' -- Автосохранение
    use 'jose-elias-alvarez/null-ls.nvim' -- Форматирование и линтинг
end)

-- Color scheme
--vim.cmd([[colorscheme "rose-pine-main"]])
vim.cmd([[colorscheme kanagawa-dragon]]) -- kanagawa-wave, kanagawa-dragon, kanagawa-lotus

-- LSP
local lspconfig = require('lspconfig')
local capabilities = require('cmp_nvim_lsp').default_capabilities()
local on_attach = function(client, bufnr)

    -- Быстрые команды для LSP
    local opts = { buffer = bufnr, noremap = true, silent = true }
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)

    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
    vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)
    vim.keymap.set('n', '<space>f', function()
      vim.lsp.buf.format { async = true }
    end, opts)
end

-- Настройка LSP для Python (Pyright)
lspconfig.pyright.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        python = {
            analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
            },
        },
    },
})

-- Пример настройки LSP для TypeScript
lspconfig.ts_ls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

-- Пример настройки LSP для Go
lspconfig.gopls.setup({
    cmd = { "gopls" }, -- Убедитесь, что `gopls` доступен в PATH
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    },
})

-- Пример настройки LSP для Rust
lspconfig.rust_analyzer.setup({
    cmd = { "rust-analyzer" }, -- Убедитесь, что `rust-analyzer` доступен в PATH
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
            },
            procMacro = {
                enable = true,
            },
        },
    },
})

-- Null-ls для Prettier
require('null-ls').setup({
    sources = {
        require('null-ls').builtins.formatting.prettier,
    }

})

-- Telescope
require('telescope').setup()
require('telescope').load_extension('fzf')

-- Auto-save
require('auto-save').setup()

-- Copy selected text to Windows buffer with "*y
vim.g.clipboard = {
  name = 'win32yank',
  copy = {
    ['+'] = 'win32yank.exe -i',
    ['*'] = 'win32yank.exe -i',
  },
  paste = {
    ['+'] = 'powershell -noprofile -command "Get-Clipboard"',
    ['*'] = 'powershell -noprofile -command "Get-Clipboard"',
  },
  cache_enabled = 0,
}

-- Autocomplete settings
local cmp = require('cmp')
local luasnip = require('luasnip')
cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  completion = {
    autocomplete = false, -- Отключить автоматическое появление
  },
  mapping = {
    ['<C-Space>'] = cmp.mapping.complete(), -- Вызов меню автокомплита
    ['<C-e>'] = cmp.mapping.abort(), -- Закрыть меню
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Подтвердить выбор
    ['<C-p>'] = cmp.mapping.select_prev_item(), -- Навигация вверх
    ['<C-n>'] = cmp.mapping.select_next_item(), -- Навигация вниз
  },
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },  -- Источник из LSP
        { name = 'luasnip' },  -- Источник для сниппетов
    }),
})

-- transparent bg — remove if you want
vim.cmd([[
  highlight Normal guibg=NONE ctermbg=NONE
  highlight NonText guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]])

