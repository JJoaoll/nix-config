{ config, pkgs, ...}: {

  programs.git = {
    enable = true;

    userName = "JJoaoll";
    userEmail= "joaoduos@gmail.com";

    extraConfig = {
      init = {
        defaultBranch = "main";
      };
    };

  };


}



