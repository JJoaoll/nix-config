{ pkgs, ... }: { 

  services.displayManager = {
    cosmic-greeter.enable = true;
    cosmic-greeter.package = true;

    cosmic.enable = true;
  };


  services.desktopManager.cosmic.enable = true;
  
  


}

