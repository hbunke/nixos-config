# Samba; https://nixos.wiki/wiki/Samba
# https://gist.github.com/vy-let/a030c1079f09ecae4135aebf1e121ea6

# don't forget to add user: sudo smbpasswd -a bunke

{ config, pkgs, ... }:

{
  services.samba = {
    package = pkgs.samba4Full;
    enable = true;
    openFirewall = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "yoda";
        "netbios name" = "yoda";
        "security" = "user";
        #"use sendfile" = "yes";
        #"max protocol" = "smb2";
        # note: localhost is the ipv6 localhost ::1
        "hosts allow" = "192.168.0. 127.0.0.1 localhost";
        "hosts deny" = "0.0.0.0/0";
        "guest account" = "nobody";
        "map to guest" = "bad user";
      
      };
      "scan" = {
        "path" = "/home/bunke/SCANS";
        "browseable" = "yes";
        "read only" = "no";
        "guest ok" = "no";
        "create mask" = "0644";
        "directory mask" = "0755";
        #"force user" = "bunke";
        #"force group" = "groupname";
      };
    };
  };
  services.avahi = {
    publish.enable = true;
    publish.userServices = true;
    enable = true;
    openFirewall = true;
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };
}