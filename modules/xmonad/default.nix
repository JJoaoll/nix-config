{ pkgs, ... }: {

  services.xserver. windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    flake  = {
      enable   = true;
      compiler = "ghc947";
    };
    config = builtins.readFile ./xmonad-config/src/xmonad.hs;
    enableConfiguredRecompile = true;
  };

  # environment.systemPackages = with pkgs; [
  #   haskell-language-server
  #   cabal-install
  #
  #   (haskell.packages.ghc947.ghcWithPackages (ps: with ps; [
  #     xmonad
  #     xmonad-contrib
  #     X11
  #     containers
  #   ]))
  # ];
  

}
