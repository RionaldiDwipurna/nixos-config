{config, pkgs, ...}:

{
  home.username = "rdwp";
  home.homeDirectory = "/home/rdwp";
  home.stateVersion = "25.11";

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

    profileExtra = ''
      if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
        if uwsm check may-start;then
          exec uwsm start hyprland-uwsm.desktop
        fi 
      fi
    '';
  };



}
