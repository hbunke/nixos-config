
{ config, pkgs, ... }:

{

# enable sway window manager
  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    # test to put this in home-manager
    # extraPackages = with pkgs; [
    #   #dbus-sway-environment # defined above
    #   #configure-gtk #defined above
    #   waybar
    #   xdg-utils
    #   glib
    #   swaylock
    #   swayidle
    #   grim
    #   slurp
    #   sway-contrib.grimshot
    #   wl-clipboard
    #   bemenu
    #   rofi
    #   # mako
    #   wdisplays
    #   networkmanagerapplet
    #   libnotify
    #   dunst
    #   pavucontrol
    #   light
    #   blueman 
    # ];
   
  };

  security.polkit.enable = true;
  xdg.portal.config.common.default = "wlr";

}