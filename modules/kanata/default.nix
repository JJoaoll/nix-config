{ config, pkgs, lib, ... }: 
# let 
#   gen = import ./xcompose/gen.nix;
#   emoji_file = import ./xcompose/emoji.nix;
#   emoji_keys = gen {keymaps = emoji_file; inherit lib;};
#   myUser = "jjoaoll";
#   unicodeComposeFiles = [
#     # ./.unicodef/emoji.XCompose
#     ./.unicodef/fonts.XCompose
#     ./.unicodef/games.XCompose
#     ./.unicodef/greek.XCompose
#     ./.unicodef/lang.XCompose
#     ./.unicodef/math.XCompose
#     ./.unicodef/misc.XCompose
#     ./.unicodef/thatex.XCompose
#   ];
#
#   combinedUnicodeComposeContent = lib.concatLines (
#     lib.map builtins.readFile unicodeComposeFiles
#   ) + emoji_keys;
#
#   baseXComposeContent = ''
#     include "%L"
#   '';
#
#   finalXComposeContent = "${baseXComposeContent}\n${combinedUnicodeComposeContent}";
#
#   combinedXComposeFile = pkgs.writeText "my-combined-xcompose" finalXComposeContent;
#
# in {
{

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "compose:ralt";  
  };

  services.kanata = {
    enable = true;
    keyboards.my-keyboard = {
      devices = [ 
        "/dev/input/by-path/pci-0000:07:00.3-usb-0:4:1.0-event-kbd" 
      ];
      config = builtins.readFile ./layout.kbd;
      #TODO: configFile = 
    };
  };


}

