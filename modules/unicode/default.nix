{ config, pkgs, lib, ... }: 

let 

  gen = import ./xcompose/gen.nix;
  emoji_file = import ./xcompose/emoji.nix;
  emoji_keys = gen {keymaps = emoji_file; inherit lib;};
  myUser = "jjoaoll";
  unicodeComposeFiles = [
    # ./.unicodef/emoji.XCompose
    ./.unicodef/fonts.XCompose
    ./.unicodef/games.XCompose
    ./.unicodef/greek.XCompose
    ./.unicodef/lang.XCompose
    ./.unicodef/math.XCompose
    ./.unicodef/misc.XCompose
    ./.unicodef/thatex.XCompose
  ];

  combinedUnicodeComposeContent = lib.concatLines (
    lib.map builtins.readFile unicodeComposeFiles
  ) + emoji_keys;

  baseXComposeContent = ''
    include "%L"
  '';

  weird-solution = "<Multi_key><space> : \"\\\\\"";
  finalXComposeContent = "${baseXComposeContent}\n${combinedUnicodeComposeContent}\n${weird-solution}";

  combinedXComposeFile = pkgs.writeText "my-combined-xcompose" finalXComposeContent;



in {
  environment.sessionVariables = {
    XDG_SESSION_TYPE = "x11";
    XCOMPOSEFILE = "${config.users.users.${myUser}.home}/.XCompose"; 
  };

  system.activationScripts.copyXCompose = ''
    rm -rf ${config.users.users.${myUser}.home}/.unicodef
    rm -f ${config.users.users.${myUser}.home}/.XCompose

    cp ${combinedXComposeFile} ${config.users.users.${myUser}.home}/.XCompose

    chown -R ${myUser}:${config.users.users.${myUser}.group} ${config.users.users.${myUser}.home}/.XCompose
  '';
}

