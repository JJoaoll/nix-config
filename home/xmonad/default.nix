{ config, pkgs, ... }:

{
#   xsession.windowManager.xmonad = {
#     enable = true;
#     enableContribAndExtras = true;  
#
#     config = ./xmonad.hs;
#
#     extraPackages = hpkgs: [
#       hpkgs.xmonad-contrib  
#       hpkgs.xmonad-extras  
#       hpkgs.xmobar        
#     ];
#   };
#
#   # home.file.".xmonad/build".executable = true;
#   # home.file.".xmonad/build".text = ''
#   #   #!/bin/sh
#   #   ${pkgs.xmonad-with-packages}/bin/xmonad --recompile
#   # '';
#
#   home.packages = with pkgs; [
#     xterm
#     haskellPackages.ghc  
#     dmenu               
#     scrot              
#   ];
}
