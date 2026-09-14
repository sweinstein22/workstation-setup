# Workstation Setup

Scripts for various workstation setup things. Targets macOS (Apple Silicon or Intel)
with zsh as the login shell.

Run `./install.sh`. It runs, in order:

| Script | What it does |
| --- | --- |
| `install-core.sh` | Xcode command line tools, Homebrew |
| `zsh.sh` | oh-my-zsh (must precede anything that appends to `~/.zshrc`) |
| `brew.sh` | `brew shellenv` into `~/.zprofile`, then the `Brewfile` |
| `aliases.sh` | aliases and keybindings into `~/.zshrc` |
| `git-config.sh` | `assets/gitconfig` into `~/.gitconfig` (backs up any existing one) |
| `dev-setup.sh` | iTerm preferences, neovim, tmux, `~/.inputrc` |

## neovim

`dev-setup.sh` pins `luan/nvim` to `ed4220a`. That branch's main is now a LazyVim
rewrite with a different config layout, and `assets/after.vim` depends on
`g:leader_key_map` and `g:coc_filetype_map`, which only exist in the vimscript
config. Unpinning means porting `after.vim` first.

Files in `assets/` ending in `.vim` are symlinked into `~/.config/nvim/user/`. Only
`before.vim` and `after.vim` are actually sourced -- `init.vim` names them
individually rather than globbing the directory.

pynvim lives in a virtualenv at `~/.local/share/nvim-venv` because Homebrew's python
is externally managed (PEP 668). `assets/before.vim` points neovim at it.

## setting-files/

Reference copies of dotfiles, for consulting or hand-copying. No script installs
them; `~/.zshrc` is assembled by `zsh.sh` plus `aliases.sh` instead.

Keep secrets out of `dot.zshrc` -- it sources `~/.zshrc.local`, which is not in git.

Claude plugins:
- https://github.com/JuliusBrussee/caveman
- https://github.com/tomasz-tomczyk/crit
