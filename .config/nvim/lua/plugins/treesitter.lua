return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
            ensure_installed = { "lua", "vim", "javascript", "html", "python", "markdown", "markdown_inline" },
            highlight = { enable = true },
            indent = { enable = true },
        })
    end
}
