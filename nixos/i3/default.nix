{ pkgs, ... }: { 

  services = { 
    displayManager = { 
      sddm.enable = false;
     # sddm.wayland = false;

      defaultSession = "none+i3"; 
    };

    xserver = {
      enable = true;
      # videoDrivers = [ "nvidia" ];
      # TODO: tablet

      # desktioManager.plasma6.enable = false;

      displayManager.lightdm = {
        enable = true;
	greeters.gtk.enable = true;
      };

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
  
  # environment.sessionVariables = {
  #   XDG_SESSION_TYPE = "X11";
  #
  # };
  };
}
