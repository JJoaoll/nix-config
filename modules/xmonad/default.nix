{ pkgs, ... }: { 

  services = { 
    displayManager = { 
      sddm.enable = false;
      defaultSession = "none+xmonad";
    };
  };

  services.xserver.windowManager.xmonad = { 
    enable = true;
    enableContribAndExtras = true;

  };

  environment.systemPackages = with pkgs; [
    wget # picom and rofi are in the home/i3..
    # TODO: move them..

    dmenu # just for beeing sure..
    xmobar


    xorg.xmodmap  # modmask3 to the xmonad

  ];

  # put some wallpaper with the "xwallpaper"
  # displayManager.sessionCommands = ''
  #   xwallpaper --zoom ~/walls/wall2.jpg
  # '';

}

