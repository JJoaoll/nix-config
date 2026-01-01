{ config, pkgs, lib, ... }: 
{

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "compose:ralt";  
  };

  services.kanata = {
    enable = true;

    # TODO: UNSAFE UNSAFE UNSAFE
    package = pkgs.kanata.override { withCmd = true; };

    keyboards.my-keyboard = {
      devices = [ 
        "/dev/input/by-path/pci-0000:07:00.3-usb-0:4:1.0-event-kbd" 
      ];

    extraDefCfg = ''
          process-unmapped-keys yes
          danger-enable-cmd yes

    '';
    config = builtins.readFile ./layout.kbd;
      #TODO: configFile = 
    };
  };


}

