local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Neovim Configuration
vim.opt.shiftwidth = 4
vim.opt.number = true
vim.opt.termguicolors = true

-- Neovide Configuration
vim.g.neovide_cursor_smooth_blink = false
vim.g.neovide_cursor_vfx_mode = "torpedo"
vim.g.neovide_cursor_vfx_particle_density = 20.0

vim.g.neovide_fullscreen = true
vim.g.neovide_remember_window_size = true
vim.g.suda_smart_edit = 1

require("lazy").setup({
    {
	"voldikss/vim-floaterm",
	lazy = false,
	keys = {
	    { "<F10>", "<cmd>FloatermPrev<CR>" },
	    { "<F11>", "<cmd>FloatermNext<CR>" },
	    { "<F12>", "<cmd>FloatermToggle<CR>" }
	}
    },

    "jose-elias-alvarez/null-ls.nvim",
    "MunifTanjim/prettier.nvim",

    "stevearc/dressing.nvim",
    "rcarriga/nvim-notify",

    {
      "kdheepak/lazygit.nvim",
      cmd = {
	"LazyGit",
	"LazyGitConfig",
	"LazyGitCurrentFile",
	"LazyGitFilter",
	"LazyGitFilterCurrentFile",
      },
      -- optional for floating window border decoration
      dependencies = {
	"nvim-lua/plenary.nvim",
      },
      -- setting the keybinding for LazyGit with 'keys' is recommended in
      -- order to load the plugin when the command is run for the first time
      keys = {
	{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
      }
    },

    "nvim-treesitter/nvim-treesitter",

    { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },

    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      lazy = false,
      dependencies = {
	"nvim-tree/nvim-web-devicons",
      },
      config = function()
	require("nvim-tree").setup {
	    filters = {
		dotfiles = false,
		git_clean = false,
		no_buffer = false,
		custom = { "__pycache__" },
	    },
	}
      end,
    },

    { "williamboman/mason.nvim" },
    "neovim/nvim-lspconfig",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",

    "dcampos/nvim-snippy",
    "dcampos/cmp-snippy",

    { "neoclide/coc.nvim", branch = "release" },

    {'akinsho/toggleterm.nvim', version = "*", config = true},
    {
	"kylechui/nvim-surround",
	version = "*", -- Use for stability; omit to use `main` branch for the latest features
	event = "VeryLazy",
	config = function()
	    require("nvim-surround").setup({
		-- Configuration here, or leave empty to use defaults
	    })
	end
    },

    -- init.lua:
    {
	'nvim-telescope/telescope.nvim',
	tag = '0.1.6',
 	dependencies = { 'nvim-lua/plenary.nvim' }
    },

    {
	'nvim-lualine/lualine.nvim',
	dependencies = { 'nvim-tree/nvim-web-devicons' }
    },

    {
	"mrcjkb/rustaceanvim",
	version = "^4",
	lazy = false,
    },

    "mfussenegger/nvim-dap",

    {
      'stevearc/overseer.nvim',
      opts = {},
    },

    {
	"sontungexpt/witch",
	priority = 1000,
	lazy = false,
	config = function(_, opts)
	    require("witch").setup(opts)
	end,
    },

    {
      "kndndrj/nvim-dbee",
      dependencies = {
	"MunifTanjim/nui.nvim",
      },
      build = function()
	-- Install tries to automatically detect the install method.
	-- if it fails, try calling it with one of these parameters:
	--    "curl", "wget", "bitsadmin", "go"
	require("dbee").install()
      end,
      config = function()
	require("dbee").setup(--[[optional config]])
      end,
    },

--    { "andweeb/presence.nvim" },
    {
	"IogaMaster/neocord",
	lazy = false
    },

    {
	"lambdalisue/vim-suda"
    },

    {
      "folke/trouble.nvim",
      opts = {}, -- for default options, refer to the configuration section for custom setup.
      cmd = "Trouble",
      keys = {
	{
	  "<leader>xx",
	  "<cmd>Trouble diagnostics toggle<cr>",
	  desc = "Diagnostics (Trouble)",
	},
	{
	  "<leader>xX",
	  "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	  desc = "Buffer Diagnostics (Trouble)",
	},
	{
	  "<leader>cs",
	  "<cmd>Trouble symbols toggle focus=false<cr>",
	  desc = "Symbols (Trouble)",
	},
	{
	  "<leader>cl",
	  "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	  desc = "LSP Definitions / references / ... (Trouble)",
	},
	{
	  "<leader>xL",
	  "<cmd>Trouble loclist toggle<cr>",
	  desc = "Location List (Trouble)",
	},
	{
	  "<leader>xQ",
	  "<cmd>Trouble qflist toggle<cr>",
	  desc = "Quickfix List (Trouble)",
	},
      },
    },

    {
	"saecki/crates.nvim",
	tag = "stable",
	config = function()
	    require("crates").setup()
	end,
    },

    {
	"lewis6991/hover.nvim",
	config = function()
	    require("hover").setup {
		init = function()
		    require("hover.providers.lsp")
		    require("hover.providers.diagnostic")
		    require("hover.providers.gh")
		    require("hover.providers.dictionary")
		end,
		preview_opts = {
		    border = "single",
		},
		preview_window = false,
		title = true,
	    }
	end,
    },

    -- "python-rope/ropevim",

    {
      "linux-cultist/venv-selector.nvim",
	dependencies = {
	  "neovim/nvim-lspconfig", 
	  "mfussenegger/nvim-dap", "mfussenegger/nvim-dap-python", --optional
	  { "nvim-telescope/telescope.nvim", branch = "0.1.x", dependencies = { "nvim-lua/plenary.nvim" } },
	},
      lazy = false,
      branch = "regexp", -- This is the regexp branch, use this for the new version
      config = function()
	  require("venv-selector").setup()
	end,
	keys = {
	  { ",v", "<cmd>VenvSelect<cr>" },
	},
    },

    {
	'numToStr/Comment.nvim',
	opts = {
	}
    },

    "dense-analysis/ale",

    -- "davidhalter/jedi-vim"
})


