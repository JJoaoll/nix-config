{ pkgs, ... }: {

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Packages
  # -----------------------------------------------------------------
  environment.systemPackages = with pkgs; [ 

    # am i using this?
    exercism
    elmPackages.elm

    gleam
    vscode-extensions.gleam.gleam
    vimPlugins.nvim-treesitter-parsers.gleam

    insomnia
    beamMinimal27Packages.elixir_1_17
    beamMinimal27Packages.elixir
    beamMinimal27Packages.elixir-ls
    vscode-extensions.elixir-lsp.vscode-elixir-ls
    postgresql

    osu-lazer-bin


    kdePackages.kdenlive libsForQt5.kdenlive 
    discord

    kmonad 
    xterm dmenu
    evtest

    # Terminal 
    #im-config
    lsd tree bat tldr
    zellij

    yazi

    atool
    neovim xclip lua-language-server
    emacs ripgrep fd clang ispell jansson cmake binutils gnumake libvterm libtool
    vscode

    git
    #xorg.xmodmap xorg.xkbcomp
    pomodoro-gtk
    #kbd
    tree-sitter

    # Programming Languages
    erlang rebar3 erlfmt
    gcc
    elan z3
    python3
    haskellPackages.ghc       
    haskellPackages.cabal-install
    haskellPackages.haskell-language-server 
    (haskellPackages.ghcWithPackages (p:
       
       with p; [
       
       cabal-install
       
       GLUT
       
   ])) 
    haskellPackages.GLHUI

    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    xorg.libXrandr
    xprintidle-ng
    pkg-config

    elixir_1_16
    erlang_26
    nodejs_20 
    inotify-tools
    # gleam
    # purescript spago psc-package #purescript
    nodejs yarn pnpm nodemon # postman
    # docker
    # docker-compose
    
    gnome-tweaks
    gnome-browser-connector
    
    # VM
    gnome-boxes
    virt-viewer
    spice
    spice-gtk

    #(import (builtins.fetchTarball "https://github.com/notgne2/osu-nixos/archive/refs/heads/master.tar.gz")).packages.${pkgs.system}.osu-lazer
    # GAMMING 
    gamemode gamescope
    steam steam-run protonup
    pkgsi686Linux.libGL pkgsi686Linux.glibc pkgsi686Linux.zlib
    protonup-qt vulkan-loader vulkan-tools
    # STREAMING
    obs-studio
  ]; 


  services.postgresql = {
    enable = true;
    package = pkgs.postgresql_16; 
  };

  fonts = {
    fontDir.enable = true;
    enableDefaultPackages = true;
    packages = with pkgs; [
      fira-code
      jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-emoji
      nerd-fonts.fira-code
      nerd-fonts.hack
      nerd-fonts.jetbrains-mono
    ];
  };


}
