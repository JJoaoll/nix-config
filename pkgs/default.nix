  { pkgs, ... }: 

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Packages
  # -----------------------------------------------------------------
  environment.systemPackages = with pkgs; [ 

    kdePackages.kdenlive libsForQt5.kdenlive

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
    agda
    coq
    gcc
    # lean4 
    elan z3
    #go gopls
    #rustc cargo rust-analyzer rustfmt openssl pkg-config
    python3
    haskellPackages.ghc       
    haskellPackages.cabal-install
    haskellPackages.haskell-language-server 
    (haskellPackages.ghcWithPackages (p:
       
       with p; [
       
       cabal-install
       
       GLUT
       
   ])) 
    haskellPackages.xmonad
    haskellPackages.xmonad-contrib
    # haskellPackages.xmonad-eval
    haskellPackages.xmonad-dbus
    haskellPackages.xmonad-utils
    haskellPackages.xmonad-volume
    haskellPackages.xmonad-extras
    # haskellPackages.xmonad-wallpaper
    haskellPackages.GLHUI

    xorg.libX11
    xorg.libXft
    xorg.libXinerama
    xorg.libXrandr
    xprintidle-ng
    pkg-config

    #--js--things-----------
    nodejs yarn pnpm
 
    #typescript nodePackages.ts-node
    #nodePackages.nodemon
    #eslint
    #nodePackages.prettier
    #vite
    #----------------------

    #docker-compose
    
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
