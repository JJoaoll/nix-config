{ pkgs, nixpkgs-unstable, ... }: {

  # TODO: REMOVE THE BAT ALIAS
  imports = [
    ./unstable-pkgs.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # Packages
  # -----------------------------------------------------------------
  environment.systemPackages = with pkgs; [ 
    

    # deus me dibre
    # ocaml opam 
    # ocamlPackages.utop

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

    # osu-lazer
    # osu-lazer-bin
    # nixpkgs-unstable.osu-lazer-bin


    kdePackages.kdenlive libsForQt5.kdenlive 
    discord

    kmonad 
    xterm dmenu
    evtest

    # Terminal 
    #im-config
    lsd tree bat tldr

    # TUI 
  smassh typioca # try to write fast

    ugm          # info about UNIX things in ur machine
    # bluetuithS # bluetooth manager
    gitu lazygit # deals with git stuff # git is inpired by magit
    tig          # text-mode interface for git  
    meteor-git   # write convencional commits
    gitui        # TUI for git written in rust
    mani         # manages multiple repositories
    git-who      # git blame for file trees
    gh-dash      # interactive github dashboard 

    sshs         # terminal user interface for SSH
    ggh          # recall ur ssh sessions

    flamelens    # future uses for watch performance
    atop btop    # monitor for linux systems (btop is 🤌)

    lazyjournal  # jornalctl TUI (logs)
    hwatch       # better `watch`

    gtrash       # interact with trash
    s-tui        # CPU stress and monitoring utility

    # havn       # A fast configurable port scanner with reasonable defaults.
    lazysql      # bad-database management tool
    rainfrog     # the same but for postgres
    harlequin    # sql IDEIDE  for terminal
    gobang       # more database stuff  

    vifm         # file manager with curses interface
    netop        # network topology visualizer (not working quite well)
    bmon         # network bandwidth monitor and rate estimator in a human way
    slurm-nm     # realtime traffic statistics for network interfaces

    slumber      # no insomnia here
    atac         # no postman here
    goaccess     # real-time web log analyzer and interactive viewer
    posting      # a powerful HTTP client that lives in your terminal.

    mdns-scanner # scan a network and create a list of IPs and awssociated hostnames
    mitmproxy    # a TLS/SSL-capable interception HTTP proxy.
    httplab      # Inspect HTTP requests and mock their responses in the terminal.

    tldr         # to long dont read

    taskwarrior-tui # TODO: learn it..
    hours        # another task controller but it take the time in count
    dijo         # scriptable, curses-bases, HABIT checker!
    nap          # snippets including code! ❤ 
    rucola       # markdown note manager!
    frogmouth    # another markdown browser 
    calcure      # customizable calendar and task manager
    cmus         # console music player for Unix-like OSs
    castero      # podcast client

    wiper        # disk analyser and cleanup tool
    sttr         # useless CLI/TUI for performing string transformations..
    fx           # JSON visualizer
    otree        # JSON/YAML/TOML visualizer

    rexi         # pipe a file and then test regexs
    oxker        # view and control docker containers
    dry          # docker manager
    dive         # explore each layer in a docker image

    tre-command  # alternative to tree
    zellij       # alternative to tmux 
    yazi         # alternative to ranger
    regname      # (rename things in the right way) mass rename written in Rust

    blink        # blink is a tiny virtual machine for running x86-64 Linux binaries on various POSIX systems.
    fq           # useless. Its just for binary things
    heh          # terminal UI to edit bytes by the nibble


    crates-tui   # TUI for exploring crates.io

    tz           # A terminal based timezone helper
    # atuin looks cool but to use it..
    # cava only with alsa


    tdf          # pure pdf viewer


    slides       # never canva again
    aerc         # email client
    youtube-tui  # not working why?


    porsmo       # simple and bad pomodoro TODO: do a better one
    mapscii      # the world map



    ## look up
    zoxide dua jless
    trippy broot nix-tree










    atool
    neovim xclip lua-language-server
    # emacs 
    ripgrep fd clang ispell jansson cmake binutils gnumake libvterm libtool
    vscode 
    nixpkgs-fmt nixd direnv  

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
    haskellPackages.stack
    haskellPackages.haskell-language-server 

    (haskellPackages.ghcWithPackages (p:
       
       with p; [
       
       cabal-install
       
       GLUT
       
   ])) 
    haskellPackages.GLHUI haskellPackages.alex
    haskellPackages.GLHUI haskellPackages.happy

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


# pacakge urself: wiremix, Gmail-TUi, youtube music??
