# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      #./hardware-configuration.nix
      #./sway.nix
      #./local.nix  # local.nix is symlinked to <machine>.nix
    ];



 # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;


  boot.kernelModules = [ "fuse" ];

  # this makes installation of kernel modules, solaar, and configuration of udev
  # rules obsolete :-)
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  # networking.hostName = "yoda"; # hostname defined in <machine>.nix!!!

  
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # this also might be obsolete w/o evolution, and in Gnome 
  xdg.portal = {
    enable = true;
    extraPortals = [ 
      pkgs.xdg-desktop-portal-gnome 
      pkgs.xdg-desktop-portal-gtk 
    ];
    config.common.default = "gtk";
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "de";
    variant = "nodeadkeys";
  };


  # failed configs for Evolution; now installed via flatpak, but it won't hurt
  # to have those configs here, will it?
  services.gnome.gnome-keyring.enable = true;
  programs.dconf.enable = true;
  services.gnome.evolution-data-server.enable = true;
  services.gnome.gnome-online-accounts.enable = true;
  services.gvfs.enable = true;
  

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  #### https://nixos.wiki/wiki/Podman ####
  # Enable common container config files in /etc/containers
  virtualisation.containers.enable = true;
  virtualisation = {
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  
  services.syncthing = {
    enable = true;
    user = "bunke";
    dataDir = "/home/bunke";
    configDir = "/home/bunke/.config/syncthing";
  };

  # fish config is in home-manager
  programs.fish.enable = true;
  


  # create fuse group
  users.groups.fuse = { };
  

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.bunke = {
    isNormalUser = true;
    description = "Hendrik Bunke";
    extraGroups = [ "networkmanager" "wheel" "fuse" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      syncthing
      ptyxis
      webex # webex works flawlessly under nixos, while under fedora it even refuses to start 
      element-desktop
      fractal
      fuse
      pcloud
      bitwarden
      proton-pass # flatpak?
      signal-desktop
      syncthingtray
      gnome-extension-manager
      pandoc
      tutanota-desktop
      filen-desktop
      obsidian
      gimp
    
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    wget
    gnome-tweaks
    git
    adwaita-fonts
    podman-compose
    nerd-fonts.commit-mono
    gnomeExtensions.night-theme-switcher
    gnomeExtensions.printers
    gnomeExtensions.solaar-extension
    distrobox
    font-awesome
    filen-desktop
    # brave ## better with flatpak
  ];

  #programs.hyprland.enable = true; # enable Hyprland
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  services.flatpak.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;


  nix.extraOptions = ''
    experimental-features = nix-command flakes
    
  '';
 
 


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;


  # system.stateVersion = "24.11"; # defined in <hostname>.nix, so it can be different for each machine
  
}
