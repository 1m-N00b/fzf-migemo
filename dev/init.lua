-- Lazy
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

require("lazy").setup({
  {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    require("fzf-lua").setup({})
  end
  },
})

-- 最小構成
local function migemo_to_regex(query)
  -- TODO:rustmigemo or jsmigemo with denops
  -- TODO:ソーターとしての実装
  -- https://github.com/rhysd/migemo-search.vim
  -- https://github.com/lambdalisue/vim-kensaku
  -- https://github.com/Allianaab2m/telescope-kensaku.nvim
end


function live_grep_with_migemo()
  require("fzf-lua").fzf_live({
    prompt = 'Live Grep> ',
    input_fn = function()
      local query = vim.fn.input("Query: ")
      -- TODO:Implement i-search with migemo
      -- local regex = migemo_to_regex(query)
      return io.popen('grep -rn --color=never -E ' .. regex .. ' .'):lines()
    end,
  })
end

-- Keymaps
vim.g.mapleader = " "
vim.o.incsearch = true
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>lua live_grep_with_migemo()<CR>', { noremap = true, silent = true })
