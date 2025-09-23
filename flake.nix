{
  description = "my first nixos configuration with flakes";

  inputs = {
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; 
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05"; 
    flake-utils.url = "github:numtide/flake-utils"; # brauch ich die?
  };

  outputs = { self, nixpkgs, flake-utils, ... }: {
    
    nixosConfigurations = with nixpkgs.lib; {
      
      yoda = nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./yoda/hardware-configuration.nix 
          ./samba.nix
          ./sway.nix
          {
            networking.hostName = "yoda"; # Define your hostname.
            system.stateVersion = "24.11"; # Did you read the comment?
          }
        ];
      };
    
      defiant = nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
          ./defiant/hardware-configuration.nix
          ./sway.nix
          {
            networking.hostName = "defiant"; # Define your hostname.
            system.stateVersion = "24.11"; # Did you read the comment?
          }
        ];
      };
   };
  };
}

