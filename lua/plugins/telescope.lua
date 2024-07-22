return {
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fb",
        function() require("telescope.builtin").buffers() end,
        desc = "Find Plugin File",
      },
      { "<c-x>", "<cmd>Telescope luasnip<cr>", desc = "Snippets", mode = { "i", "n", "x" } },
    },
    {
      "benfowler/telescope-luasnip.nvim",
      module = "telescope._extensions.luasnip",
      lazy = true,
    },
  },
}
