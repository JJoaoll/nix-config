{ config, pkgs, ...}: {

  imports = [
    ./bash.nix
    ./fzf.nix
    ./kitty.nix
    ./starship.nix
  ];

}


