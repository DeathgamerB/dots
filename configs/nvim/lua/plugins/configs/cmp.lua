local present, cmp = pcall(require, 'cmp')

if not present then
  return
end

vim.opt.completeopt = 'menuone,noselect'

local kind_icons = {
    Array = "  ",
    Boolean = "  ",
    Class = "  ",
    Color = "  ",
    Constant = "  ",
    Constructor = "  ",
    Enum = "  ",
    EnumMember = "  ",
    Event = "  ",
    Field = "  ",
    File = "  ",
    Folder = " 󰉋 ",
    Function = "  ",
    Interface = "  ",
    Key = "  ",
    Keyword = "  ",
    Method = "  ",
    Module = "  ",
    Namespace = "  ",
    Null = " 󰟢 ",
    Number = "  ",
    Object = "  ",
    Operator = "  ",
    Package = "  ",
    Property = "  ",
    Reference = "  ",
    Snippet = "  ",
    String = "  ",
    Struct = "  ",
    Text = "  ",
    TypeParameter = "  ",
    Unit = "  ",
    Value = "  ",
    Variable = "  ",}

cmp.setup({
  snippet = {
    expand = function(args)
      local present, luasnip = pcall(require, "luasnip")
      if present then
        luasnip.lsp_expand(args.body)
      end
    end,
  },
  window = {
    completion = { border = "solid" },
    documentation = { border = "solid" }
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<Esc>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end, { "i", "s" }),

  }),
  formatting = {
    fields = {'abbr', 'menu', 'kind'},
    format = function(entry, vim_item)
      vim_item.kind = kind_icons[vim_item.kind]
      vim_item.menu = ({
        buffer = "[Buf]",
        path = "[Path]",
        nvim_lsp = "[Lsp]",
        luasnip = "[Snip]",
        cmdline = "[Cmd]",
        nvim_lua = "[Lua]",
      })[entry.source.name]
      return vim_item
    end,
   },
  sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "copilot" },
		{ name = "luasnip_choice" },
		{ name = "snippy" },
		{ name = "nvim_lua" },
		{ name = "vsnip" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "path" },
  }),
})

cmp.setup.cmdline('/', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' }
  }
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources({
    { name = 'path' }
  }, {
    { name = 'cmdline' }
  })
})
