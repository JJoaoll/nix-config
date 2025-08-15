{ config, pkgs, ...}: {

  imports = [
    ./firefox.nix
    ./git.nix
    ./vesktop.nix
  ];

}


