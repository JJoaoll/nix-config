{ xmonad-contexts, config, pkgs, ... }:

{
  # # services.xserver.displayManager.startx.enable = true;  # Habilita o startx
  # services.xserver.windowManager.xmonad = {
  #   enable = true;
  #   enableContribAndExtras = true;
  #   haskellPackages = pkgs.haskell.packages.ghc947;
  #
  #   flake = {
  #     enable = true;
  #     compiler = "ghc947";
  #   };
  #   config = builtins.readFile ./monad.hs;
  #   enableConfiguredRecompile = true;
  # };
}