-- Setup
require("Comment").setup()
require("nvim-tree").setup()
require("mason").setup()
require("toggleterm").setup{}
require('overseer').setup()
-- require("presence").setup({
--     auto_update = true,
-- 
--     buttons = true,
--     show_time = true,
--     enable_line_number = true,
-- 
--     editing_text = "%s 수정 중",
--     file_explorer_text = "%s 탐색 중",
--     git_commit_text = "변경 사항 커밋 중",
--     plugin_manager_text = "플러그인 변경 중",
--     reading_text = "%s 읽는 중",
--     workspace_text = "%s에서 작업 중",
--     line_number_text = function(line_number, line_count)
-- 	return line_number .. "/" .. line_count .. " 줄"
--     end
-- })

require("lualine").setup {
    options = {
	theme = "auto",
    }
}

require("neocord").setup({
     editing_text = "%s 수정 중",
     file_explorer_text = "%s 탐색 중",
     git_commit_text = "변경 사항 커밋 중",
     plugin_manager_text = "플러그인 변경 중",
     reading_text = "%s 읽는 중",
     workspace_text = "%s에서 작업 중",
     line_number_text = function(line_number, line_count)
 	return line_number .. "/" .. line_count .. " 줄"
     end 
})

-- require("rustaceanvim").setup()

local cmp = require("cmp")

--[[ cmp.setup({
    snippet = {
	expand = function(args)
	    require("snippy").expand_snippet(args.body)
	end,
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
	{ name = "nvim_lsp" },
	{ name = "snippy" },
    }, {
	{ name = "buffer" },
    })
}) ]]

-- local hover = require("hover")
local telescope_builtin = require("telescope.builtin")

