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


require("lazy").setup({
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        opts = {
            ensure_installed = { "python", "cpp" },
            highlight = { enable = true },
        },
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
        end
    },

    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = { "nvim-lua/plenary.nvim" },
    },

    {
        "nvim-lualine/lualine.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons", lazy = true },
        opts = {
            options = {
                theme = "ayu_mirage"
            }
        }
    },

    { "Shatur/neovim-ayu", priority = 1000, config = function()
        vim.cmd("colorscheme ayu-mirage")
    end },

    {
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
      require("nvim-autopairs").setup({})
      end, 
    },

    {
      "neovim/nvim-lspconfig",
      event = "BufReadPre",
    },

    {
      "hrsh7th/nvim-cmp",
      config = function()
      require('cmp_config') 
      end,
      dependencies = {
        "hrsh7th/cmp-nvim-lsp",     
        "hrsh7th/cmp-buffer",       
        "hrsh7th/cmp-path",         
        "L3MON4D3/LuaSnip",         
        "saadparwaiz1/cmp_luasnip", 
      },
    },

})

