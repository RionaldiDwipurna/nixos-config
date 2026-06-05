nvim



terminal

ohmyzsh
from fzf 

ctrl + T = select and paste the selected file
ctrl + R = select and paste the previous command history
alt + C = cd to selected dir

from git
ga = git add
gaa = git add all
gcmsg = git commit with message
gp = git push
gcl = git clone with recursive submodule
gd = git diff
gst = git status



shortcut
nrs = sudo nix rebuild switch --flake 
nfu = nix flake update
oc  = opencode --port --continue (exposes server for nvim integration; auto-resumes last session)


tmux (default prefix: Ctrl+B)

session (tmux server keeps running when you close kitty)
prefix, d          = detach from current session (session survives)
prefix, s          = list + switch sessions interactively
prefix, $          = rename current session
prefix, (          = switch to previous session
prefix, )          = switch to next session
prefix, L          = jump to last session

window (one per "tab" in tmux)
prefix, c          = create new window
prefix, ,          = rename current window
prefix, &          = kill current window
prefix, n          = next window
prefix, p          = previous window
prefix, 0-9        = select window by number
prefix, w          = list all windows (tree view)
prefix, f          = find a window by name

pane (split inside a window)
prefix, h          = split vertical (left/right panes) — vim axis
prefix, v          = split horizontal (top/bottom panes) — vim axis
prefix, x          = kill current pane
prefix, z          = toggle pane fullscreen (zoom)
prefix, o          = cycle through panes
prefix, ;          = jump to last-active pane
prefix, {          = swap with previous pane
prefix, }          = swap with next pane
prefix, q          = briefly show pane numbers (press number to jump)
prefix, !          = break pane out into its own window

resize (with prefix held, vim-style: HJKL directions)
prefix, Ctrl+h     = resize left  by 1  (hold to repeat)
prefix, Ctrl+j     = resize down  by 1
prefix, Ctrl+k     = resize up    by 1
prefix, Ctrl+l     = resize right by 1
prefix, Alt+h      = resize left  by 10
prefix, Alt+j      = resize down  by 10
prefix, Alt+k      = resize up    by 10
prefix, Alt+l      = resize right by 10
prefix, z          = zoom current pane to fullscreen (toggle)

copy mode (vim-style: HJKL move, v to select, y to yank, / to search)
prefix, [          = enter copy mode
prefix, ]          = paste from tmux buffer
y                  = yank selection to system clipboard (yank plugin)
q                  = quit copy mode

vim-tmux-navigator (works WITHOUT prefix)
Ctrl+H             = focus pane on the left  (in nvim: focus split on the left)
Ctrl+J             = focus pane below         (in nvim: focus split below)
Ctrl+K             = focus pane above         (in nvim: focus split above)
Ctrl+L             = focus pane on the right  (in nvim: focus split on the right)
Ctrl+\             = jump to last-active tmux pane (works only from nvim)

resurrect + continuum (session persistence)
prefix, Ctrl+s     = manually save session state to disk
prefix, Ctrl+r     = manually restore last saved state
(auto: saves every 15 min, restores on next tmux start)

misc
prefix, r          = reload ~/.config/tmux/tmux.conf
prefix, t          = big clock
prefix, ?          = list all key bindings


hyprland related:

SUPER + Enter (return) = new terminal (attaches to tmux `main` — persistent, surviving closes)
SUPER + SHIFT + Enter = new independent terminal (fresh tmux session, no mirroring)
SUPER + Q = close focused window
SUPER + M = Close hyprland
SUPER + SHIFT + R = Restart waybar
SUPER + R = open menu finder
SUPER + V = toggle window floating
SUPER + E = open file manager

SUPER + H J K L = move focus window
SUPER + SHIFT + H J K L = move window position
SUPER + SHIFT + H J K L = resize focused window
SUPER + TAB = focus workspace cycled
SUPER + SHIFT + TAB = focus workspace cycled backward
SUPER + 1 to 9 = change/new workspace
SUPER + J = change split layout
SUPER + S = toggle special workspace (overlay)
SUPER SHIFT + S = move to special workspace (overlay)


screenshot
SUPER + SHIFT + P = snipping tool (clipboard)
SUPER + SHIFT + C = save screenshot to ~/Pictures/

nvim

leader -> space
leader space = open finder
gd = jump definition
gi = jump implementation
gr = jump references
CTRL + i =  jump next
CTRL + o =  jump prev
gs = flash vim
gS = flash vim
leader sk = see keymaps


CTRL + H J K L = move to left/lower/up/right split
SHIFT + H L = left/right opened tab
p
SUPER + g + ... = open git
SUPER + s + k = keymaps nvim
SUPER + f + t = terminal inside nvim


nvim (opencode integration):
<Space>ot = toggle opencode terminal
<Space>oa = ask opencode about current line/selection (sends @this)
<Space>oo = opencode action picker

model selection (inside opencode TUI):
  Tab        = cycle model / provider
  /model     = open model picker
  shows entries like: openrouter/anthropic/claude-sonnet-latest  (cloud)
                       llama.cpp / Gemma 4 12B QAT Q4_0 (local)   (needs llama-server running)

local LLM (llama-server + llama.cpp + opencode):
  llm-models live in ~/llm-models/*.gguf
  llama-start   = start llama-server in background, log -> ~/.llama-server.log
  llama-stop    = kill the server
  llama-status  = query the /v1/models endpoint (also reveals if server is up)
  full command: llama-server -m ~/llm-models/gemma-4-12b-it-qat-q4_0.gguf \
                  --port 8080 -ngl 99 -c 32768
    -m  = model path
    --port 8080 = OpenAI-compatible API on http://127.0.0.1:8080/v1
    -ngl 99 = offload all layers to GPU
    -c 32768 = context window size (32K tokens; matches opencode.jsonc limit.context)
  opencode provider: defined in ~/dotfiles/config/opencode/opencode.jsonc
  model limits (opencode.jsonc): context=32768, output=8192
    context = total window ceiling (prompt + history + reply)
    output  = max tokens the model can emit in one reply
    prompt side is capped at context - output = 24576 tokens before compaction
  to use: opencode -> Tab or /model -> pick "llama.cpp / Gemma 4 12B QAT Q4_0 (local)"
  trade-off: free + private + offline, but ~12B Q4_0 is weaker at tool calling
             than Claude/GPT; keep cloud default for hard agentic work

:LazyExtras for marketplace
