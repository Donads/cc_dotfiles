-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'


if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd([[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]])

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  use 'tpope/vim-repeat'
  -- use 'tpope/vim-vinegar'
  use 'preservim/nerdtree'
  use 'numToStr/Comment.nvim' -- "gc" to comment visual regions/lines
  use 'ludovicchabant/vim-gutentags' -- Automatic tags management
  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-lualine/lualine.nvim' -- Fancier statusline
  -- Add indentation guides even on blank lines
  use 'lukas-reineke/indent-blankline.nvim'
  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp'
  use 'saadparwaiz1/cmp_luasnip'
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'mjlbach/onedark.nvim' -- Theme inspired by Atom
  use 'gruvbox-community/gruvbox'
  use { 'dracula/vim', as = 'dracula' }
  use 'machakann/vim-sandwich' -- Replacement for VIM Surround
  use {
  "folke/which-key.nvim",
  config = function()
    require("which-key").setup {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  end
  }
  use 'tmux-plugins/vim-tmux'
  use 'christoomey/vim-tmux-navigator'
  use 'christoomey/vim-tmux-runner'
  use 'jiangmiao/auto-pairs'
  use 'easymotion/vim-easymotion'
  use 'kyazdani42/nvim-web-devicons'
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }
  use {'antoinemadec/FixCursorHold.nvim'}
  use {'unblevable/quick-scope'}
end)

--Set highlight on search
vim.o.hlsearch = true

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

--Set colorscheme
vim.o.termguicolors = true
vim.cmd [[colorscheme onedark]]

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- Custom settings from vimrc
vim.o.autowrite = true -- Automatically :write before running commands
vim.o.errorbells = false -- No noise
vim.o.backspace = "indent,eol,start" -- Backspace deletes like most programs in insert mode
vim.o.backup = false
vim.o.hidden = true
vim.o.incsearch = true -- Do incremental searching
vim.o.laststatus = 2 -- Always display the status line
vim.o.listchars = "tab:»·,trail:·,nbsp:·" -- Displays extra whitespaces
vim.o.ruler = true -- Shows the cursor position all the time
vim.o.showcmd = true -- Displays incomplete commands
vim.o.shiftround = true
vim.o.splitbelow = true -- Open new split panes to right and bottom,
vim.o.splitright = true -- which feels more natural
vim.o.visualbell = true -- No noise
vim.o.wildignore = "*/tmp/*,*.so,*.swp,*.zip,*.cache" -- Skip tmp files
vim.o.wildmode = "list:longest,list:full" -- Enable list of completion
vim.o.writebackup = false

vim.bo.expandtab = true
vim.bo.shiftwidth = 2
vim.bo.swapfile = false
vim.bo.tabstop = 2 -- Softtabs, 2 spaces

vim.wo.colorcolumn = "81,121"
vim.wo.list = true

vim.cmd [[set t_vb=         ]] -- No noise
-- End custom settings from vimrc

--Set statusbar
require('lualine').setup {
  options = {
    icons_enabled = false,
    theme = 'onedark',
    component_separators = '|',
    section_separators = '',
  },
}

--Enable Comment.nvim
require('Comment').setup()

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

--Add move line shortcuts
vim.api.nvim_set_keymap('n', '<A-j>', ':m .+1<CR>==', { noremap = true})
vim.api.nvim_set_keymap('n', '<A-k>', ':m .-2<CR>==', { noremap = true})
vim.api.nvim_set_keymap('i', '<A-j>', '<Esc>:m .+1<CR>==gi', { noremap = true})
vim.api.nvim_set_keymap('i', '<A-k>', '<Esc>:m .-2<CR>==gi', { noremap = true})
vim.api.nvim_set_keymap('v', '<A-j>', ':m \'>+1<CR>gv=gv', { noremap = true})
vim.api.nvim_set_keymap('v', '<A-k>', ':m \'<-2<CR>gv=gv', { noremap = true})

-- Toggle to disable mouse mode and indentlines for easier paste
ToggleMouse = function()
  if vim.o.mouse == 'a' then
    vim.cmd[[IndentBlanklineDisable]]
    vim.wo.signcolumn='no'
    vim.o.mouse = 'v'
    vim.wo.number = false
    print("Mouse disabled")
  else
    vim.cmd[[IndentBlanklineEnable]]
    vim.wo.signcolumn='yes'
    vim.o.mouse = 'a'
    vim.wo.number = true
    print("Mouse enabled")
  end
end

vim.api.nvim_set_keymap('n', '<F10>', '<cmd>lua ToggleMouse()<cr>', { noremap = true })

-- Save file with Ctrl+S
vim.api.nvim_set_keymap('n', '<C-s>', ':w<cr>', { noremap = true})

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
}

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native
require('telescope').load_extension 'fzf'

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>ss', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
-- vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sf', [[<cmd>lua require('telescope.builtin').find_files({previewer = false})<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>sp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- LSP settings
local lspconfig = require 'lspconfig'
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- nvim-cmp supports additional completion capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- Example custom server
-- Make runtime files discoverable to the server
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')

lspconfig.sumneko_lua.setup {
  cmd = { vim.env.HOME .. "/.local/share/nvim/lsp_servers/lua-language-server/bin/lua-language-server" },
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT',
        -- Setup your lua path
        path = runtime_path,
      },
      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = { 'vim' },
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}
-- vim: ts=2 sts=2 sw=2 et

-- LSP Servers
-- Solargraph (Ruby)
require('lspconfig').solargraph.setup{}
-- ```lua
--   Commands:
--   
--   Default Values:
--     cmd = { "solargraph", "stdio" }
--     filetypes = { "ruby" }
--     init_options = {
--       formatting = true
--     }
--     root_dir = root_pattern("Gemfile", ".git")
--     settings = {
--       solargraph = {
--         diagnostics = true
--       }
--     }
-- ```
-- End of LSP Servers

