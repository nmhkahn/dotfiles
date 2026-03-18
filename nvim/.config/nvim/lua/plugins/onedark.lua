-- ~/.config/nvim/lua/plugins/onedark.lua
return {
  -- 1. One Dark 플러그인 설치 및 상세 설정
  {
    "navarasu/onedark.nvim",
    priority = 1000, -- 테마가 다른 플러그인보다 먼저 로드되도록 설정
    opts = {
      style = "darker", -- 'dark', 'darker', 'cool', 'deep', 'warm', 'abyss' 중 선택 가능
      transparent = true, -- 배경을 투명하게 해서 Ghostty의 배경이 보이게 함
      term_colors = true, -- 터미널 색상 사용
      ending_tildes = false, -- 파일 끝 물결표시(~) 숨김

      -- 코드 스타일 커스텀 (취향껏 수정 가능)
      code_style = {
        comments = "italic",
        keywords = "none",
        functions = "none",
        strings = "none",
        variables = "none",
      },
    },
    config = function(_, opts)
      require("onedark").setup(opts)
      require("onedark").load()
    end,
  },

  -- 2. LazyVim의 기본 색상표를 onedark로 변경
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "onedark",
    },
  },
}
