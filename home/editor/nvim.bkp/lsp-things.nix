{ config, lib, pkgs, ... }: 

## TODO: This is GARBAGE
## Do it, omg!!


## TODO: Missing Lean4!!!
let
  lean-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "lean.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "Julian";
      repo = "lean.nvim";
      rev = "08edf859efe21d6f7c6f157cf4d91cf312076cf2";
      sha256 = "sha256-yA6aWJng9vV4Vp980brkJzMU3Y3O1R197keAVeCRW9A=";
    };
  };

in {
  programs.neovim = {

    plugins = with pkgs.vimPlugins; [

      plenary-nvim
      nvim-cmp
      cmp-nvim-lsp
      toggleterm-nvim 
      haskell-tools-nvim
      nvim-treesitter.withAllGrammars

      # Mason
      {
        plugin = mason-nvim;
        config = ''
          lua << EOF
          require("mason").setup({
            ui = {
              icons = {
                package_installed = "✓",
                package_pending = "➜",
                package_uninstalled = "✗"
              }
            }
          })
          EOF
        '';
      }
  
      {
        plugin = nvim-lspconfig;
        config = ''
          lua << EOF
          require("lspconfig").lua_ls.setup({})
          EOF
        '';
      }
  
      {
        plugin = mason-nvim;
        config = ''
          lua << EOF
          require("mason").setup()
          EOF
        '';
      }
  
      {
        plugin = mason-lspconfig-nvim;
        config = ''
          lua << EOF
          vim.diagnostic.config({
            virtual_text = {
              source = "always",
              prefix = "■",
            },
            update_in_insert = true,
            severity_sort = true,
            float = {
              focusable = false,
              style = "minimal",
              border = "rounded",
              source = "always",
              header = "",
              prefix = "",
            },
          })
      
          local lspconfig = require('lspconfig')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()
      
          local on_attach = function(client, bufnr)
            local opts = { buffer = bufnr, remap = false }
      
            vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
            vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
            vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
            vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
            vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
            vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
            vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
            
            -- Mapeamento para mostrar tipo sob o cursor
            vim.keymap.set('n', '<leader>st', function()
              vim.lsp.buf.hover()
            end, opts)
      
            vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
              buffer = bufnr,
              callback = function()
                vim.diagnostic.open_float(nil, {
                  focusable = false,
                  close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
                  border = "rounded",
                  source = "always",
                  prefix = " ",
                })
              end
            })
          end
      
          local server_mapping = {
            ["haskell-language-server"] = "hls",
            ["typescript-language-server"] = "tsserver",
            ["rnix"] = "nil_ls",
            ["rust-analyzer"] = "rust_analyzer"
          }
      
          require("mason-lspconfig").setup({
            ensure_installed = {
              "lua_ls",
              "pyright",
              "bashls",
              "marksman",
              "cssls",
              "html",
              "jsonls",
              "yamlls",
            },
            automatic_installation = true,
          })
      
          require("mason-lspconfig").setup_handlers({
            function(server_name)
              local mapped_name = server_mapping[server_name] or server_name
              if lspconfig[mapped_name] then
                lspconfig[mapped_name].setup({
                  on_attach = on_attach,
                  capabilities = capabilities,
                })
              else
                vim.notify("LSP não configurado: " .. server_name, vim.log.levels.WARN)
              end
            end,
      
            ["lua_ls"] = function()
              lspconfig.lua_ls.setup({
                settings = {
                  Lua = {
                    diagnostics = { globals = { 'vim' } },
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                  }
                },
                on_attach = on_attach,
                capabilities = capabilities,
              })
            end,
      
            ["rnix"] = function()
              lspconfig.nil_ls.setup({
                on_attach = on_attach,
                capabilities = capabilities,
              })
            end,
          })
          EOF
        '';
      }
  
      cmp-nvim-lsp
      friendly-snippets	
  
      {
        plugin = friendly-snippets;
        config = ''
          lua << EOF
          require("luasnip.loaders.from_vscode").lazy_load()
          EOF
        '';
      }

      {
        plugin = luasnip;
        config = ''
          lua << EOF
          local luasnip = require('luasnip')
          luasnip.config.setup({
            history = true,
            updateevents = "TextChanged,TextChangedI",
          })
          EOF
        '';
      }

      {
        plugin = nvim-cmp;
        config = ''
          lua << EOF
          local cmp = require('cmp')
          
          cmp.setup({
            snippet = {
              expand = function(args)
                require('luasnip').lsp_expand(args.body)
              end,
            },
            mapping = cmp.mapping.preset.insert({
              ['<C-b>'] = cmp.mapping.scroll_docs(-4),
              ['<C-f>'] = cmp.mapping.scroll_docs(4),
              ['<C-Space>'] = cmp.mapping.complete(),
              ['<C-e>'] = cmp.mapping.abort(),
              ['<CR>'] = cmp.mapping.confirm({ select = true }),
            }),
            sources = cmp.config.sources({
              { name = 'nvim_lsp' },
              { name = 'luasnip' },
              { name = 'buffer' },
              { name = 'path' },
            })
          })
          EOF
        '';
      }

      cmp_luasnip
    ];

    extraLuaConfig = ''
      
      vim.opt.conceallevel = 2
      vim.api.nvim_set_hl(0, "@operator", { link = "Operator" })
      vim.cmd[[
        autocmd FileType haskell,hs,lua,nix setlocal concealcursor=nvic
        syntax match NiceOperator "->" conceal cchar=→
        syntax match NiceOperator "<-" conceal cchar=←
        syntax match NiceOperator "=>" conceal cchar=⇒
        syntax match NiceOperator "==" conceal cchar=≡
        syntax match NiceOperator "!=" conceal cchar=≠
        syntax match NiceOperator "<=" conceal cchar=≤
        syntax match NiceOperator ">=" conceal cchar=≥
        syntax match NiceOperator "++" conceal cchar=⧺
        syntax match NiceOperator ">>" conceal cchar=»
        syntax match NiceOperator "<<" conceal cchar=«
        hi! link Conceal Operator
      ]]
      
      -- Configuração para mostrar tipos
      vim.diagnostic.config({
        virtual_text = {
          severity = { min = vim.diagnostic.severity.INFO },
          prefix = "■",
          format = function(diagnostic)
            -- Mostrar tipos como virtual text
            if diagnostic.source == "HLS" and diagnostic.message:match("^•") then
              return diagnostic.message
            end
            return string.format("%s (%s)", diagnostic.message, diagnostic.source)
          end,
        },
        signs = true,
        underline = true,
        update_in_insert = true,
        severity_sort = true,
      })
      
      -- Mostrar assinaturas de tipo automaticamente
      vim.api.nvim_create_autocmd({"CursorHold", "CursorHoldI"}, {
        callback = function()
          if vim.fn.mode() ~= 'c' then
            vim.diagnostic.open_float(nil, {
              scope = "cursor",
              focusable = false,
              close_events = {"BufLeave", "CursorMoved", "InsertEnter", "FocusLost"},
              border = "rounded",
              source = "always",
              prefix = function(diagnostic)
                if diagnostic.severity == vim.diagnostic.severity.ERROR then
                  return " "
                elseif diagnostic.severity == vim.diagnostic.severity.WARN then
                  return " "
                elseif diagnostic.severity == vim.diagnostic.severity.INFO then
                  return " "
                else
                  return " "
                end
              end,
              format = function(diagnostic)
                -- Mostrar informações de tipo no hover
                if diagnostic.source == "HLS" and diagnostic.message:match("^•") then
                  return string.format("%s", diagnostic.message)
                end
                return string.format("[%s] %s", diagnostic.source, diagnostic.message)
              end
            })
          end
        end
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "VeryLazy",
        callback = function()
          local ht = package.loaded['haskell-tools'] or require('haskell-tools')
          local capabilities = require('cmp_nvim_lsp').default_capabilities()

          if not ht or not ht.setup then
            return vim.notify("haskell-tools.nvim não carregou!", vim.log.levels.ERROR)
          end

          ht.setup({
            tools = {
              codeLens = {
                autoRefresh = true,
                refreshOnWrite = true,
              },

              hover = {
                enable = true,
                border = "rounded",
                sticky = true,
                debounce = 200,
                auto = true, -- Hover automático
              },

              repl = {
                handler = "toggleterm",
                autoFocus = true,
                quitOnExit = true,
                preferred = "ghci",
                builtin = {
                  create_repl_window = function(view)
                    return require('toggleterm').Terminal:new({
                      direction = "float",
                      on_open = view.on_open,
                      on_exit = view.on_exit,
                    })
                  end,
                },
              },

              tags = {
                enable = true,
                packageEvents = { "BufWritePost" },
              },

              definition = {},
            },

            hls = {
              on_attach = function(client, bufnr)
                local opts = { buffer = bufnr, remap = false }

                vim.keymap.set('n', '<leader>rr', ht.repl.toggle_repl, opts)
                vim.keymap.set('x', '<leader>re', ht.repl.send_to_repl, opts)
                vim.keymap.set('n', '<leader>td', ht.tags.generate_tags, opts)
                vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, opts)
                
                -- Mostrar tipo sob o cursor
                vim.keymap.set('n', '<leader>tt', function()
                  vim.lsp.buf.hover()
                end, opts)
                
                -- Mostrar assinatura de tipo
                vim.keymap.set('n', '<leader>ts', function()
                  vim.lsp.buf.signature_help()
                end, opts)
              end,

              capabilities = capabilities,

              settings = {
                haskell = {
                  formattingProvider = "ormolu",
                  plugin = {
                    tactic = { globalOn = true },
                    alternateNumberFormat = { globalOn = true },
                    class = { globalOn = true },
                    callHierarchy = { globalOn = true },
                    pragmas = { globalOn = true },
                    refineImports = { globalOn = true },
                    rename = { globalOn = true },
                    splice = { globalOn = true },
                    hlint = { globalOn = true },
                    typeLenses = {  -- Ativar lentes de tipo
                      globalOn = true,
                      mode = "always",
                    },
                  }
                }
              }
            }
          })

          -- Configurar exibição de tipos
          vim.cmd[[
            autocmd FileType haskell setlocal commentstring=--\ %s
            hi! link LspCodeLens Comment
            
            " Destaque para tipos
            hi! link HaskellType Type
            hi! link HaskellTypeDef TypeDef
            hi! link HaskellTypeParams Special
          ]]
        end
      })
      
      -- Ativar lentes de tipo automaticamente
      vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, {
        pattern = "*.hs",
        callback = function()
          vim.schedule(function()
            if vim.b.lsp_attached then
              vim.lsp.codelens.refresh()
            end
          end)
        end
      })
    '';
  };

  home.packages = with pkgs; [
    haskell-language-server
    haskellPackages.ormolu
    haskellPackages.ghc
    haskellPackages.hlint
    haskellPackages.retrie
    haskellPackages.cabal-install

    lua-language-server
    rust-analyzer
    nodePackages.typescript-language-server
    gopls
    clang-tools
    nodePackages.bash-language-server
    nodePackages.vscode-langservers-extracted
    gleam
  ];

  home.sessionPath = [
    "$HOME/.cabal/bin"
    "$HOME/.ghcup/bin"
  ];

  xresources.properties = {
    "*.font" = "FiraCode Nerd Font Mono, Symbols Nerd Font:size=11";
  };
}
