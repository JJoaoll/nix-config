{ config, pkgs, ...}: {

  imports = [
    # ./emacs.nix
    # ./nano.nix
    ./nvim
    # ./vscode.nix
  ];
}
