{ config, pkgs, ...}: {

  imports = [
    ./editor
    ./keyboard
    ./programs
    ./shell
    # ./i3
  ];

  home = {
    username = "jjoaoll";
    homeDirectory = "/home/jjoaoll";
    stateVersion = "25.05";
  };
}
