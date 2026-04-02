-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- 1. 맞춤법 검사(한글 지그재그 밑줄) 끄기
vim.opt_local.spell = false

-- 2. 화면을 가리는 에러 및 경고 표시 완전히 끄기
vim.diagnostic.config({
  virtual_text = false, -- 코드 오른쪽에 뜨는 설명 제거
  signs = false, -- 화면 왼쪽 줄 번호 옆의 아이콘 제거
  underline = false, -- 코드 아래 빨간 밑줄 제거
})

vim.opt.relativenumber = false
