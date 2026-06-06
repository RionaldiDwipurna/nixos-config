# Keyboard Shortcuts

> Quick reference for tmux, nvim, hyprland, ohmyzsh, and opencode on this NixOS setup.

## Terminal (ohmyzsh)

### fzf

| Key | Action |
| --- | --- |
| `Ctrl + T` | select and paste the selected file |
| `Ctrl + R` | select and paste the previous command history |
| `Alt + C` | `cd` to selected dir |

### git aliases

| Alias | Command |
| --- | --- |
| `ga` | `git add` |
| `gaa` | `git add all` |
| `gcmsg` | `git commit` (with message) |
| `gp` | `git push` |
| `gcl` | `git clone` (with recursive submodule) |
| `gd` | `git diff` |
| `gst` | `git status` |

### Custom shell aliases

| Alias | Action |
| --- | --- |
| `nrs` | `sudo nixos-rebuild switch --flake ~/dotfiles#rdwp` |
| `nfu` | `nix flake update` |
| `oc` | `opencode --port --continue` — exposes server for nvim integration; auto-resumes last session |
| `re` | `exec zsh` — replace current shell (picks up new home-manager aliases, env vars, PATH, completions) |
| `llama-start` | start `llama-server` in background, log → `~/.llama-server.log` |
| `llama-stop` | kill the server |
| `llama-status` | query `/v1/models` (also reports if server is up) |

## tmux (default prefix: `Ctrl+B`)

### Session (server keeps running when kitty closes)

| Key | Action |
| --- | --- |
| `prefix, d` | detach from current session (session survives) |
| `prefix, s` | list + switch sessions interactively |
| `prefix, $` | rename current session |
| `prefix, (` | switch to previous session |
| `prefix, )` | switch to next session |
| `prefix, L` | jump to last session |

### Window (one per "tab")

| Key | Action |
| --- | --- |
| `prefix, c` | create new window |
| `prefix, ,` | rename current window |
| `prefix, &` | kill current window |
| `prefix, n` | next window |
| `prefix, p` | previous window |
| `prefix, 0-9` | select window by number |
| `prefix, w` | list all windows (tree view) |
| `prefix, f` | find a window by name |

### Pane (split inside a window)

| Key | Action |
| --- | --- |
| `prefix, h` | split vertical (left/right panes) — vim axis |
| `prefix, v` | split horizontal (top/bottom panes) — vim axis |
| `prefix, x` | kill current pane |
| `prefix, z` | toggle pane fullscreen (zoom) |
| `prefix, o` | cycle through panes |
| `prefix, ;` | jump to last-active pane |
| `prefix, {` | swap with previous pane |
| `prefix, }` | swap with next pane |
| `prefix, q` | briefly show pane numbers (press number to jump) |
| `prefix, !` | break pane out into its own window |

### Resize (with prefix held, vim-style: HJKL directions)

| Key | Action |
| --- | --- |
| `prefix, Ctrl+h` | resize left by 1 (hold to repeat) |
| `prefix, Ctrl+j` | resize down by 1 |
| `prefix, Ctrl+k` | resize up by 1 |
| `prefix, Ctrl+l` | resize right by 1 |
| `prefix, Alt+h` | resize left by 10 |
| `prefix, Alt+j` | resize down by 10 |
| `prefix, Alt+k` | resize up by 10 |
| `prefix, Alt+l` | resize right by 10 |
| `prefix, z` | zoom current pane to fullscreen (toggle) |

### Copy mode (vim-style: HJKL move, `v` to select, `y` to yank, `/` to search)

| Key | Action |
| --- | --- |
| `prefix, [` | enter copy mode |
| `prefix, ]` | paste from tmux buffer |
| `y` | yank selection to system clipboard (yank plugin) |
| `q` | quit copy mode |

### vim-tmux-navigator (works WITHOUT prefix)

