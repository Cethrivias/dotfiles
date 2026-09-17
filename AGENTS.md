# Agent notes

Personal GNU Stow dotfiles. No tests, CI, or lockstep build. Edit files in this repo; do not copy them into `$HOME`.

## Layout

Each top-level directory except `scripts/` is a Stow package. The tree inside a package is relative to `$HOME`:

- `nvim/.config/nvim/init.lua` → `~/.config/nvim/init.lua`
- `zsh/.zshrc` → `~/.zshrc` (not under `.config`)
- `ssh/.ssh/config` → `~/.ssh/config`

From the repo root:

```bash
stow -t $HOME <package>
stow -R -t $HOME <package>   # after adding new files to an already-stowed package
```

Already-stowed files are symlinks; editing the repo file is the live config. Restow only when adding paths. `scripts/`, `Brewfile`, and `readme.md` are not packages.

`readme.md` stow list is incomplete. Also present as packages: `herdr`, `sesh`, `lazygit`, `alacritty`, `kitty`. Current terminal config is Ghostty; kitty/alacritty look leftover.

## Commits

`[package] short message` — e.g. `[nvim] tokyonight`, `[tmux, sesh, tv] …`. Default branch is `master`.

## Do not commit

- `tmux/.config/tmux/plugins/` (TPM, gitignored)
- `nvim/.config/nvim/lazy-lock.json` (gitignored)
- `zsh/.config/zsh/private/*.zsh` (secrets; gitignored)
- Vendored herdr plugin source (see below)

## Neovim

lazy.nvim loads every spec in `lua/plugins/*.lua`. Add plugins there, not in `init.lua`. Colorscheme is set in `init.lua` (`tokyonight`).

Lua style is `.stylua.toml`: 4-space indent, 120 cols, prefer single quotes, `no_call_parentheses = true` (`require 'foo'`, not `require('foo')`).

- C#: `vim.lsp.enable('roslyn_ls')` plus csharpier on `<leader>f`. Do not reintroduce omnisharp/`seblyng/roslyn.nvim` (commented out).
- Treesitter is `romus204/tree-sitter-manager.nvim`, not `nvim-treesitter`. Needs system `tree-sitter-cli`. `after/queries/*/highlights.scm` add `@spell` on identifiers; `treesitter.lua` auto-creates missing ones.
- `<C-h/j/k/l>` is custom in `lua/plugins/vim-tmux-navigator.lua` (Neovim splits, then herdr, then tmux). Do not add competing pane maps.
- `gitlab.vim` is hard-disabled (`cond = false`); it breaks lualine `lsp_status`.
- Mason `v2.x`. netrw is disabled; empty `nvim` opens Neotree.

## tmux / herdr / sesh

Both tmux and herdr use prefix `C-a`; keep that aligned.

TPM is expected at `~/.config/tmux/plugins/tpm` (not in git). `prefix+t` opens a television+sesh popup (`tv sesh`).

Herdr’s `vim-herdr-navigation` entries under `herdr/.config/herdr/plugins/` are gitlinks **without** `.gitmodules`. A fresh clone does not fetch the plugin. Install as in `readme.md` (clone + `herdr plugin link`); do not vendor the plugin into this repo.

## zsh

Prompt is oh-my-posh (`zsh/.config/ohmyposh/base.json`). Starship config exists but is commented out in `.zshrc`.

## OS split

- macOS: `Brewfile` (`brew bundle install` / `check -v` / `dump --force`), AeroSpace, Ghostty
- Arch: `scripts/initial-setup.sh` (paru), `scripts/install-1password.sh`, `scripts/install-docker.sh`; MangoHud is Linux-only

`scripts/mount.sh` is an interactive CIFS/systemd automount helper; do not run it as part of normal config work.

SSH uses 1Password (`IdentityAgent ~/.1password/agent.sock`).
