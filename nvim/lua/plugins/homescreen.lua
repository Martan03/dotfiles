return {
  "goolord/alpha-nvim",
  opts = function(_, opts)
    local logo = [[
 __       __                     __                        ______   ______
|  \     /  \                   |  \                      /      \ /      \
| ▓▓\   /  ▓▓ ______   ______  _| ▓▓_    ______  _______ |  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\
| ▓▓▓\ /  ▓▓▓|      \ /      \|   ▓▓ \  |      \|       \| ▓▓▓\| ▓▓\▓▓__| ▓▓
| ▓▓▓▓\  ▓▓▓▓ \▓▓▓▓▓▓\  ▓▓▓▓▓▓\\▓▓▓▓▓▓   \▓▓▓▓▓▓\ ▓▓▓▓▓▓▓\ ▓▓▓▓\ ▓▓ |     ▓▓
| ▓▓\▓▓ ▓▓ ▓▓/      ▓▓ ▓▓   \▓▓ | ▓▓ __ /      ▓▓ ▓▓  | ▓▓ ▓▓\▓▓\▓▓__\▓▓▓▓▓\
| ▓▓ \▓▓▓| ▓▓  ▓▓▓▓▓▓▓ ▓▓       | ▓▓|  \  ▓▓▓▓▓▓▓ ▓▓  | ▓▓ ▓▓_\▓▓▓▓  \__| ▓▓
| ▓▓  \▓ | ▓▓\▓▓    ▓▓ ▓▓        \▓▓  ▓▓\▓▓    ▓▓ ▓▓  | ▓▓\▓▓  \▓▓▓\▓▓    ▓▓
 \▓▓      \▓▓ \▓▓▓▓▓▓▓\▓▓         \▓▓▓▓  \▓▓▓▓▓▓▓\▓▓   \▓▓ \▓▓▓▓▓▓  \▓▓▓▓▓▓
        ]]

    opts.section.header.val = vim.split(logo, "\n", { trimempty = true })
  end,
}
