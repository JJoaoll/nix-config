{ config, pkgs, ...}: {

  imports = [
    ./editor
    ./keyboard
    ./programs
    ./shell
    ./xmonad
  ];

  home = {
    username = "jjoaoll";
    homeDirectory = "/home/jjoaoll";
    stateVersion = "25.05";
  };
}
