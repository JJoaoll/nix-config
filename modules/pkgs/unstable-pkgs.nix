{ config, inputs, pkgs, pkgsUnstable, ... }:
{
  # this allows you to access `pkgsUnstable` anywhere in your config
  _module.args.pkgsUnstable = import inputs.nixpkgs-unstable {
    inherit (pkgs.stdenv.hostPlatform) system;
    inherit (config.nixpkgs) config;
  };

  environment.systemPackages = [
    pkgsUnstable.osu-lazer-bin
    pkgsUnstable.haskellPackages.ghc       
    pkgsUnstable.haskellPackages.cabal-install
    pkgsUnstable.haskellPackages.stack
    pkgsUnstable.haskellPackages.haskell-language-server 

    pkgsUnstable.llvmPackages.bintools
    pkgsUnstable.cargo
    pkgsUnstable.rustc


  ];
}
