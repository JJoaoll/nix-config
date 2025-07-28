{ ... }: {
  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.kmonad = {
    enable = true;
    keyboards.myKMonadKeyboard = {
      device = "/dev/input/by-path/pci-0000:07:00.3-usb-0:4:1.0-event-kbd";	
      config = builtins.readFile ./layout.kbd;
    };
  };

  environment.sessionVariables = {
    XDG_SESSION_TYPE = "x11";
  };


}

