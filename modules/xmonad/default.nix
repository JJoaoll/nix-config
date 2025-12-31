{ pkgs, ... }: { 

  services.xserver.windowManager.xmonad = { 
    enable = true;
    enableContribAndExtras = true;
  };

  environment.systemPackages = with pkgs; [
    wget # picom and rofi are in the home/i3..
         # TODO: move them..

    dmenu # just for beeing sure..
    xmobar
  ];

  # put some wallpaper with the "xwallpaper"
  # displayManager.sessionCommands = ''
  #   xwallpaper --zoom ~/walls/wall2.jpg
  # '';

}

