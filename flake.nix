{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    xmonad-contrib.url = "github:xmonad/xmonad-contrib";

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
      # Optionally, you can also override individual plugins
      # for example:
      # inputs.obsidian-nvim.follows = "obsidian-nvim"; 
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ nixpkgs, home-manager, xmonad-contrib, ... }: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };

        modules = [
          ./modules/configuration.nix

        home-manager.nixosModules.home-manager
          {
            home-manager = {  
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = { inherit inputs; system = "x86_64-linux"; };

              users.jjoaoll = import ./modules/home;
            };
          }
        ] ++ xmonad-contrib.nixosModules ++ [
          xmonad-contrib.modernise.${system}
        ];
      };
    };
  };
}
