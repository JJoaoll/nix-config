{ config, lib, pkgs, ... }: 

let 
  nvim_dir_config = "/etc/nixos/modules/home/editor/nvim/config";
in {
  programs.neovim = {
    enable = true;
    extraLuaConfig = ''
      vim.opt.runtimepath:prepend("${nvim_dir_config}")
      dofile("${nvim_dir_config}/init.lua")
    '';
  };




}
