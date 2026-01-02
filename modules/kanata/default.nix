{ config, pkgs, ... }: {

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us-hyper"; 

    extraLayouts.us-hyper = {
      description = "US layout with Hyper Key on 202";
      languages = [ "eng" ];
      symbolsFile = pkgs.writeText "us-hyper" ''
      xkb_symbols "basic" {
        // Inclui o layout US padrão como base
        include "us(basic)" 

        // AQUI ESTÁ O TRUQUE:
        // Mapeia o código físico 202 (<I202>) para Hyper_L
        key <I202> { [ Hyper_L ] };

        // Define que o Mod3 é o Hyper_L
        modifier_map Mod3 { Hyper_L };
      };
      '';
    };
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


  services.xserver = {
    enable = true;
    # ... outras configs ...

    displayManager.sessionCommands = ''
      ${pkgs.xorg.xmodmap}/bin/xmodmap -e 'keycode 202 = Hyper_L' -e 'clear mod3' -e 'add mod3 = Hyper_L'
    '';
  };

}

