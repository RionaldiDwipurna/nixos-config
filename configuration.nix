# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "rdwp"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  hardware.enableAllFirmware = true;
  networking.networkmanager.enable = true;
  services.resolved = {
    enable = true;
  
    settings.Resolve = {
      DNSSEC = "true";
      DNSOverTLS = "true";
  
      Domains = [ "~." ];
  
      FallbackDNS = [
        "1.1.1.1#one.one.one.one"
        "1.0.0.1#one.one.one.one"
        "2606:4700:4700::1111#one.one.one.one"
        "2606:4700:4700::1001#one.one.one.one"
      ];
    };
  };
  networking.networkmanager.dns = "systemd-resolved";

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.rdwp = {
    isNormalUser = true;
    description = "rdwp";
    extraGroups = [ "networkmanager" "wheel" "bluetooth"];
    packages = with pkgs; [];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  programs.firefox.enable = true;
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    withUWSM = true;
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    kitty
    waybar
    git
    hyprpaper
    feh
    pstree
    (catppuccin-sddm.override {
      flavor = "frappe";
      accent = "sapphire";
      font  = "Noto Sans";
      fontSize = "9";
      background = "${./assets/pictures/bluewall1.jpg}";
      loginBackground = true;
    })

    #gaming related
    mangohud
    protonup-qt
    lutris
    # bottles
    heroic # for epic/gog

    # debugging tools for graphics
    vulkan-tools
    mesa-demos
  ];

  # workaround for installing lutris and bottles on unstable branch
  # bypass failing test on openldap
  nixpkgs.overlays = [
      (final: prev: {
        openldap = prev.openldap.overrideAttrs (oldAttrs: {
          doCheck = false;
        });
      })
  ];

  fonts.packages = with pkgs; [
    font-awesome
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-color-emoji
    fantasque-sans-mono
  ];

  # graphics and nvidia settings
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # steam/gaming related
  programs.steam = {
    enable = true;
    # for stream 
    # remotePlay.openFirewall = true;

    # for host server
    # dedicatedServer.openFirewall = false;
  };

  programs.gamescope = {
    enable = true;
  };
  
  programs.gamemode.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";

    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
  };
  # hyprlock
  programs.hyprlock.enable = true;
  security.pam.services.hyprlock = {};

  # sddm
  services.xserver.enable = true;
  services.displayManager.sddm = {
    enable = true;
    theme = "catppuccin-frappe-sapphire";
    package = pkgs.kdePackages.sddm;
    wayland.enable = false;
  };

  programs.zsh.enable = true;
  users.users.rdwp.shell = pkgs.zsh;

  # zram config
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 100;
    priority = 100;
  };
  # nix garbage collector
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  security.sudo.extraConfig = # sh
  ''
    Defaults pwfeedback # Make typed password visible as asterisks
  '';
  nix.settings.auto-optimise-store = true;
  # for sleep
  services.hypridle.enable = true;
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # for external hdd
  boot.supportedFilesystems = [ "ntfs" ];
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.ssh.startAgent = true;

  services.tailscale = {
    enable = true;
    # Enable tailscale at startup
  };
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.11"; # Did you read the comment?

  nix.settings.experimental-features = ["nix-command" "flakes"];

}
