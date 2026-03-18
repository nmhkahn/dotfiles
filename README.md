# dotfiles

GNU Stow로 관리하는 개인 설정 파일 모음. Mac과 Ubuntu 서버에서 공유.

## 패키지 구조

| 패키지 | 내용 |
|---|---|
| `zsh/` | `.zshrc`, `.zshenv`, `.zprofile` |
| `nvim/` | LazyVim 기반 Neovim 설정 |
| `git/` | `.gitconfig`, global ignore |
| `ghostty/` | Ghostty 터미널 설정 |
| `bin/` | 커스텀 스크립트 (`msync`, `ignore_ext`) |

## 설치 (Mac)

```bash
git clone git@github.com:nmhkahn/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow zsh nvim git ghostty bin
```

## 설치 (Ubuntu)

```bash
# 1. 필수 패키지 설치
sudo apt install git stow zsh neovim

# 2. oh-my-zsh 설치
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 3. dotfiles 클론 및 stow
git clone git@github.com:nmhkahn/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
stow zsh nvim git ghostty bin

# 4. 머신별 설정 (API 키 등)
echo 'export OPENAI_API_KEY="sk-..."' >> ~/.zshrc.local
```

## 머신별 설정

API 키, 인증 정보 등 민감한 설정은 `~/.zshrc.local`에 저장 (git에 포함되지 않음).