-- set background=dark " cause I'm not a psychopath
-- init.vim
vim.cmd([[
	" automatically rebalance windows on vim resize
	autocmd VimResized * :wincmd =

	if !exists('g:vscode')

	  " <Leader>f{char} to move to {char}
	  nmap <Leader>f <Plug>(easymotion-overwin-f)

	  " sz{char}{char} to move to {char}{char}
	  nmap sz <Plug>(easymotion-overwin-f2)

	  " Move to line
	  nmap <Leader>L <Plug>(easymotion-overwin-line)

	  " Move to word
	  nmap <Leader>w <Plug>(easymotion-overwin-w) 
	endif

	" <Leader>f{char} to move to {char}
	map  <Leader>f <Plug>(easymotion-bd-f)

	" Move to line
	map <Leader>L <Plug>(easymotion-bd-jk)

	" Move to word
	map  <Leader>w <Plug>(easymotion-bd-w)

  if !executable('ctags')
    let g:gutentags_dont_load = 1
  endif
	]])
-- init.vim

-- key_mappings.vim
vim.cmd([[
	" Switch between the last two files
	nnoremap <Leader><Leader> <c-^>

	"Clear current search highlight by double tapping //
	nmap <silent> // :nohlsearch<CR>

	" vim reload
	nmap <silent> <Leader>vr :source %<CR>

	" Type <space>hl to toggle highlighting on/off, and show current value.
	noremap <Leader>hl :set hlsearch! hlsearch?<CR>

	" Tabs
	nnoremap <S-Tab> gt
	nnoremap <silent> <S-t> :tabnew<CR>

	" copy and paste
	" <space>y + motion ex: <space>yw
	nnoremap <Leader>y "+y
	nnoremap <Leader>p "+p<CR>

	" Only used outside vscode
	if !exists('g:vscode')
	  " vim-rspec mappings
	  nnoremap <Leader>rs :call RunCurrentSpecFile()<CR>
	  nnoremap <Leader>rn :call RunNearestSpec()<CR>
	  nnoremap <Leader>rl :call RunLastSpec()<CR>
	  nnoremap <Leader>ra :call RunAllSpecs()<CR>

	  " Create window splits easier. The default
	  " way is Ctrl-w,v and Ctrl-w,s. I remap
	  " this to vv and ss 
	  " By skwp
	  nnoremap <silent> vv <C-w>v
	  nnoremap <silent> ss <C-w>s

	  " create <%= foo %> erb tags using Ctrl-k in edit mode
	  imap <silent> <C-K> <%=  %><Esc>2hi

	  " create <% foo %> erb tags using Ctrl-j in edit mode
	  imap <silent> <C-J> <%  %><Esc>2hi

	  " Re-enable tmux_navigator.vim default bindings, minus <c-\>.
	  " <c-\> conflicts with NERDTree "current file".

	  " Don't allow any default key-mappings.
	  let g:tmux_navigator_no_mappings = 1

	  nnoremap <silent> <c-h> :TmuxNavigateLeft<cr>
	  nnoremap <silent> <c-j> :TmuxNavigateDown<cr>
	  nnoremap <silent> <c-k> :TmuxNavigateUp<cr>
	  nnoremap <silent> <c-l> :TmuxNavigateRight<cr>

	  " zoom a vim pane, <C-w>= to re-balance
	  nnoremap <Leader>- :wincmd _<cr>:wincmd \|<cr>
	  nnoremap <Leader>= :wincmd =<cr>

	  " Rubocop
	  " map <Leader>ru :call VtrSendCommand('rubocop')<CR>
	  " map <Leader>rfu :call VtrSendCommand('rubocop ' . expand("%"))<CR>

	  " Flog
	  " map <Leader>fl :call VtrSendCommand('flog ' . expand("%"))<CR>

	  " Tab completion
	  " will insert tab at beginning of line,
	  " will use completion if not at beginning
	  function! InsertTabWrapper()
	      let col = col('.') - 1
	      if !col || getline('.')[col - 1] !~ '\k'
		  return "\<tab>"
	      else
		  return "\<c-p>"
	      endif
	  endfunction
	  inoremap <Tab> <c-r>=InsertTabWrapper()<cr>
	  inoremap <S-Tab> <c-n>

	  function! CloseNerdTree()
	    if g:NERDTree.IsOpen()
	      NERDTreeClose
	    else
	      NERDTreeFind
	    endif
	  endfunction
	  " ==== NERD tree
	  " Open the project tree and expose current file in the nerdtree with Ctrl-\
	  command! LocalCloseNerdTree call CloseNerdTree()
	  nnoremap <silent> <C-\> :LocalCloseNerdTree<cr>

	  " Index ctags from any project, including those outside Rails
	  map <Leader>ct :!ctags -R .<CR>

	  " Git Status
	  nnoremap <Leader>gs :Git<CR>

	  "grep the current word using K (mnemonic Kurrent)
	  nnoremap <silent> K :Ag <cword><CR>
	endif
	]])
-- key_mappings.vim

-- vtr.vim
vim.cmd([[
	if !exists('g:vscode')
	  " let is_tmux = $TMUX
	  " if is_tmux != ""
	  "   autocmd VimEnter * VtrAttachToPane
	  " endif

	  if filereadable(expand("./bin/rspec"))
	    let g:rspec_command = "VtrSendCommandToRunner! ./bin/rspec {spec}"
	  else
	    let g:rspec_command = "VtrSendCommandToRunner! rspec {spec}"
	  endif
	endif
]])
-- vtr.vim
