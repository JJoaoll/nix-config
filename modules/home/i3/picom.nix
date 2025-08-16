{ pkgs, ... }:

{
  services.picom = {
    enable = true;
    
    inactiveOpacity = 0.9;
    activeOpacity = 1.0;
    
    #TODO: readjust it, maybe?
    opacityRules = [
      # "80:class_g = 'kitty' && focused"
      # "70:class_g = 'kitty' && !focused"
      # "80:class_g = 'Code'"
      # "85:class_g = 'firefox' && !focused"
      # "90:class_g = 'firefox' && focused"
    ];
    
    settings = {
      backend = "glx";
      vsync = true;
      
      shadow = true;
      shadow-radius = 7;
      shadow-offset-x = -5;
      shadow-offset-y = -5;
      shadow-opacity = 0.3;
      
      shadow-exclude = [
        "name = 'Notification'"
        "class_g = 'Conky'"
        "class_g ?= 'Notify-osd'"
        "_GTK_FRAME_EXTENTS@:c"
      ];
    };
  };
}
