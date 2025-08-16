# shell.nix - Configuração completa para compilar XMonad no NixOS
{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  # Dependências de sistema (bibliotecas C, etc.)
  buildInputs = [
    # 1. Ferramentas de compilação Haskell
    # pkgs.cabal-install
    # pkgs.ghc

    # 2. Bibliotecas essenciais do X11
    pkgs.xorg.libX11
    pkgs.xorg.libXext
    pkgs.xorg.libXinerama
    pkgs.xorg.libXrandr
    pkgs.xorg.libXScrnSaver
    pkgs.xorg.libXdmcp

    # 3. Bibliotecas para fontes (Xft) e seus requisitos
    pkgs.xorg.libXft
    pkgs.fontconfig
    pkgs.freetype
    pkgs.expat # A que causou o erro atual
    pkgs.zlib

    # 4. Ferramentas auxiliares de build
    pkgs.pkg-config
  ];
}
