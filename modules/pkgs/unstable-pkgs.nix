{ config, inputs, pkgs, pkgsUnstable, ... }:
{
  # this allows you to access `pkgsUnstable` anywhere in your config
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  environment.systemPackages = [

    pkgsUnstable.emacs
    pkgsUnstable.sbcl

    pkgsUnstable.osu-lazer-bin
    #
    # pkgsUnstable.haskellPackages.ghc       
    # pkgsUnstable.haskellPackages.cabal-install
    # pkgsUnstable.haskellPackages.stack
    # pkgsUnstable.haskellPackages.haskell-language-server 

    pkgsUnstable.llvmPackages.bintools
    pkgsUnstable.cargo
    pkgsUnstable.rustc
    pkgsUnstable.rust-analyzer
    pkgsUnstable.rustfmt
    pkgsUnstable.clippy
    #pkgsUnstable.rustup

    pkgsUnstable.gcc 
    pkgsUnstable.clang-tools

    pkgsUnstable.python3
    pkgsUnstable.pyright   

    pkgsUnstable.nil      

  ];
}