-- Configure null-ls
local null_ls = require("null-ls")

local group = vim.api.nvim_create_augroup("lsp_format_on_save", { clear = false })
local event = "BufWritePre" -- or "BufWritePost"
local async = event == "BufWritePost"

null_ls.setup({
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.keymap.set("n", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })

      -- format on save
      vim.api.nvim_clear_autocmds({ buffer = bufnr, group = group })
      vim.api.nvim_create_autocmd(event, {
        buffer = bufnr,
        group = group,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr, async = async })
        end,
        desc = "[lsp] format on save",
      })
    end

    if client.supports_method("textDocument/rangeFormatting") then
      vim.keymap.set("x", "<Leader>f", function()
        vim.lsp.buf.format({ bufnr = vim.api.nvim_get_current_buf() })
      end, { buffer = bufnr, desc = "[lsp] format" })
    end
  end,
})

-- Setup prettier
local prettier = require("prettier")

prettier.setup({
  bin = 'prettier', -- or `'prettierd'` (v0.23.3+)
  filetypes = {
    "css",
    "graphql",
    "html",
    "javascript",
    "javascriptreact",
    "json",
    "less",
    "markdown",
    "scss",
    "typescript",
    "typescriptreact",
    "yaml",
  },
})

-- Configure telescope keymap
vim.keymap.set("n", "<a-f>", telescope_builtin.find_files, {})

-- Configure RustLsp & hover keymap
vim.keymap.set("n", "<a-cr>", function()
--    if vim.cmd.RustLsp ~= nil then
--	vim.cmd.RustLsp { 'hover', 'actions' }
--    else
--	hover.hover()
--    end

    
    vim.lsp.buf.code_action()
    -- hover.hover()
end, {})

-- Configure hover keymap
vim.keymap.set("n", "<C-p>", function()
    hover.hover_switch("previous")
end, {})
vim.keymap.set("n", "<C-n>", function()
    hover.hover_switch("next")
end, {})

-- Configure coc.nvim keymap
vim.keymap.set("i", "<CR>", function() -- Complete
	if vim.fn['coc#pum#visible']() == 1 then
            return vim.fn['coc#pum#confirm']();
	end
	return "<CR>"
end, { expr = true })

vim.keymap.set("n", "<A-CR>", function() -- Documentation
    local cw = vim.fn.expand('<cword>')
    if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
        vim.api.nvim_command('h ' .. cw)
    elseif vim.api.nvim_eval('coc#rpc#ready()') then
        vim.fn.CocActionAsync('doHover')
    else
        vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
    end
end, { expr = true })

vim.keymap.set("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", { silent = true, nowait = true })
vim.keymap.set("n", "<C-]>", "<Plug>(coc-definition)", { silent = true, nowait = true })

-- Configure Fullscreen custom command
vim.api.nvim_create_user_command("Fullscreen", function()
    os.execute('wmctrl -r ":ACTIVE:" -b toggle,fullscreen')
end, {})

vim.api.nvim_create_user_command("F", function()
    vim.cmd("Fullscreen")
end, {})

-- Configure format command
vim.api.nvim_create_user_command("Format", function()
    vim.lsp.buf.format()
end, {})

-- Configure indents
vim.api.nvim_create_autocmd("FileType", {
    pattern = "typescript,javascript",
    callback = function()
	vim.opt_local.shiftwidth = 2
    end
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- require('lspconfig').tsserver.setup {
--    capabilities = capabilities
-- }

-- require("lspconfig").pyright.setup({
--     capabilities = capabilities,
--     filetypes = { "python" },
-- })

-- require('lspconfig').pylsp.setup{
--     capabilities = capabilities
-- }

-- require('lspconfig').jedi_language_server.setup{}


-- vim.g.ale_linters = {
--     python = ["pylsp"]
-- }

-- Configure font
vim.o.guifont = "Jetbrains Mono,MesloLGS NF"
