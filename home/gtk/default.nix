{ pkgs, ... }:

{
  gtk = {
    enable = true;

    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome.gnome-themes-extra;
    };

    iconTheme = {
      name = "Adwaita";
      package = pkgs.gnome.adwaita-icon-theme;
    };
    
    #TODO: change fonts
    font = {
      name = "Noto Sans";
      size = 11;
    };
  };

  home.packages = [
    pkgs.gnome.gnome-themes-extra  
    pkgs.gnome.adwaita-icon-theme 
  ];

}
