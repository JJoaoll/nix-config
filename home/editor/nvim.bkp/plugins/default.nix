{ config, lib, pkgs, ... }: {

  imports = [
    ./alpha.nix
    ./neotree.nix
    ./treesitter.nix
    ./telescope.nix
    ./todo-comments.nix
  ];

}


