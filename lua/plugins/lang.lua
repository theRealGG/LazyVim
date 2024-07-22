return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "cmake",
        "css",
        "java",
        "rust",
        "typescript",
        "javascript",
        "scss",
        "json",
        "sql",
        "gitignore",
        "graphql",
        "http",
      },
    },
  },
  {
    "williamboman/mason.nvim",
  },
}
