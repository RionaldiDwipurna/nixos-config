{config, pkgs, ...}:
let
  dotfiles = "${config.home.homeDirectory}/dotfiles/config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    hypr = "hypr";
    nvim = "nvim";
    waybar = "waybar";
    kitty = "kitty";
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

  ];
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

    shellAliases = {
      nrs = "sudo nixos-rebuild switch --flake ~/dotfiles#rdwp";
    };

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
