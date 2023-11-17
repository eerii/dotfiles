# neovim 🌿

## keymaps

### basic

- `<leader>n`: new file
- `<leader>z`: zen mode
- `<leader>w`: toggle wrap
- `<leader>l`: lazy plugins
- `<leader>m`: mason
- `<leader>lsp`: lsp info
- `<leader>p/x`: paste/delete without losing buffer
- `<C-c>/<leader>y/<C-v>`: paste/copy to system clipboard
- `U`: redo

### quick edits

- `K/J`: move line up/down
- `gc`: comment
- `<leader>tt`: trim trailspace

### navigation

- `<C-f>`: file tree
- `<C-a>`: sessions
- `<C-m>`: add mark
- `<C-n>`: see marked files
- `<C-,/.>`: next/previous marked file
- `<C-1/9>`: go to n marked file

### lsp

- `gh`: hover
- `ga`: code actions
- `gs`: declaration
- `gf`: definition
- `gt`: type definition
- `gj`: implementation
- `gr`: references
- `gi`: incoming calls
- `go`: outgoing calls
- `<leader>r`: rename
- `<leader>f`: format
- `<Tab>`: accept completion
- `<C-e>`: get completion
- `<C-j>`: next completion
- `<C-k>`: previous completion
- `<C-w>`: suggestion
- `<leader>tc`: toggle autocomplete

### search

- `<C-s>`: files
- `<C-g>`: grep
- `<C-z>`: directories (zoxide)
- `<leader>sH`: hidden files
- `<leader>ss`: string in cursor
- `<leader>sn`: notifications
- `<leader>sm`: mappings
- `<leader>sh`: help man pages
- `<leader>sp`: yank clipboard
- `<leader>sy`: symbols

### diagnostics

- `gd`: show diagnostic
- `<leader>sd`: document diagnostics
- `<leader>sD`: workspace diagnostics
- `<leader>st`: todo list

### quickfix

- `<leader>sq`: quickfix list

### git

- `<leader>gs`: stage hunk
- `<leader>gr`: reset hunk
- `<leader>gS`: stage buffer
- `<leader>gR`: reset buffer
- `<leader>gu`: undo stage
- `<leader>gp`: preview
- `<leader>gd`: side by side diff 
- `<leader>gt`: toggle deleted

### debug

- `<C-t>`: terminal
- `<leader>mk`: make and run (uses bear and assumes bin/main and makefile)

## file support

- plantuml diagrams
- pandoc (markdown, latex), use `<leader>pd`
- markdown images, use `<leader>mi`
- lisp parinfer
