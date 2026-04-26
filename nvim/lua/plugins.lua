local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local tokyonight = {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        require("tokyonight").setup({
            style = "storm",
            transparent = true,
        })
        vim.cmd("colorscheme tokyonight")
    end,
}

local autopairs = {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
        require("nvim-autopairs").setup({
            check_ts = true,  
        })
    end,
}

local lualine = {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("lualine").setup({
            options = {
                theme = "auto",
                icons_enabled = true,
                section_separators = { left = "", right = "" },
                component_separators = { left = "", right = "" },
                globalstatus = true,
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "buffers" },
                lualine_c = { { "diagnostics", sources = { "nvim_lsp" } } },
                lualine_x = {},
                lualine_y = {},
                lualine_z = { "location" },
            },
        })
    end,
}

local treesitter = {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        require("nvim-treesitter.configs").setup({
            ensure_installed = {
                "python", "cpp", "c", "lua", "vimdoc", "bash", "json", "yaml", "markdown"
            },
            highlight = { enable = true },
            indent = { enable = true },
            auto_install = true,
        })
    end,
}

local cmp = {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
        "L3MON4D3/LuaSnip",             
        "saadparwaiz1/cmp_luasnip",     
        "rafamadriz/friendly-snippets", 
    },
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")

        require("luasnip.loaders.from_vscode").lazy_load()

        cmp.setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<C-Space>"] = cmp.mapping.complete(),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            }),
        })
    end,
}

local lspconfig = {
    "neovim/nvim-lspconfig",
    config = function()
        local lspconfig = require("lspconfig")
        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        lspconfig.pyright.setup({
            capabilities = capabilities,
        })

        lspconfig.clangd.setup({
            capabilities = capabilities,
        })
    end,
}

local telescope = {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
        require("telescope").setup({
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { width = 0.9 },
                sorting_strategy = "ascending",
                prompt_prefix = "   ",
            },
        })
    end,
}

local indentblankline = {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {},
}

require("lazy").setup({
    tokyonight,
    autopairs,
    lualine,
    treesitter,
    cmp,
    lspconfig,
    telescope,
    indentblankline,
})
