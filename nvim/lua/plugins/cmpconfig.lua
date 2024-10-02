return {
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local luasnip = require("luasnip")
      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = false })
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),

        ["<CR>"] = {},
      })

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = vim.tbl_extend(
          "force",
          cmp.mapping.preset.cmdline(),
          { ["<Tab>"] = cmp.mapping.confirm({ select = false }) }
        ),
        sources = {
          { name = "buffer" },
        },
      })

      cmp.setup.cmdline(":", {
        mapping = vim.tbl_extend(
          "force",
          cmp.mapping.preset.cmdline(),
          { ["<Tab>"] = cmp.mapping.confirm({ select = false }) }
        ),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
}
