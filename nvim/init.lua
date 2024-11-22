-- Thiết lập chung
vim.opt.number = true            -- Hiện số dòng
-- vim.opt.relativenumber = true    -- Hiện số dòng tương đối
vim.opt.tabstop = 4              -- Kích thước tab (4 spaces)
vim.opt.shiftwidth = 4           -- Kích thước thụt dòng
vim.opt.expandtab = true         -- Sử dụng spaces thay cho tab
vim.opt.cursorline = true        -- Bật highlight dòng hiện tại
vim.opt.wrap = false             -- Tắt quấn dòng
vim.o.clipboard = "unnamedplus"

-- Tìm kiếm
vim.opt.ignorecase = true        -- Bỏ qua phân biệt chữ hoa/thường khi tìm
vim.opt.smartcase = true         -- Phân biệt khi có ký tự hoa

-- Giao diện
vim.opt.termguicolors = true     -- Bật chế độ màu tốt hơn
vim.opt.signcolumn = "yes"       -- Hiện cột sign (vd: LSP warnings/errors)

-- Phím tắt (Keymaps)
vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>fg", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- Đảm bảo rằng packer đã được cài đặt
local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd('packadd packer.nvim')
    return true
  end
  return false
end

require'lspconfig'.pyright.setup{}

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  -- Packer itself
  use 'wbthomason/packer.nvim'

  -- Các plugin của bạn
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }

  -- Plugin tìm kiếm: telescope.nvim
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  -- Plugin hỗ trợ LSP: nvim-lspconfig
  use 'neovim/nvim-lspconfig'

  -- Plugin hỗ trợ Treesitter: nvim-treesitter
  use 'nvim-treesitter/nvim-treesitter'

  -- Plugin cho Git: vim-fugitive
  use 'tpope/vim-fugitive'

  -- Plugin quản lý các file: nerdtree
  use 'preservim/nerdtree'

  -- Plugin tự động hoàn thành: nvim-cmp
  use 'hrsh7th/nvim-cmp'

  -- Plugin hỗ trợ snippets: luasnip
  use 'L3MON4D3/LuaSnip'

  -- Plugin thanh trạng thái đẹp: lightline
  use 'itchyny/lightline.vim'

  -- Các plugin tiện ích khác
  use 'tpope/vim-surround'
  use 'Chiel92/vim-autoformat'

  if packer_bootstrap then
    require('packer').sync()
  end
end)  -- <-- Ensure this is the closing 'end' for the packer.startup function
