{ pkgs, ... }: { 

  services = { 
    displayManager = { 
      sddm.enable = false;
     # sddm.wayland = false;

      defaultSession = "none+i3"; 
    };

    xserver = {
      enable = true;
      videoDrivers = [ "nvidia" ];

      monitorSection = ''
        Option "PreferredMode" "1920x1080_360.00"
      '';
      screenSection = ''
        Option "DPMS" "false"
      '';
      # TODO: tablet

      # desktioManager.plasma6.enable = false;

      displayManager.lightdm = {
        enable = true;
        greeters.gtk.enable = true;
      };

      displayManager.sessionCommands = ''
        xrandr --output DP-0 --mode 1920x1080 --rate 360
      '';

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [ 

          flameshot
          polybar polybarFull
          i3status
          i3-volume
          i3lock
          i3blocks
        ];
      };
    };

  };

}