| Key | Action |
| --- | --- |
| `Ctrl+H` | focus pane on the left (in nvim: focus split on the left) |
| `Ctrl+J` | focus pane below (in nvim: focus split below) |
| `Ctrl+K` | focus pane above (in nvim: focus split above) |
| `Ctrl+L` | focus pane on the right (in nvim: focus split on the right) |
| `Ctrl+\` | jump to last-active tmux pane (works only from nvim) |

### Resurrect + Continuum (session persistence)

| Key | Action |
| --- | --- |
| `prefix, Ctrl+s` | manually save session state to disk |
| `prefix, Ctrl+r` | manually restore last saved state |

> Auto: saves every 15 min, restores on next tmux start.

### Misc

| Key | Action |
| --- | --- |
| `prefix, r` | reload `~/.config/tmux/tmux.conf` |
| `prefix, t` | big clock |
| `prefix, ?` | list all key bindings |

## Hyprland

| Key | Action |
| --- | --- |
| `SUPER + Enter` | new terminal (attaches to tmux `main` — persistent, survives closes) |
| `SUPER + SHIFT + Enter` | new independent terminal (fresh tmux session, no mirroring) |
| `SUPER + Q` | close focused window |
| `SUPER + M` | close Hyprland |
| `SUPER + SHIFT + R` | restart waybar |
| `SUPER + R` | open menu finder |
| `SUPER + V` | toggle window floating |
| `SUPER + E` | open file manager |
| `SUPER + H/J/K/L` | move focus window |
| `SUPER + SHIFT + H/J/K/L` | move window position |
| `SUPER + SHIFT + H/J/K/L` | resize focused window |
| `SUPER + Tab` | focus workspace cycled |
| `SUPER + SHIFT + Tab` | focus workspace cycled backward |
| `SUPER + 1..9` | change/new workspace |
| `SUPER + J` | change split layout |
| `SUPER + S` | toggle special workspace (overlay) |
| `SUPER + SHIFT + S` | move to special workspace (overlay) |

## Screenshot

| Key | Action |
| --- | --- |
| `SUPER + SHIFT + P` | snipping tool (clipboard) |
| `SUPER + SHIFT + C` | save screenshot to `~/Pictures/` |

## nvim

> `leader` = `space`

| Key | Action |
| --- | --- |
| `leader space` | open finder |
| `gd` | jump to definition |
| `gi` | jump to implementation |
| `gr` | jump to references |
| `Ctrl + i` | jump next |
| `Ctrl + o` | jump prev |
| `gs` | flash vim |
| `gS` | flash vim |
| `leader sk` | see keymaps |
| `Ctrl + H/J/K/L` | move to left/lower/up/right split |
| `Shift + H/L` | left/right opened tab |
| `p` | (placeholder — original entry) |
| `SUPER + g + ...` | open git |
| `SUPER + s + k` | keymaps nvim |
| `SUPER + f + t` | terminal inside nvim |

## nvim (opencode integration)

| Key | Action |
| --- | --- |
| `Space o t` | toggle opencode terminal |
| `Space o a` | ask opencode about current line/selection (sends `@this`) need opencode running (in terminal or tmux by running 'oc')|
| `Space o o` | opencode action picker |

note: don't forget to install the TPS meter plugins for opencode, you need to install it using opencode plugins oc-tps@latestt or just use npm install inside the plugins folder

### Model selection (inside opencode TUI)

| Key | Action |
| --- | --- |
| `Tab` | cycle model / provider |
| `/model` | open model picker |

Entries look like:

- `openrouter/anthropic/claude-sonnet-latest` — cloud
- `llama.cpp / Gemma 4 12B QAT Q4_0` — local (needs `llama-server` running)

## Local LLM (llama-server + llama.cpp + opencode)

Models live in `~/llm-models/*.gguf`.

Full command:

```sh
llama-server -m ~/llm-models/gemma-4-12b-it-qat-q4_0.gguf --port 8080 -ngl 99 -c 32768 -fa on --no-mmap -np 1 --cache-ram 0
```

| Flag | Meaning |
| --- | --- |
| `-m` | model path |
| `--port 8080` | OpenAI-compatible API on `http://127.0.0.1:8080/v1` |
| `-ngl 99` | offload all layers to GPU |
| `-c 32768` | context window size (32K tokens; matches `opencode.jsonc limit.context`) |
| `-fa on` | flash attention — exact attention, faster + lower peak compute memory (value: `on` / `off` / `auto`) |
| `--no-mmap` | read entire model into RAM at startup (no `mmap`); pinned, non-evictable; eliminates disk re-reads from page cache |
| `-np 1` | force `n_parallel = 1` (single concurrent request); saves ~2–3 GB of reserved KV cache (server's `auto` would use 4) |
| `--cache-ram 0` | disable the prompt cache (server's default is 8192 MiB); saves ~4 GB+ of RAM that the cache was consuming, and eliminates the slow partial-reuse path that caused the 50s prefill freeze |

**opencode provider** is defined in `~/dotfiles/config/opencode/opencode.jsonc`. Model limits:

- `context = 32768` — total window ceiling (prompt + history + reply)
- `output = 8192` — max tokens the model can emit in one reply
- prompt side is capped at `context - output = 24576` tokens before compaction

**To use:** open opencode → `Tab` or `/model` → pick `llama.cpp / Gemma 4 12B QAT Q4_0 (local)`.

**Trade-off:** free + private + offline, but a 12B Q4_0 model is weaker at tool calling than Claude/GPT — keep cloud default for hard agentic work.

## LazyVim

`:LazyExtras` for marketplace.
