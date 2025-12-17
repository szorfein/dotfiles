--- To configure typescript language server, add a
--- [`tsconfig.json`](https://www.typescriptlang.org/docs/handbook/tsconfig-json.html) or
--- [`jsconfig.json`](https://code.visualstudio.com/docs/languages/jsconfig) to the root of your
--- project.
return function(on_attach)
    return {
        on_attach = function(client, bufnr)
            on_attach(client, bufnr)
            client.server_capabilities.document_formatting = true
        end,
        cmd = { 'typescript-language-server', '--stdio' },
        filetypes = {
            'javascript',
            'javascriptreact',
            'javascript.jsx',
            'typescript',
            'typescriptreact',
            'typescript.tsx',
        },
        init_options = { hostInfo = 'neovim' },
        -- root_dir = util.root_pattern("package.json", "package-lock.json", "tsconfig.json", "jsconfig.json", ".git"),
        root_dir = function(bufnr, on_dir)
            -- The project root is where the LSP can be started from
            -- As stated in the documentation above, this LSP supports monorepos and simple projects.
            -- We select then from the project root, which is identified by the presence of a package
            -- manager lock file.
            local root_markers = { 'package-lock.json', 'yarn.lock', 'pnpm-lock.yaml', 'bun.lockb', 'bun.lock' }
            -- Give the root markers equal priority by wrapping them in a table
            root_markers = vim.fn.has('nvim-0.11.3') == 1 and { root_markers, { '.git' } }
                or vim.list_extend(root_markers, { '.git' })
            -- exclude deno
            local deno_path = vim.fs.root(bufnr, { 'deno.json', 'deno.jsonc', 'deno.lock' })
            local project_root = vim.fs.root(bufnr, root_markers)
            if deno_path and (not project_root or #deno_path >= #project_root) then
                return
            end
            -- We fallback to the current working directory if no project root is found
            on_dir(project_root or vim.fn.getcwd())
        end,
        handlers = {
            -- handle rename request for certain code actions like extracting functions / types
            ['_typescript.rename'] = function(_, result, ctx)
                local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
                vim.lsp.util.show_document({
                    uri = result.textDocument.uri,
                    range = {
                        start = result.position,
                        ['end'] = result.position,
                    },
                }, client.offset_encoding)
                vim.lsp.buf.rename()
                return vim.NIL
            end,
        },
    }
end
