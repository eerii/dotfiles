return function(client, bufnr)
    local function opts(desc)
        return { buffer = bufnr, desc = desc }
    end

    local map = vim.keymap.set
    local conf = require("nvconfig").ui.lsp

    map("n", "gh", vim.lsp.buf.hover, opts "LSP Hover info")
    map("n", "gH", vim.lsp.buf.signature_help, opts "LSP Show signature help")

    map("n", "gd", function()
        require("trouble").toggle "lsp_definitions"
    end, opts "LSP Go to definition")
    map("n", "gt", function()
        require("trouble").toggle "lsp_type_definitions"
    end, opts "LSP Go to type definition")
    map("n", "gD", vim.lsp.buf.declaration, opts "LSP Go to declaration")
    map("n", "gI", vim.lsp.buf.implementation, opts "LSP Go to implementation")

    map("n", "gi", require("telescope.builtin").lsp_incoming_calls, opts "LSP Incoming calls")
    map("n", "go", require("telescope.builtin").lsp_outgoing_calls, opts "LSP Outgoing calls")

    map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts "LSP Add workspace folder")
    map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts "LSP Remove workspace folder")
    map("n", "<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts "LSP List workspace folders")

    map("n", "<leader>r", function()
        require "nvchad.lsp.renamer"()
    end, opts "LSP Rename")

    -- setup signature popup
    if conf.signature and client.server_capabilities.signatureHelpProvider then
        require("nvchad.lsp.signature").setup(client, bufnr)
    end

    -- nvchad may overwrite this setting
    vim.diagnostic.config {
        underline = {
            severity = { max = vim.diagnostic.severity.INFO },
        },
        virtual_text = {
            severity = { min = vim.diagnostic.severity.WARN },
        },
    }
end
