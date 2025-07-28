{...}: {

  services.picom = {
    enable = true;
    settings = {
      backend = "glx";
      vsync = true;
      opacity-rule = [
        "80:class_g = 'kitty'"
        "80:class_g = 'Code'"
      ];
    };
  };



}
