{config, pkgs, ...}:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    hypr = "hypr";
    nvim = "nvim";
    waybar = "waybar";
    kitty = "kitty";
    btop = "btop";
  };
in
{
  home.username = "rdwp";
  home.homeDirectory = "/home/rdwp";
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    # Waybar ecosystem
    waybar
  
    # Audio
    pamixer
    pavucontrol
  
    # Network manager GUI
    networkmanagerapplet
  
    # Notifications
    swaynotificationcenter
  
    swayosd
    rofi

    # Screenshot tools
    grim
    slurp
    wl-clipboard
    cliphist

    # finder
    fzf
    ripgrep
    fd

    # file manager
    thunar

    # neovim related
    neovim
    git
    gcc
    nodejs
    unzip
    curl
    tree-sitter

    # wallpaper
    awww

    # process viewer
    btop
    nvtopPackages.nvidia #nvidia only

    qbittorrent
    (prismlauncher.override {
      jdks = [
        temurin-bin-17 # Perfectly matches your friend's Minecraft 1.20.1 server
      ];
    })


    # bluetooth
    blueman

    # local llm
    (llama-cpp.override { cudaSupport = true; })

    google-chrome

  ];

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.resurrect
      tmuxPlugins.continuum
      tmuxPlugins.yank
    ];
    extraConfig = ''
      # === Terminal / colors (preserves Catppuccin + truecolor in nvim) ===
      set -g default-terminal "tmux-256color"
      set -ag terminal-overrides ",xterm-256color:RGB"
      set -ga terminal-features ",xterm-256color:RGB"
      set -as terminal-features ',xterm-256color:clipboard'
      set -g set-clipboard on
      set -g mouse on

      # === Prefix stays Ctrl+B (no conflict with current binds) ===
      # To swap to Ctrl+A, uncomment:
      # set -g prefix C-a | unbind C-b | bind C-a send-prefix

      # === Reload config ===
      bind r source-file ~/.config/tmux/tmux.conf \; display "reloaded!"

      # === vim-tmux-navigator ===
      # Ctrl+H/J/K/L moves between tmux panes AND nvim splits seamlessly
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -qE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"
      bind -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
      bind -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
      bind -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
      bind -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"

      # === Session persistence (resurrect + continuum) ===
      set -g @resurrect-capture-pane-contents 'on'
      set -g @continuum-save-interval '15'
      set -g @continuum-restore 'on'
      set -g @continuum-boot 'on'

      # === Quality of life ===
      set -g base-index 1
      setw -g pane-base-index 1
      set -g renumber-windows on
      set -g history-limit 10000

      # === Copy mode: use vi-style keys (h/j/k/l, v to select, y to yank) ===
      setw -g mode-keys vi

      bind h split-window -h -c "#{pane_current_path}"
      bind v split-window -v -c "#{pane_current_path}"

      # === Resize panes (vim-style: Ctrl+B, Ctrl+h/j/k/l) ===
      bind -r -T prefix C-h resize-pane -L
      bind -r -T prefix C-j resize-pane -D
      bind -r -T prefix C-k resize-pane -U
      bind -r -T prefix C-l resize-pane -R

      # === Resize panes (bigger step: Ctrl+B, Alt+h/j/k/l) ===
      bind -r -T prefix M-h resize-pane -L 10
      bind -r -T prefix M-j resize-pane -D 10
      bind -r -T prefix M-k resize-pane -U 10
      bind -r -T prefix M-l resize-pane -R 10
    '';
  };

  programs.vesktop.enable = true;

  programs.opencode = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "RionaldiDwipurna";
        email = "70762968+RionaldiDwipurna@users.noreply.github.com";
      };
      core.editor = "vim";
      init.defaultBranch = "master";
    };
  };

  programs.zsh = {
    enable = true;

    oh-my-zsh = {
      enable = true;

      theme = "agnoster";

      plugins = [
        "git"
        "sudo"
        "fzf"
      ];
    };
    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles#rdwp";
      nfu = "cd ~/dotfiles && nix flake update";
      oc  = "opencode --port --continue";
    };

    # initContent = ''
    #   PROMPT='%F{#8CAAEE}%n%F{#737994}@%F{#8CAAEE}%m%f %F{#CA9EE6}%~%f %F{#A6D189}>%f '
    # '';
    #profileExtra = ''
    #  if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    #    if uwsm check may-start;then
    #      exec uwsm start hyprland-uwsm.desktop
    #    fi 
    #  fi
    #'';
  };

  programs.fastfetch = {
    enable = true;
  };

  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${dotfiles}/${subpath}";
      # source = config.lib.file.mkOutOfStoreSymlink
      #   "${dotfiles}/${subpath}";
      recursive = true;
    })
    configs;
}
