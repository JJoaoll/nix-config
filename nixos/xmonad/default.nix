{ pkgs, ... }:

#TODO: TRAZER O XMONAD PRA UMA PASTA DENTRO DO /etc/NIXOS!

{

imports = [
  ./picom.nix


];

  # Configuração do XMonad
  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    extraPackages = hpkgs: [
      hpkgs.xmonad-contrib
      hpkgs.xmonad-extras
      hpkgs.xmobar
    ];

    config = ./xmonad.hs;  
    enableConfiguredRecompile = true;

  };


  # Pacotes úteis
  environment.systemPackages = with pkgs; [
    # Haskell
    haskellPackages.ghc
    haskellPackages.cabal-install

    # XMonad essentials
    dmenu
    rofi
    picom
    feh
    scrot
    xdotool
    lxappearance
    
    libpulseaudio  # Se usar PulseAudio

    expat
    fontconfig
    pkg-config
    zlib
    # alsa-lib
    xorg.libX11
    xorg.libXrandr
    xorg.libXinerama

    # Ferramentas de áudio
    # pavucontrol  # Mixer de volume gráfico
    # pamixer      # Controle de volume via termi

    # Ferramentas Haskell
    ghc
    haskellPackages.ghc
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    haskellPackages.xmonad-extras
    haskellPackages.cabal-install
  ];

}
