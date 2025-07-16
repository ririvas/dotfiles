return {
  -- Core debugging
  {
    'mfussenegger/nvim-dap',
    lazy = true,
    dependencies = {
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
      'mfussenegger/nvim-dap-python',
    },
    config = function()
      local dap = require('dap')
      
      -- .NET debugging adapter
      dap.adapters.coreclr = {
        type = 'executable',
        command = '/usr/local/bin/netcoredbg/netcoredbg',
        args = {'--interpreter=vscode'}
      }
      
      -- Define dotnet helpers
      vim.g.dotnet_build_project = function()
        local default_path = vim.fn.getcwd() .. '/'
        if vim.g['dotnet_last_proj_path'] ~= nil then
          default_path = vim.g['dotnet_last_proj_path']
        end
        local path = vim.fn.input('Path to your *proj file', default_path, 'file')
        vim.g['dotnet_last_proj_path'] = path
        local cmd = 'dotnet build -c Debug ' .. path .. ' > /dev/null'
        print('')
        print('Cmd to execute: ' .. cmd)
        local f = os.execute(cmd)
        if f == 0 then
          print('\nBuild: ✔️ ')
        else
          print('\nBuild: ❌ (code: ' .. f .. ')')
        end
      end
      
      vim.g.dotnet_get_dll_path = function()
        local request = function()
          return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end
      
        if vim.g['dotnet_last_dll_path'] == nil then
          vim.g['dotnet_last_dll_path'] = request()
        else
          if vim.fn.confirm('Do you want to change the path to dll?\n' .. vim.g['dotnet_last_dll_path'], '&yes\n&no', 2) == 1 then
            vim.g['dotnet_last_dll_path'] = request()
          end
        end
      
        return vim.g['dotnet_last_dll_path']
      end
      
      -- .NET configuration
      local config = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            if vim.fn.confirm('Should I recompile first?', '&yes\n&no', 2) == 1 then
              vim.g.dotnet_build_project()
            end
            return vim.g.dotnet_get_dll_path()
          end,
        },
      }
      
      dap.configurations.cs = config
      dap.configurations.fsharp = config
    end
  },
  
  -- DAP UI - visual debugger interface
  {
    'rcarriga/nvim-dap-ui',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    config = function()
      local dap = require('dap')
      local dapui = require('dapui')
      
      dapui.setup()
      
      -- Auto open/close UI
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  },
  
  -- Python debugging support
  {
    'mfussenegger/nvim-dap-python',
    dependencies = {
      'mfussenegger/nvim-dap',
    },
    ft = 'python',
    config = function()
      require('dap-python').setup('python3')
    end
  },
  
  -- NVim-NIO dependency
  'nvim-neotest/nvim-nio',
}
