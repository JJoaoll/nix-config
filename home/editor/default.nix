{ config, pkgs, ...}: {

  imports = [
    # ./emacs.nix
    # ./nano.nix
    ./nvim
    # ./vscode # NOTE: REF
  ];
}
