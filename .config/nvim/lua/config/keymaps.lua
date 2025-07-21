-- General keymaps
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { desc = 'Open diagnostic float' })
vim.keymap.set('n', 't', '<cmd>tabnew<CR>', { desc = 'New tab' })
vim.keymap.set("n", "<leader>j", "<C-o>", { desc = "[j]ump back" })

-- Copy/paste with system clipboard
vim.keymap.set("v", "<space>y", '"+y', { noremap = true, silent = true, desc = "which_key_ignore" })
vim.keymap.set("n", "<space>Y", '"+yg_', { noremap = true, silent = true, desc = "which_key_ignore" })
vim.keymap.set("n", "<space>y", '"+y', { noremap = true, silent = true, desc = "which_key_ignore" })
vim.keymap.set("n", "<space>p", '"+p', { noremap = true, silent = true, desc = "which_key_ignore" })
vim.keymap.set("n", "<space>P", '"+P', { noremap = true, silent = true, desc = "which_key_ignore" })
vim.keymap.set("v", "<space>p", '"+p', { noremap = true, silent = true, desc = "which_key_ignore" })
vim.keymap.set("v", "<space>P", '"+P', { noremap = true, silent = true, desc = "which_key_ignore" })

-- Terminal keymaps
vim.keymap.set("t", "<C-n>", [[<C-\><C-n>]], { noremap = true, desc = "Terminal: Ctrl+n to Normal mode" })

-- LSP Mappings
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = 'Go to declaration' })
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Hover' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = 'Go to implementation' })
vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, { desc = 'Signature help' })
vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, { desc = 'Type definition' })
vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, { desc = 'Rename' })
vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, { desc = 'Code action' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
vim.keymap.set('n', '<space>fr', function() vim.lsp.buf.format({ async = true }) end, { desc = 'Format' })

-- nvim-dap bindings
vim.keymap.set('n', '<F5>', function() require('dap').continue() end, { desc = 'Continue' })
vim.keymap.set('n', '<F6>', function() require('dap').disconnect() end, { desc = 'Disconnect' })
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end, { desc = 'Step over' })
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end, { desc = 'Step into' })
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end, { desc = 'Step out' })
vim.keymap.set('n', '<F9>', function() require('dap').toggle_breakpoint() end, { desc = 'Toggle breakpoint' })

-- Telescope keymaps (moved from init.lua)
-- We'll check if Telescope is loaded to avoid errors
local function telescope_exists()
  local ok, _ = pcall(require, 'telescope.builtin')
  return ok
end

if telescope_exists() then
  local builtin = require('telescope.builtin')
  vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
  vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
end

