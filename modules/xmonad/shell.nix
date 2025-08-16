# /etc/nixos/modules/xmonad/shell.nix

let
  pkgs = import <nixpkgs> {};

  ghcVersion = "ghc947";

  # CORREÇÃO: Apontamos para o compilador GHC DENTRO do conjunto de pacotes
  ghc = pkgs.haskell.packages.${ghcVersion}.ghc;

  # Agora a linha abaixo funciona, pois 'ghc' é o compilador certo
  haskellEnv = ghc.withPackages (ps: with ps; [
    xmonad
    xmonad-contrib
    X11
    containers
  ]);

in
pkgs.mkShell {
  name = "xmonad-lsp-env";

  buildInputs = [
    haskellEnv
    pkgs.haskell-language-server
    pkgs.cabal-install
    pkgs.hlint
    pkgs.fourmolu
  ];

  shellHook = ''
    clear
    echo -e "\n \x1b[32;1m› Bem-vindo ao ambiente de desenvolvimento do XMonad!\x1b[0m"
    echo ""
    echo "  Ferramentas disponíveis:"
    echo "  - GHC ${ghc.version}"
    echo "  - Haskell Language Server (HLS)"
    echo "  - hlint (linter)"
    echo "  - fourmolu (formatador)"
    echo ""
  '';
}
