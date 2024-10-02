return {
    "stevearc/conform.nvim",
    opts = {
        formatters_by_ft = {
            c = { "clang_format" },
            cpp = { "clang_format" },
        },
        formatters = {
            clang_format = {
                args = { "--style=file:~/.config/nvim/.clang-format" },
            },
        },
    }
}
