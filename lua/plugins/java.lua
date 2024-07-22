local home = os.getenv("HOME")

local fn = vim.fn
local fs = vim.fs

-- jdtls
local jdtls = "/opt/homebrew/Cellar/jdtls/1.35.0"
local share = "/.local/share/eclipse"

-- TODO: replace with correct main java version
local main_java = "/.asdf/installs/java/corretto-17.0.12.7.1/bin/java"

local runtimes = {
  {
    name = "JavaSE-17",
    path = home .. main_java,
  },
  {
    name = "JavaSE-21",
    path = home .. "/.asdf/installs/java/corretto-17.0.12.7.1/bin/java",
  },
}

local root_markers = { "gradlew", "mvnw", ".git" }
local root_dir = fs.dirname(fs.find(root_markers, { upward = true })[1])
local workspace_folder = home .. share .. fn.fnamemodify(root_dir, ":p:h:t")
return {
  "nvim-java/nvim-java",
  config = false,
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        servers = {
          jdtls = {
            cmd = {
              home .. main_java,
              "-Declipse.application=org.eclipse.jdt.ls.core.id1",
              "-Dosgi.bundles.defaultStartLevel=4",
              "-Declipse.product=org.eclipse.jdt.ls.core.product",
              "-Dlog.protocol=true",
              "-Dlog.level=ALL",
              "-Xmx4g",
              "--add-modules=ALL-SYSTEM",
              "--add-opens",
              "java.base/java.util=ALL-UNNAMED",
              "--add-opens",
              "java.base/java.lang=ALL-UNNAMED",
              -- If you use lombok, download the lombok jar and place it in ~/.local/share/eclipse
              "-javaagent:"
                .. home
                .. "/.local/share/eclipse/lombok.jar",

              -- The jar file is located where jdtls was installed. This will need to be updated
              -- to the location where you installed jdtls
              "-jar",
              fn.glob(jdtls .. "/libexec/plugins/org.eclipse.equinox.launcher_*.jar"),

              -- The configuration for jdtls is also placed where jdtls was installed. This will
              -- need to be updated depending on your environment
              "-configuration",
              jdtls .. "/libexec/config_mac",

              -- Use the workspace_folder defined above to store data for this project
              "-data",
              workspace_folder,
            },
            -- Your custom jdtls settings goes here
            settings = {
              java = {
                format = {
                  settings = {
                    profile = "GoogleStyle",
                    url = home .. "/.config/nvim/formatting/eclipse-java-google-style.xml",
                  },
                  signatureHelp = { enabled = true },
                  contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
                  -- Specify any completion options
                  completion = {
                    favoriteStaticMembers = {
                      "org.hamcrest.MatcherAssert.assertThat",
                      "org.hamcrest.Matchers.*",
                      "org.hamcrest.CoreMatchers.*",
                      "org.junit.jupiter.api.Assertions.*",
                      "java.util.Objects.requireNonNull",
                      "java.util.Objects.requireNonNullElse",
                      "org.mockito.Mockito.*",
                    },
                    filteredTypes = {
                      "com.sun.*",
                      "io.micrometer.shaded.*",
                      "java.awt.*",
                      "jdk.*",
                      "sun.*",
                    },
                  },
                  configuration = {
                    runtimes = runtimes,
                  },
                  -- Specify any options for organizing imports
                  sources = {
                    organizeImports = {
                      starThreshold = 9999,
                      staticStarThreshold = 9999,
                    },
                  },
                  -- How code generation should act
                  codeGeneration = {
                    toString = {
                      template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
                    },
                    hashCodeEquals = {
                      useJava7Objects = true,
                    },
                    useBlocks = true,
                  },
                },
              },
            },
          },
        },
        setup = {
          jdtls = function()
            require("java").setup({
              -- Your custom nvim-java configuration goes here
            })
          end,
        },
      },
    },
  },
}
